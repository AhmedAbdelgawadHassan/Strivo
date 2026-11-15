import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:strivo/core/routing/app_routes.dart';
import 'package:strivo/core/utils/app_assets.dart';
import 'package:strivo/core/utils/app_colors.dart';
import 'package:strivo/core/utils/app_sizes.dart';
import 'package:strivo/features/fitnessProfileSetup/data/models/fitness_goal_model.dart';
import 'package:strivo/features/fitnessProfileSetup/presentation/views/widgets/continue_button.dart';
import 'package:strivo/features/fitnessProfileSetup/presentation/views/widgets/fitness_goal_item.dart';
import 'package:strivo/features/fitnessProfileSetup/presentation/views/widgets/setup_progress_indicator.dart';

class FitnessGoalView extends StatefulWidget {
  const FitnessGoalView({super.key});

  @override
  State<FitnessGoalView> createState() => _FitnessGoalViewState();
}

class _FitnessGoalViewState extends State<FitnessGoalView> {
  int? currentIndex ;
 List<FitnessGoalModel> fitnessGoalModels =[
  FitnessGoalModel(image: Assets.images.loseWeightLogo, title: 'Lose Weight', subtitle: 'Burn Fat & Get Lean'),
  FitnessGoalModel(image: Assets.images.buildMuscleLogo, title: 'Build Muscle', subtitle: 'Gain Strength & Size'),
    FitnessGoalModel(image: Assets.images.stayFitLogo, title: 'Stay Fit', subtitle: 'Maintain Current Shape'),
 ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(padding:EdgeInsetsGeometry.symmetric(horizontal: 12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(5.h),
                 SetupProgressIndicator(currentStep: 4, totalSteps: 5),
                 Gap(25.h),
             Text("What's your goal?", style: TextStyle(fontSize: AppSizes.font20,fontWeight: FontWeight.bold,color: Colors.white)),
                 Gap(10.h),
              Text("We'll build your plan around this", style: TextStyle(fontSize: AppSizes.font14,color:AppColors.secondaryTextColor)),
             Gap(30.h),
             Column(
              children:List.generate(fitnessGoalModels.length,
               (index) {
                 return Padding(
                   padding:  EdgeInsets.symmetric(vertical: 10.h),
                   child: InkWell(
                    borderRadius: BorderRadius.circular(12.r),
                    onTap: () {
                    setState(() {
                        currentIndex=index;
                    });
                    },
                    child: FitnessGoalItem(fitnessGoalModel: fitnessGoalModels[index], isActive: currentIndex==index,)),
                 );
               },
               ),
               
             ),
             Spacer(),
             ContinueButton(onPressed: () {
               context.push(AppRoutes.activityLevelView);
             },),
             Gap(12.h)
             
          ],
        ), )
        ),
    );
  }
}