import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:strivo/core/utils/app_colors.dart';
import 'package:strivo/core/utils/app_sizes.dart';
import 'package:strivo/features/fitnessProfileSetup/data/models/activity_level_model.dart';
import 'package:strivo/features/fitnessProfileSetup/presentation/manager/cubits/fitness_setup_cubit.dart';
import 'package:strivo/features/fitnessProfileSetup/presentation/manager/cubits/user_profile_cubit.dart';
import 'package:strivo/features/fitnessProfileSetup/presentation/views/widgets/activity_level_item.dart';
import 'package:strivo/features/fitnessProfileSetup/presentation/views/widgets/continue_button.dart';
import 'package:strivo/features/fitnessProfileSetup/presentation/views/widgets/setup_progress_indicator.dart';
import 'package:strivo/test_view.dart';

class ActivityLevelView extends StatelessWidget {
  const ActivityLevelView({super.key});

  static final List<ActivityLevelModel> activityLevelModels = [
    ActivityLevelModel(
      title: 'Sedentary',
      subtitle: 'Little To No Exercise',
      value: 'sedentary',
    ),
    ActivityLevelModel(
      title: 'Lightly Active',
      subtitle: '1-2 Days/Week',
      value: 'lightly_active',
    ),
    ActivityLevelModel(
      title: 'Moderate',
      subtitle: '3-5 Days/Week',
      value: 'moderate',
    ),
    ActivityLevelModel(
      title: 'Active',
      subtitle: '6-7 Days/Week',
      value: 'active',
    ),
    ActivityLevelModel(
      title: 'Very Active',
      subtitle: 'Athlete Level',
      value: 'very_active',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocListener<FitnessSetupCubit, FitnessSetupState>(
      listenWhen: (p, c) => p.saved != c.saved || p.error != c.error,
      listener: (context, state) {
        if (state.saved) {
          // 1) سلّم البيانات للـ cubit العام (للـ Home)
          context.read<UserProfileCubit>().setProfile(state.profile);
         Navigator.push(context, MaterialPageRoute(builder: (context) => TestView(),));

        } else if (state.error != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error!)),
          );
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: BlocBuilder<FitnessSetupCubit, FitnessSetupState>(
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gap(5.h),
                    const SetupProgressIndicator(currentStep: 5, totalSteps: 5),
                    Gap(25.h),
                    Text(
                      'Activity Level',
                      style: TextStyle(
                        fontSize: AppSizes.font20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Gap(10.h),
                    Text(
                      'How active are you currently?',
                      style: TextStyle(
                        fontSize: AppSizes.font14,
                        color: AppColors.secondaryTextColor,
                      ),
                    ),
                    Gap(30.h),
                    Column(
                      children: activityLevelModels.map((level) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.h),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12.r),
                            onTap: () => context
                                .read<FitnessSetupCubit>()
                                .selectActivityLevel(level.value),
                            child: ActivityLevelItem(
                              activityLevelModel: level,
                              isActive:
                                  state.profile.activityLevel == level.value,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const Spacer(),
                    ContinueButton(
                      onPressed: (state.canCompleteSetup && !state.isSaving)
                          ? () {
                            context.read<FitnessSetupCubit>().completeSetup();
                          }
                              
                          : null,
                    ),
                    Gap(12.h),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}