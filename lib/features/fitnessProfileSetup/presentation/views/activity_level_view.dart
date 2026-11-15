import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:strivo/core/utils/app_colors.dart';
import 'package:strivo/core/utils/app_sizes.dart';
import 'package:strivo/features/fitnessProfileSetup/data/models/activity_level_model.dart';
import 'package:strivo/features/fitnessProfileSetup/presentation/views/widgets/activity_level_item.dart';
import 'package:strivo/features/fitnessProfileSetup/presentation/views/widgets/continue_button.dart';
import 'package:strivo/features/fitnessProfileSetup/presentation/views/widgets/setup_progress_indicator.dart';

class ActivityLevelView extends StatefulWidget {
  const ActivityLevelView({super.key});

  @override
  State<ActivityLevelView> createState() => _ActivityLevelViewState();
}

class _ActivityLevelViewState extends State<ActivityLevelView> {
  int? currentIndex;
  List<ActivityLevelModel> activitylevelModel = [
    ActivityLevelModel(title: 'Sedentary', subtitle: 'Little To No Exercise'),
    ActivityLevelModel(title: 'Lightly Active', subtitle: '1-2 Days/Week'),
    ActivityLevelModel(title: 'Moderate', subtitle: '3-5 Days/Week'),
    ActivityLevelModel(title: 'Active', subtitle: '6-7 Days/Week'),
    ActivityLevelModel(title: 'very Active', subtitle: 'Athlete Level'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 12.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(5.h),
              SetupProgressIndicator(currentStep: 5, totalSteps: 5),
              Gap(25.h),
              Text(
                "Activity Level",
                style: TextStyle(
                  fontSize: AppSizes.font20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Gap(10.h),
              Text(
                "How active are you currently?",
                style: TextStyle(
                  fontSize: AppSizes.font14,
                  color: AppColors.secondaryTextColor,
                ),
              ),
              Gap(30.h),
              Column(
                children: List.generate(activitylevelModel.length,
                 (index) {
                   return Padding(
                     padding:  EdgeInsets.symmetric(vertical: 8.h),
                     child: InkWell(
                      borderRadius: BorderRadius.circular(12.r),
                      onTap: () {
                        setState(() {
                          currentIndex=index;
                        });
                      },
                      child: ActivityLevelItem(activityLevelModel: activitylevelModel[index], isActive: currentIndex==index)),
                   );
                 },),
              ),
              Spacer(),
              ContinueButton(onPressed: () {
                
              },),
              Gap(12.h)
            ],
          ),
        ),
      ),
    );
  }
}
