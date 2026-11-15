
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:strivo/core/utils/app_colors.dart';
import 'package:strivo/core/utils/app_sizes.dart';

class SetupProgressIndicator extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const SetupProgressIndicator({
    super.key,
    required this.currentStep,
    required this.totalSteps,
  });

  @override
  Widget build(BuildContext context) {
    final progress = currentStep / totalSteps;

    return Column(
      children: [
        Text(
          '$currentStep/$totalSteps',
          style:  TextStyle(
            color: Colors.grey,
            fontSize: AppSizes.font14,
            fontWeight: FontWeight.w500,
          ),
        ),
    
        Gap(10.h),
    
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 3.h,
            backgroundColor:  Colors.white70,
            valueColor:  AlwaysStoppedAnimation<Color>(
              AppColors.primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
