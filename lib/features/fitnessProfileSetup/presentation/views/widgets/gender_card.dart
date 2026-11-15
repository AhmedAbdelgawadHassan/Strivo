import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:strivo/core/utils/app_colors.dart';
import 'package:strivo/core/utils/app_sizes.dart';
import 'package:strivo/features/fitnessProfileSetup/data/models/gender_model.dart';

class GenderCard extends StatelessWidget {
  const GenderCard({super.key, required this.genderModel, required this.isActive,});
  final GenderModel genderModel;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: AnimatedContainer(
        duration: Duration(milliseconds:5),
        decoration: BoxDecoration(
    color:isActive?Color(0xff281212): AppColors.surfaceColor,
  borderRadius: BorderRadius.circular(14),
  border: Border.all(
    width: isActive?2:1.5,
    color:isActive?AppColors.primaryColor: const Color(0xFF333333),
  ),

        ),
        child: Column(
          spacing: 12.h,
          children: [
            Gap(12.h),
            Image(image: AssetImage(genderModel.image),width: 75.w,height: 75.h),
            Text(genderModel.title,style: TextStyle(fontSize: AppSizes.font16,color: Colors.white,fontWeight: FontWeight.bold,))
        ,Gap(12.h),
          ],
        ),
      ),
    );
  }
}