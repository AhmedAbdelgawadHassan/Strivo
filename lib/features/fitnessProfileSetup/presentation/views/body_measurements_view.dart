import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:strivo/core/routing/app_routes.dart';
import 'package:strivo/core/utils/app_assets.dart';
import 'package:strivo/core/utils/app_colors.dart';
import 'package:strivo/core/utils/app_sizes.dart';
import 'package:strivo/features/fitnessProfileSetup/presentation/manager/cubits/fitness_setup_cubit.dart';
import 'package:strivo/features/fitnessProfileSetup/presentation/views/widgets/continue_button.dart';
import 'package:strivo/features/fitnessProfileSetup/presentation/views/widgets/measurementTextFormField.dart';
import 'package:strivo/features/fitnessProfileSetup/presentation/views/widgets/setup_progress_indicator.dart';

class BodyMeasurementsView extends StatefulWidget {
  const BodyMeasurementsView({super.key});

  @override
  State<BodyMeasurementsView> createState() => _BodyMeasurementsViewState();
}

class _BodyMeasurementsViewState extends State<BodyMeasurementsView> {
  late final TextEditingController ageController;
  late final TextEditingController heightController;
  late final TextEditingController weightController;

  @override
  void initState() {
    super.initState();
    // لو المستخدم رجع للصفحة، نملّى الحقول بالقيم المحفوظة
    final profile = context.read<FitnessSetupCubit>().state.profile;
    ageController = TextEditingController(text: profile.age?.toString() ?? '');
    heightController =
        TextEditingController(text: profile.height?.toString() ?? '');
    weightController =
        TextEditingController(text: profile.weight?.toString() ?? '');
  }

  @override
  void dispose() {
    ageController.dispose();
    heightController.dispose();
    weightController.dispose();
    super.dispose();
  }

  // بتبعت القيم الحالية للـ Cubit مع كل تغيير
  void _onChanged() {
    context.read<FitnessSetupCubit>().updateMeasurements(
          age: int.tryParse(ageController.text.trim()),
          height: double.tryParse(heightController.text.trim()),
          weight: double.tryParse(weightController.text.trim()),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.vertical -
                    20.h,
              ),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gap(5.h),
                    const SetupProgressIndicator(currentStep: 2, totalSteps: 5),
                    Gap(25.h),
                    Text(
                      'Your Measurements',
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
                    MeasurementTextFormField(
                      label: 'Age',
                      hint: 'Enter your age',
                      unit: 'Years',
                      image: Assets.images.ageLogo,
                      controller: ageController,
                      keyboardType: TextInputType.number,
                      onChanged: (_) => _onChanged(),
                      validator: (value) {
                        final age = int.tryParse(value ?? '');
                        if (age == null) return 'Please enter your age';
                        if (age < 10 || age > 100) return 'Enter a valid age';
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
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      onChanged: (_) => _onChanged(),
                      validator: (value) {
                        final height = double.tryParse(value ?? '');
                        if (height == null) return 'Please enter your height';
                        if (height < 100 || height > 250) {
                          return 'Enter a valid height';
                        }
                        return null;
                      },
                    ),
                    Gap(22.h),
                    MeasurementTextFormField(
                      label: 'Weight',
                      hint: 'Enter your weight',
                      unit: 'kg',
                      image: Assets.images.weight1,
                      controller: weightController,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      onChanged: (_) => _onChanged(),
                      validator: (value) {
                        final weight = double.tryParse(value ?? '');
                        if (weight == null) return 'Please enter your weight';
                        if (weight < 30 || weight > 300) {
                          return 'Enter a valid weight';
                        }
                        return null;
                      },
                    ),
                    const Spacer(),
                    BlocBuilder<FitnessSetupCubit, FitnessSetupState>(
                      buildWhen: (p, c) =>
                          p.canContinueMeasurements != c.canContinueMeasurements,
                      builder: (context, state) {
                        return ContinueButton(
                          onPressed: state.canContinueMeasurements
                              ? () => context.push(AppRoutes.reviewProfile)
                              : null,
                        );
                      },
                    ),
                    Gap(20.h),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}