import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:strivo/core/routing/app_routes.dart';
import 'package:strivo/core/services/get_it_services.dart';
import 'package:strivo/core/utils/app_assets.dart';
import 'package:strivo/core/utils/app_colors.dart';
import 'package:strivo/features/auth/data/repos/auth_repo.dart';
import 'package:strivo/features/auth/presentation/manager/cubits/login_cubit/login_cubit.dart';
import 'package:strivo/features/auth/presentation/manager/cubits/login_cubit/login_states.dart';
import 'package:strivo/features/auth/presentation/views/widgets/custom_auth_button.dart';
import 'package:strivo/features/auth/presentation/views/widgets/custom_signin_methods_button.dart';
import 'package:strivo/features/auth/presentation/views/widgets/custom_textfield.dart';
import 'package:strivo/features/auth/presentation/views/widgets/snackbar.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          LoginCubit(LoginIntailState(), authRepo: getIt<AuthRepo>()),
      child: Scaffold(
        body: SafeArea(
          child: BlocConsumer<LoginCubit, LoginStates>(
            listener: (context, state) {
              if (state is LoginSuccessState) {
                context.push(AppRoutes.testView);
              }
              if (state is LoginFailureState) {
                showErrorSnackBar(context, message: state.message);
              }
            },
            builder: (context, state) => ModalProgressHUD(
              inAsyncCall: state is LoginLoadingState ? true : false,
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
                        'Welcome Back',
                        style: TextStyle(
                          fontSize: 20.sp,
                          color: AppColors.primaryTextColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Gap(12.h),
                      Text(
                        'Sign in to continue your fitness journey',
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
                              controller: emailController,
                              prefixIcon: Icons.email_outlined,
                              hintText: 'Enter Your Email',
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your email';
                                }
                                return null;
                              },
                            ),
                            Gap(16.h),
                            CustomTextField(
                              controller: passwordController,
                              prefixIcon: Icons.lock_outline,
                              hintText: 'Enter Your Password',
                              obscureText: true,
                              title: 'Password',
                              keyboardType: TextInputType.visiblePassword,
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
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              context.push(AppRoutes.forgotPassword);
                            },
                            child: Text(
                              "Forgot Password?",
                              style: TextStyle(
                                color: AppColors.primaryColor,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Gap(20.h),
                      Row(
                        children: [
                          Expanded(
                            child: CustomAuthButton(
                              title: "Sign In",
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  context
                                      .read<LoginCubit>()
                                      .SignInwithEmailAndPassword(
                                        emailController.text.trim(),
                                        passwordController.text.trim(),
                                      );
                                       
                                      
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
                            onPressed: () {
                              context.read<LoginCubit>().SignInWithGoogle();
                            },
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
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(bottom: 25.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Don't have an account? ",
                style: TextStyle(
                  color: AppColors.secondaryTextColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              InkWell(
                onTap: () {
                  context.push(AppRoutes.signup);
                },
                child: Text(
                  ' Sign Up',
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
