import 'package:flutter/material.dart';
import 'package:strivo/core/utils/app_colors.dart';
import 'package:strivo/core/utils/app_sizes.dart';

class SkipButton extends StatelessWidget {
  const SkipButton({super.key, required this.onPressed});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        overlayColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.radius12)),
      ),
      onPressed: onPressed,
      child: Text(
        'Skip',
        style: TextStyle(
          color: AppColors.secondaryTextColor,
          fontSize: AppSizes.font16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
