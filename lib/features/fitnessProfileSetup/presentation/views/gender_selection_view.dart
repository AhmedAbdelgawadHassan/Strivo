import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:strivo/core/routing/app_routes.dart';
import 'package:strivo/core/services/shared_preferences_singleton.dart';
import 'package:strivo/core/utils/app_assets.dart';
import 'package:strivo/core/utils/app_colors.dart';
import 'package:strivo/core/utils/app_sizes.dart';
import 'package:strivo/core/utils/constants.dart';
import 'package:strivo/features/fitnessProfileSetup/data/models/gender_model.dart';
import 'package:strivo/features/fitnessProfileSetup/presentation/views/widgets/continue_button.dart';
import 'package:strivo/features/fitnessProfileSetup/presentation/views/widgets/gender_card.dart';
import 'package:strivo/features/fitnessProfileSetup/presentation/views/widgets/setup_progress_indicator.dart';

class GenderSelectionView extends StatefulWidget {
  const GenderSelectionView({super.key});

  @override
  State<GenderSelectionView> createState() => _GenderSelectionViewState();
}
class _GenderSelectionViewState extends State<GenderSelectionView> {
   int? currentIndex;
  final List<GenderModel> genderModels =[
  GenderModel(title: 'Male', image: Assets.images.male),
  GenderModel(title: 'Female', image: Assets.images.female)
  ];
  

  @override
  void initState() {
    Prefs.setBool(kIsLoggedIn, true);
    super.initState();
  }

  
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
               SetupProgressIndicator(currentStep: 1, totalSteps: 5),
               Gap(25.h),
               Text("What's your gender?", style: TextStyle(fontSize: AppSizes.font20,fontWeight: FontWeight.bold,color: Colors.white)),
               Gap(10.h),
            Text('This helps us customize your plan', style: TextStyle(fontSize: AppSizes.font14,color:AppColors.secondaryTextColor)),
           Gap(30.h),
           Row(
            children:List.generate(genderModels.length, (index) {
              return Expanded(child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: 5.w),
                child: InkWell(
                   borderRadius: BorderRadius.circular(12),
                  onTap: () {
                    setState(() {
                      currentIndex=index;
                    });
                  },
                  child: GenderCard(genderModel: genderModels[index], isActive:currentIndex==index ,)),
              ));
            },)
           ),
           Spacer(),
           Row(
             children: [
               Expanded(
                 child: ContinueButton(onPressed: () {
                  context.push(AppRoutes.bodyMeasurements);
                 },),
               ),
             ],
           ),
          Gap(20.h)
            ],
          ),
        ),
      ),
    );
  }
}