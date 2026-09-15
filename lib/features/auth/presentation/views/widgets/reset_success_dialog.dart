
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:strivo/features/auth/presentation/views/widgets/custom_auth_button.dart';

class ResetSuccessDialog extends StatelessWidget {
  const ResetSuccessDialog({
    super.key,
    required this.onBackToLogin,
  });

  final VoidCallback onBackToLogin;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding:  EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
        padding: const EdgeInsets.fromLTRB(18, 20, 18, 24),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.26),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Close button
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(
                  Icons.close_rounded,
                  color: Colors.white.withValues(alpha: 0.5),
                  size: 22,
                ),
              ),
            ),

            Gap(8.h),

            // Email icon
            Container(
            padding: EdgeInsets.all(16.w),
              decoration: const BoxDecoration(
                color: Color(0xFF163F2A),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.mark_email_read_outlined,
                color: Color(0xFF4ADE80),
                size: 38,
              ),
            ),

             Gap(24.h),

            // Title
             Text(
              'Check Your Email',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
              ),
            ),

            Gap(12.h),

            // Description
            Text(
              "We've sent a password reset link to your email",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.6),
                fontSize: 14.sp,
              ),
            ),

            Gap(20.h),

            // Back To Login button
             Row(
               children: [
                 Expanded(
                   child: CustomAuthButton(onPressed: () {
                     context.pop();
                     context.pop();
                   }, title: "Back To Login"),
                 ),
               ],
             ),
          ],
        ),
      ),
    );
  }
}