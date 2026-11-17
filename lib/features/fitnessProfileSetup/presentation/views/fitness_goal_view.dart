import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:strivo/core/routing/app_routes.dart';
import 'package:strivo/core/utils/app_assets.dart';
import 'package:strivo/core/utils/app_colors.dart';
import 'package:strivo/core/utils/app_sizes.dart';
import 'package:strivo/features/fitnessProfileSetup/data/models/fitness_goal_model.dart';
import 'package:strivo/features/fitnessProfileSetup/presentation/manager/cubits/fitness_setup_cubit.dart';
import 'package:strivo/features/fitnessProfileSetup/presentation/views/widgets/continue_button.dart';
import 'package:strivo/features/fitnessProfileSetup/presentation/views/widgets/fitness_goal_item.dart';
import 'package:strivo/features/fitnessProfileSetup/presentation/views/widgets/setup_progress_indicator.dart';

class FitnessGoalView extends StatelessWidget {
  const FitnessGoalView({super.key});

  static final List<FitnessGoalModel> fitnessGoalModels = [
    FitnessGoalModel(
      image: Assets.images.loseWeightLogo,
      title: 'Lose Weight',
      subtitle: 'Burn Fat & Get Lean',
      value: 'lose_weight',
    ),
    FitnessGoalModel(
      image: Assets.images.buildMuscleLogo,
      title: 'Build Muscle',
      subtitle: 'Gain Strength & Size',
      value: 'build_muscle',
    ),
    FitnessGoalModel(
      image: Assets.images.stayFitLogo,
      title: 'Stay Fit',
      subtitle: 'Maintain Current Shape',
      value: 'stay_fit',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: BlocBuilder<FitnessSetupCubit, FitnessSetupState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(5.h),
                  const SetupProgressIndicator(currentStep: 4, totalSteps: 5),
                  Gap(25.h),
                  Text(
                    "What's your goal?",
                    style: TextStyle(
                      fontSize: AppSizes.font20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Gap(10.h),
                  Text(
                    "We'll build your plan around this",
                    style: TextStyle(
                      fontSize: AppSizes.font14,
                      color: AppColors.secondaryTextColor,
                    ),
                  ),
                  Gap(30.h),
                  Column(
                    children: fitnessGoalModels.map((goal) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12.r),
                          onTap: () => context
                              .read<FitnessSetupCubit>()
                              .selectGoal(goal.value),
                          child: FitnessGoalItem(
                            fitnessGoalModel: goal,
                            isActive: state.profile.goal == goal.value,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const Spacer(),
                  ContinueButton(
                    // null = الزرار متعطل
                    onPressed: state.canContinueGoal
                        ? () => context.push(AppRoutes.activityLevelView)
                        : null,
                  ),
                  Gap(12.h),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}