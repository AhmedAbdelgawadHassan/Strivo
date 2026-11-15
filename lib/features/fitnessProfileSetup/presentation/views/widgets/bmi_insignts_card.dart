
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:strivo/core/utils/app_colors.dart';
import 'package:strivo/core/utils/app_sizes.dart';

class BmiInsightsCard extends StatelessWidget {
  final double bmi;

  const BmiInsightsCard({
    super.key,
    required this.bmi,
  });

  static  Color background = AppColors.surfaceColor;
  static const Color primary = AppColors.primaryColor;

  String get bmiStatus {
    if (bmi < 16) return 'Severe Thinness';
    if (bmi < 17) return 'Moderate Thinness';
    if (bmi < 18.5) return 'Mild Thinness';
    if (bmi < 25) return 'Normal Weight';
    if (bmi < 30) return 'Overweight';
    if (bmi < 35) return 'Obesity Class I';
    if (bmi < 40) return 'Obesity Class II';
    return 'Obesity Class III';
  }

  String get bmiDescription {
    if (bmi < 18.5) {
      return 'Your BMI is below the healthy range.';
    }
    if (bmi < 25) {
      return 'Great job! Your BMI is within the healthy range.';
    }
    if (bmi < 30) {
      return 'Your BMI is above the healthy range.';
    }
    return 'Your BMI is significantly above the healthy range.';
  }

  Color get statusColor {
    if (bmi < 18.5) return const Color(0xFF60A5FA);
    if (bmi < 25) return const Color(0xFF4ADE80);
    if (bmi < 30) return const Color(0xFFFBBF24);
    return const Color(0xFFEF4444);
  }

  // Display scale from BMI 12 to 40.
  double get indicatorPosition {
    return ((bmi.clamp(12.0, 40.0) - 12) / 28);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(9),
                decoration: BoxDecoration(
                  color: primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.health_and_safety_outlined,
                  color: Colors.white,
                  size: 21,
                ),
              ),
              Gap(10.h),
               Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'BMI Analysis',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: AppSizes.font16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      'Your body mass index',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: AppSizes.font14
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.insights_rounded,
                color: Colors.grey,
              ),
            ],
          ),

          Gap(15.h),
          // BMI Value
          Center(
            child: Column(
              children: [
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0, end: bmi),
                  duration: const Duration(milliseconds: 1200),
                  curve: Curves.easeOutCubic,
                  builder: (context, value, child) {
                    return Text(
                      value.toStringAsFixed(1),
                      style: TextStyle(
                        color: statusColor,
                        fontSize: AppSizes.font40,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -1.5,
                      ),
                    );
                  },
                ),
                Gap(5.h),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: statusColor.withOpacity(0.5),
                    ),
                  ),
                  child: Text(
                    bmiStatus,
                    style: TextStyle(
                      color: statusColor,
                      fontSize: AppSizes.font12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Gap(25.h),

          // BMI Gauge
          _buildBmiGauge(),

          const SizedBox(height: 20),

          // Description
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.07),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.info_outline_rounded,
                  color: statusColor,
                  size: 19,
                ),
                Gap(10.w),
                Expanded(
                  child: Text(
                    bmiDescription,
                    style: TextStyle(
                      color: Color(0xFFBBBBBB),
                      fontSize: AppSizes.font12,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),

         Gap(12.h),

           Text(
            'BMI is a screening indicator, not a medical diagnosis.',
            style: TextStyle(
              color: Color(0xFF777777),
              fontSize: AppSizes.font10,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBmiGauge() {
    const segments = [
      Color(0xFF60A5FA),
      Color(0xFF4ADE80),
      Color(0xFFFBBF24),
      Color(0xFFF97316),
      Color(0xFFEF4444),
    ];

    return Column(
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            final position = indicatorPosition * (width - 14);

            return SizedBox(
              height: 30,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 5,
                    child: Row(
                      children: List.generate(
                        segments.length,
                        (index) => Expanded(
                          child: Container(
                            height: 9,
                            margin:  EdgeInsets.symmetric(
                              horizontal: 2,
                            ),
                            decoration: BoxDecoration(
                              color: segments[index],
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Animated Indicator
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0, end: position),
                    duration: const Duration(milliseconds: 1400),
                    curve: Curves.easeOutBack,
                    builder: (context, value, child) {
                      return Positioned(
                        left: value,
                        top: 0,
                        child: Container(
                          width: 14,
                          height: 14,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: statusColor,
                              width: 3,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: statusColor.withOpacity(0.5),
                                blurRadius: 8,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),

        Gap(5.h),

         Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '12',
              style: TextStyle(color: Colors.grey, fontSize: AppSizes.font10),
            ),
            Text(
              '18.5',
              style: TextStyle(color: Colors.grey, fontSize:  AppSizes.font10),
            ),
            Text(
              '25',
              style: TextStyle(color: Colors.grey, fontSize: AppSizes.font10),
            ),
            Text(
              '30',
              style: TextStyle(color: Colors.grey,fontSize: AppSizes.font10),
            ),
            Text(
              '40+',
              style: TextStyle(color: Colors.grey,fontSize: AppSizes.font10),
            ),
          ],
        ),
      ],
    );
  }
}
