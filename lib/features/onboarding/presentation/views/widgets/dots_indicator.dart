
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strivo/core/utils/app_colors.dart';

class DotsIndicator extends StatelessWidget {
  const DotsIndicator({
    super.key,
    required this.currentPage,
  });

  final int currentPage;

  @override
  Widget build(BuildContext context) {
    return Row(
      
      mainAxisAlignment: MainAxisAlignment.center,
      children:List.generate(3, (index) => AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        width: index==currentPage? 32.w:10.w,
        height: index==currentPage? 8.h:10.h,
        margin: EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          color: index==currentPage? AppColors.primaryColor:Color(0xff2B2B2B),
          borderRadius: BorderRadius.circular(20),
        ),
      ),),
    );
  }
}
