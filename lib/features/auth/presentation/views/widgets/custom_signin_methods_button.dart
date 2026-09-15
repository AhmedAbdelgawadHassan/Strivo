import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class CustomSigninMethodsButton extends StatelessWidget {
  const CustomSigninMethodsButton({super.key, required this.onPressed, required this.title, required this.image});
  final VoidCallback onPressed;
  final String title;
  final String image;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF202020),
        padding: EdgeInsets.symmetric(vertical: 16.h,horizontal: 30.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
      onPressed: onPressed,
      child: Row(
        children: [
          SvgPicture.asset(image,width: 23.w,height: 23.h,),
          Gap(8.h),
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
