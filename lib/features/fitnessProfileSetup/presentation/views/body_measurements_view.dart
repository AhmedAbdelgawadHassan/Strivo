import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:strivo/core/routing/app_routes.dart';
import 'package:strivo/core/utils/app_assets.dart';
import 'package:strivo/core/utils/app_colors.dart';
import 'package:strivo/core/utils/app_sizes.dart';
import 'package:strivo/features/fitnessProfileSetup/presentation/views/widgets/continue_button.dart';
import 'package:strivo/features/fitnessProfileSetup/presentation/views/widgets/measurementTextFormField.dart';
import 'package:strivo/features/fitnessProfileSetup/presentation/views/widgets/setup_progress_indicator.dart';

class BodyMeasurementsView extends StatefulWidget {
  const BodyMeasurementsView({super.key});

  @override
  State<BodyMeasurementsView> createState() => _BodyMeasurementsViewState();
}

class _BodyMeasurementsViewState extends State<BodyMeasurementsView> {
  final ageController = TextEditingController();
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 12.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(5.h),
              SetupProgressIndicator(currentStep: 2, totalSteps: 5),
              Gap(25.h),
              Text(
                "Your Measurements",
                style: TextStyle(
                  fontSize: AppSizes.font20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Gap(10.h),
              Text(
                'Help us calculate your needs',
                style: TextStyle(
                  fontSize: AppSizes.font14,
                  color: AppColors.secondaryTextColor,
                ),
              ),
              Gap(30.h),
              Column(
                children: [
                  MeasurementTextFormField(
                    label: 'Age',
                    hint: 'Enter your age',
                    unit: 'Years',
                    image: Assets.images.ageLogo,
                    controller: ageController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your age';
                      }

                      final age = int.tryParse(value);

                      if (age == null || age < 10 || age > 100) {
                        return 'Enter a valid age';
                      }

                      return null;
                    },
                  ),

                  Gap(22.h),

                  MeasurementTextFormField(
                    label: 'Height',
                    hint: 'Enter your height',
                    unit: 'cm',
                    image: Assets.images.heightLogo,
                    controller: heightController,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    validator: (value) {
                      final height = double.tryParse(value ?? '');

                      if (height == null) {
                        return 'Please enter your height';
                      }

                      if (height < 100 || height > 250) {
                        return 'Enter a valid height';
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 22),

                  MeasurementTextFormField(
                    label: 'Weight',
                    hint: 'Enter your weight',
                    unit: 'kg',
                    image: Assets.images.weight1,
                    controller: weightController,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    validator: (value) {
                      final weight = double.tryParse(value ?? '');

                      if (weight == null) {
                        return 'Please enter your weight';
                      }

                      if (weight < 30 || weight > 300) {
                        return 'Enter a valid weight';
                      }

                      return null;
                    },
                  ),
                ],
              ),
              Spacer(),
              ContinueButton(
                onPressed: () {
                  context.push(AppRoutes.reviewProfile);
                },
              ),
              Gap(20.h),
            ],
          ),
        ),
      ),
    );
  }
}
