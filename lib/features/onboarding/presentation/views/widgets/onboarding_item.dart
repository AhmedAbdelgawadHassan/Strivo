import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:strivo/core/utils/app_colors.dart';
import 'package:strivo/core/utils/app_sizes.dart';
import 'package:strivo/features/onboarding/data/models/onboarding_model.dart';

class OnboardingItem extends StatelessWidget {
  const OnboardingItem({super.key, required this.onboardingModel});
  final OnboardingModel onboardingModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSizes.screenHorizontalPadding),
      child: Column(
        children: [
          SvgPicture.asset(onboardingModel.image),
          Gap(30.h),
          Text(onboardingModel.title,
           style: TextStyle(
            color: Colors.white,
             fontSize:AppSizes.font20,
              fontWeight: FontWeight.w700,
              ),
             ),
             Gap(20.h),
             Text(onboardingModel.description,
             textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.secondaryTextColor,
                fontSize: AppSizes.font16,
                fontWeight: FontWeight.w500,
              ),
             )
        ],
      ),
    );
  }
}
