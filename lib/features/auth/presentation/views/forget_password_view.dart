import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:strivo/core/routing/app_routes.dart';
import 'package:strivo/core/utils/app_assets.dart';
import 'package:strivo/core/utils/app_colors.dart';
import 'package:strivo/features/auth/presentation/views/widgets/custom_auth_button.dart';
import 'package:strivo/features/auth/presentation/views/widgets/custom_textfield.dart';
import 'package:strivo/features/auth/presentation/views/widgets/reset_success_dialog.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({super.key});

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

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
                  'Reset Password',
                  style: TextStyle(
                    fontSize: 20.sp,
                    color: AppColors.primaryTextColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gap(12.h),
                Text(
                  'Enter your email to receive a reset link',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: AppColors.secondaryTextColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Gap(25.h),
                Form(
                  key: formKey,
                  child: CustomTextField(
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
                ),
                Gap(16.h),
                Gap(20.h),
               
                Row(
                  children: [
                    Expanded(
                      child: CustomAuthButton(
                        title: "Send Reset Link",
                        onPressed: () {
                          if(formKey.currentState!.validate()){
                           showDialog(context: context, builder: (context) {
                             return ResetSuccessDialog(
                               onBackToLogin: () {
                                 Navigator.pop(context);
                                 context.push(AppRoutes.login);
                               },
                             );
                           },);
                        
                          }
                        },
                      ),
                    ),
                  ],
                ),
                Gap(30.h),
              
               
              ],
            ),
          ),
        ),
      ),
    );
  }
}
