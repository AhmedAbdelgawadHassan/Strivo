import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:strivo/core/routing/app_routes.dart';
import 'package:strivo/core/utils/app_assets.dart';
import 'package:strivo/core/utils/app_colors.dart';
import 'package:strivo/core/utils/app_sizes.dart';
import 'package:strivo/features/fitnessProfileSetup/presentation/manager/cubits/fitness_setup_cubit.dart';
import 'package:strivo/features/fitnessProfileSetup/presentation/views/widgets/bmi_insignts_card.dart';
import 'package:strivo/features/fitnessProfileSetup/presentation/views/widgets/body_profile_summary.dart';
import 'package:strivo/features/fitnessProfileSetup/presentation/views/widgets/continue_button.dart';
import 'package:strivo/features/fitnessProfileSetup/presentation/views/widgets/setup_progress_indicator.dart';

class ReviewProfileView extends StatelessWidget {
  const ReviewProfileView({super.key});

  // 'male' -> 'Male'
  String _formatGender(String? gender) {
    if (gender == null || gender.isEmpty) return '-';
    return gender[0].toUpperCase() + gender.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: BlocBuilder<FitnessSetupCubit, FitnessSetupState>(
            builder: (context, state) {
              final profile = state.profile;

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gap(5.h),
                    const SetupProgressIndicator(currentStep: 3, totalSteps: 5),
                    Gap(25.h),
                    Row(
                      children: [
                        Text(
                          'Looking Good!',
                          style: TextStyle(
                            fontSize: AppSizes.font20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Gap(5.w),
                        SvgPicture.asset(Assets.images.buildMuscleLogo),
                      ],
                    ),
                    Gap(10.h),
                    Text(
                      "Here's your body profile",
                      style: TextStyle(
                        fontSize: AppSizes.font14,
                        color: AppColors.secondaryTextColor,
                      ),
                    ),
                    Gap(30.h),
                    BodyProfileSummary(
                      gender: _formatGender(profile.gender),
                      age: profile.age ?? 0,
                      height: profile.height ?? 0,
                      weight: profile.weight ?? 0,
                    ),
                    Gap(20.h),
                    BmiInsightsCard(bmi: profile.bmi ?? 0),
                    Gap(20.h),
                    ContinueButton(
                      onPressed: () => context.push(AppRoutes.fitnessGoal),
                    ),
                    Gap(12.h),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}