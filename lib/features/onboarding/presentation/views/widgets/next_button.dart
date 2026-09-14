import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:strivo/core/utils/app_colors.dart';
import 'package:strivo/core/utils/app_sizes.dart';

class NextButton extends StatelessWidget {
  const NextButton({super.key, required this.onPressed, required this.text});
  final VoidCallback onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 10),
        backgroundColor: AppColors.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radius12),
        ),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: TextStyle(
              color: AppColors.primaryTextColor,
              fontSize: AppSizes.font20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Gap(10.w),
         Icon(Icons.arrow_forward_ios, color: AppColors.primaryTextColor,)
        ],
      ),
    );
  }
}
