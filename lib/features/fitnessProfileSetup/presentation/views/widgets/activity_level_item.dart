// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:strivo/core/utils/app_assets.dart';
import 'package:strivo/core/utils/app_colors.dart';
import 'package:strivo/core/utils/app_sizes.dart';
import 'package:strivo/features/fitnessProfileSetup/data/models/activity_level_model.dart';

class ActivityLevelItem extends StatelessWidget {
  const ActivityLevelItem({super.key, required this.activityLevelModel, required this.isActive});
  final ActivityLevelModel activityLevelModel;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return  ListTile(
    tileColor:isActive?Color(0xff261111): AppColors.surfaceColor,
      title: Text(activityLevelModel.title,style: TextStyle(
        fontSize: AppSizes.font16,
        color: Colors.white
      ),),
      contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 8),
      subtitle:Text(activityLevelModel.subtitle,style: TextStyle(
        fontSize: AppSizes.font12,
        color: AppColors.secondaryTextColor
      ),),
      trailing:isActive? SvgPicture.asset(Assets.images.trueSign):null,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color:isActive?AppColors.primaryColor: Colors.white.withOpacity(0.5)
        ),
        borderRadius: BorderRadiusGeometry.circular(16.r),
        
      ),
    );
  }
}