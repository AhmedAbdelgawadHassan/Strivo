import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:strivo/core/routing/app_routes.dart';
import 'package:strivo/core/services/shared_preferences_singleton.dart';
import 'package:strivo/core/utils/app_assets.dart';
import 'package:strivo/core/utils/app_sizes.dart';
import 'package:strivo/core/utils/constants.dart';
import 'package:strivo/features/onboarding/data/models/onboarding_model.dart';
import 'package:strivo/features/onboarding/presentation/views/widgets/dots_indicator.dart';
import 'package:strivo/features/onboarding/presentation/views/widgets/next_button.dart';
import 'package:strivo/features/onboarding/presentation/views/widgets/onboarding_item.dart';
import 'package:strivo/features/onboarding/presentation/views/widgets/skip_button.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  int currentPage = 0;
  late PageController pageController;
  List<OnboardingModel> onboardingitems = [
    OnboardingModel(
      title: 'Track Your Workouts',
      description:
          'Log exercises, sets, and reps with smart tracking that adapts to your routine.',
      image: Assets.images.workout,
    ),
    OnboardingModel(
      title: 'Smart Nutrition',
      description:
          'Get personalized meal plans and track your daily calories & macros effortlessly',
      image: Assets.images.nutrition,
    ),
    OnboardingModel(
      title: 'AI-Powered Coach',
      description:
          'Your personal AI coach analyzes your progress and gives real-time recommendations.',
      image: Assets.images.aiCoach,
    ),
  ];

  @override
  void initState() {
    super.initState();

    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: currentPage == 0
            ? SizedBox()
            : InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () {
                  pageController.previousPage(
                    duration: const Duration(milliseconds: 350),
                    curve: Curves.easeInOut,
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(12),
                  child: SvgPicture.asset(Assets.images.arrowBack),
                ),
              ),
        backgroundColor: Colors.transparent,
      ),

      body: SafeArea(
        child: Column(
          children: [
            Spacer(),
            ExpandablePageView.builder(
              itemBuilder: (context, index) {
                return OnboardingItem(onboardingModel: onboardingitems[index]);
              },
              itemCount: onboardingitems.length,
              controller: pageController,
              onPageChanged: (value) {
                setState(() {
                  currentPage = value;
                });
              },
            ),
            Gap(30.h),
            DotsIndicator(currentPage: currentPage),
            Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSizes.screenHorizontalPadding,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: NextButton(
                      text: currentPage == 2 ? "Get Started" : "Next",
                      onPressed: () {
                        currentPage == 2
                            ? {
                                context.go(AppRoutes.login),
                                Prefs.setBool(kIsOnboardingSeen, true),
                              }
                            : pageController.nextPage(
                                duration: const Duration(milliseconds: 350),
                                curve: Curves.easeInOut,
                              );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Gap(12.h),
            currentPage == 2
                ? SizedBox()
                : Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSizes.screenHorizontalPadding,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: SkipButton(
                            onPressed: () {
                              context.go(AppRoutes.login);
                              Prefs.setBool(kIsOnboardingSeen, true);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
            Gap(20),
          ],
        ),
      ),
    );
  }
}
