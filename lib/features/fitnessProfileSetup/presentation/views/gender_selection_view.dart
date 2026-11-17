import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:strivo/core/routing/app_routes.dart';
import 'package:strivo/core/utils/app_assets.dart';
import 'package:strivo/core/utils/app_colors.dart';
import 'package:strivo/core/utils/app_sizes.dart';
import 'package:strivo/features/fitnessProfileSetup/data/models/gender_model.dart';
import 'package:strivo/features/fitnessProfileSetup/presentation/manager/cubits/fitness_setup_cubit.dart';
import 'package:strivo/features/fitnessProfileSetup/presentation/views/widgets/continue_button.dart';
import 'package:strivo/features/fitnessProfileSetup/presentation/views/widgets/gender_card.dart';
import 'package:strivo/features/fitnessProfileSetup/presentation/views/widgets/setup_progress_indicator.dart';

class GenderSelectionView extends StatelessWidget {
  const GenderSelectionView({super.key});

  static final List<GenderModel> genderModels = [
    GenderModel(title: 'Male', value: 'male', image: Assets.images.male),
    GenderModel(title: 'Female', value: 'female', image: Assets.images.female),
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
                  const SetupProgressIndicator(currentStep: 1, totalSteps: 5),
                  Gap(25.h),
                  Text(
                    "What's your gender?",
                    style: TextStyle(
                      fontSize: AppSizes.font20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Gap(10.h),
                  Text(
                    'This helps us customize your plan',
                    style: TextStyle(
                      fontSize: AppSizes.font14,
                      color: AppColors.secondaryTextColor,
                    ),
                  ),
                  Gap(30.h),
                  Row(
                    children: genderModels.map((gender) {
                      return Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () => context
                                .read<FitnessSetupCubit>()
                                .selectGender(gender.value),
                            child: GenderCard(
                              genderModel: gender,
                              isActive: state.profile.gender == gender.value,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Expanded(
                        child: ContinueButton(
                          onPressed: state.canContinueGender
                              ? () => context.push(AppRoutes.bodyMeasurements)
                              : null,
                        ),
                      ),
                    ],
                  ),
                  Gap(20.h),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}