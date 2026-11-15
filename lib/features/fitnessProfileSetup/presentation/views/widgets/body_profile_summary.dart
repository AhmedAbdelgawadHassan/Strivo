
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strivo/core/utils/app_colors.dart';
import 'package:strivo/core/utils/app_sizes.dart';

class BodyProfileSummary extends StatelessWidget {
  final String gender;
  final int age;
  final double height;
  final double weight;

  const BodyProfileSummary({
    super.key,
    required this.gender,
    required this.age,
    required this.height,
    required this.weight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:  EdgeInsets.all(16),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppColors.secondaryTextColor,
            blurRadius: 10
          )
        ],
        color: AppColors.surfaceColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Colors.white.withOpacity(0.5),
        ),
      ),
      child: Column(
        children: [
          _item('Gender', gender),
          _item('Age', '$age Years'),
          _item('Height', '${height.toStringAsFixed(0)} cm'),
          _item('Weight', '${weight.toStringAsFixed(0)} kg'),
        ],
      ),
    );
  }

  Widget _item(String title, String value) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style:  TextStyle(
              color: Color(0xFF999999),
              fontSize: AppSizes.font16,
            ),
          ),
          Text(
            value,
            style:  TextStyle(
              color: Colors.white,
              fontSize: AppSizes.font16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
