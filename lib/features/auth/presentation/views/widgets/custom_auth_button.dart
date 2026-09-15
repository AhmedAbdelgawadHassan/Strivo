import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strivo/core/utils/app_colors.dart';

class CustomAuthButton extends StatelessWidget {
  const CustomAuthButton({super.key, required this.onPressed, required this.title});
 final VoidCallback onPressed;
 final String title;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        padding:  EdgeInsets.symmetric(vertical: 10.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
      
        ),
      ),
      onPressed: onPressed,
     child: Text(title,style: TextStyle(color: Colors.white,fontSize: 16.sp,fontWeight: FontWeight.w700),),
     );
  }
}