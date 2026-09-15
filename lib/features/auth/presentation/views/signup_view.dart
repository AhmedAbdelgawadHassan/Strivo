import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:strivo/core/routing/app_routes.dart';
import 'package:strivo/core/utils/app_assets.dart';
import 'package:strivo/core/utils/app_colors.dart';
import 'package:strivo/features/auth/presentation/views/widgets/custom_auth_button.dart';
import 'package:strivo/features/auth/presentation/views/widgets/custom_signin_methods_button.dart';
import 'package:strivo/features/auth/presentation/views/widgets/custom_textfield.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final fullNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Gap(20.h),
                Image(
                  image: AssetImage(Assets.images.appLogo),
                  width: 120.w,
                  height: 120.h,
                ),
                Text(
                  'Create account',
                  style: TextStyle(
                    fontSize: 20.sp,
                    color: AppColors.primaryTextColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gap(12.h),
                Text(
                  'Start your fitness transformation today',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: AppColors.secondaryTextColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Gap(25.h),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                       CustomTextField(
                        prefixIcon: Icons.email_outlined,
                        hintText: 'Enter Full Name',
                        keyboardType: TextInputType.name,
                        title: 'Full Name',
                        controller: fullNameController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your full name';
                          }
                          return null;
                        },
                  
                      ),
                      Gap(16.h),
                      CustomTextField(
                        prefixIcon: Icons.email_outlined,
                        hintText: 'Enter Your Email',
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                      ),
                      Gap(16.h),
                      CustomTextField(
                        prefixIcon: Icons.lock_outline,
                        hintText: 'Enter Your Password',
                        obscureText: true,
                        title: 'Password',
                        keyboardType: TextInputType.visiblePassword,
                        controller: passwordController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                Gap(20.h),

                Row(
                  children: [
                    Expanded(
                      child: CustomAuthButton(
                        title: "Create Account",
                        onPressed: () {
                          if(formKey.currentState!.validate()){
                            context.push(AppRoutes.testView);
                          }
                        },
                      ),
                    ),
                  ],
                ),
                Gap(30.h),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 1,
                        color: AppColors.secondaryTextColor,
                      ),
                    ),
                    Text(
                      '  Or Continue with  ',
                      style: TextStyle(
                        color: AppColors.secondaryTextColor,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 1,
                        color: AppColors.secondaryTextColor,
                      ),
                    ),
                  ],
                ),
                Gap(20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomSigninMethodsButton(
                      image: Assets.images.google,
                      title: 'Google',
                      onPressed: () {},
                    ),
                    Gap(16.w),
                    CustomSigninMethodsButton(
                      image: Assets.images.facebook,
                      title: 'Facebook',
                      onPressed: () {},
                    ),
                  ],
                ),
               
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar:  Padding(
        padding:  EdgeInsets.only(
          bottom: 25.h
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account? ",
                        style: TextStyle(
                          color: AppColors.secondaryTextColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          context.pop();
                        },
                        child: Text(' Sign In',
                            style: TextStyle(
                              color: AppColors.primaryColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            )),
                      ),
                    ],
                  ),
      ),
    );
  }
}
