import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:strivo/core/utils/app_assets.dart';
import 'package:strivo/core/utils/app_colors.dart';
import 'package:strivo/core/utils/app_sizes.dart';

class ContinueButton extends StatelessWidget {
  const ContinueButton({super.key, required this.onPressed});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 8.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(8.r),
        
      )  
      ),
      
      onPressed: onPressed, child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Continue",
              style: TextStyle(fontSize: AppSizes.font20,fontWeight: FontWeight.w700,color: Colors.white),),
              Gap(7.w),
            Transform.rotate(
               angle: 3.14,
              child: SvgPicture.asset(Assets.images.arrowBack))
        ],
      ));
  }
}