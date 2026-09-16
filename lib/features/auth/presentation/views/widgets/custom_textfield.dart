import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:strivo/core/utils/app_colors.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    this.controller,
    this.hintText = 'Enter Your Email',
    this.prefixIcon = Icons.email_outlined,
    this.keyboardType = TextInputType.emailAddress,
    this.obscureText = false,
    this.validator,
    this.title = 'Email Address',
  });

  final TextEditingController? controller;
  final String hintText;
  final IconData prefixIcon;
  final TextInputType keyboardType;
  final bool obscureText;
  final String? Function(String?)? validator;
  final String title;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isFocused = false;

  late bool isObscure;

  @override
  void initState() {
    super.initState();

    // بياخد القيمة اللي بعتها من الـ widget
    isObscure = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (value) {
        setState(() {
          isFocused = value;
        });
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: TextStyle(
              color: AppColors.secondaryTextColor,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),

          Gap(8.h),

          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            decoration: BoxDecoration(
              color: const Color(0xFF202020),
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(
                color: isFocused
                    ? AppColors.primaryTextColor
                    : const Color(0xFF303030),
                width: isFocused ? 1.2.w : 1.w,
              ),
              boxShadow: isFocused
                  ? [
                      BoxShadow(
                        color: AppColors.primaryColor.withValues(alpha: 0.12),
                        blurRadius: 12,
                        spreadRadius: 1,
                      ),
                    ]
                  : [],
            ),

            child: TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,/// remove the error message when the user starts typing in the field
              controller: widget.controller,
              keyboardType: widget.keyboardType,
              obscureText: isObscure,
              validator: widget.validator,
              cursorColor: AppColors.primaryColor,

              style: TextStyle(
                color: Colors.white,
                fontSize: 17.sp,
                fontWeight: FontWeight.w500,
              ),

              decoration: InputDecoration(
                hintText: widget.hintText,

                hintStyle: TextStyle(
                  color: const Color(0xFF777777),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                ),

                prefixIcon: Padding(
                  padding: EdgeInsets.only(
                    left: 10.w,
                    right: 2.w,
                  ),
                  child: Icon(
                    widget.prefixIcon,
                    color: isFocused
                        ? AppColors.primaryColor
                        : const Color(0xFF777777),
                    size: 23.sp,
                  ),
                ),

                prefixIconConstraints: BoxConstraints(
                  minWidth: 55.w,
                  minHeight: 55.h,
                ),

                suffixIcon: widget.obscureText
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            isObscure = !isObscure;
                          });
                        },
                        icon: Icon(
                          isObscure
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: isFocused
                              ? AppColors.primaryColor
                              : const Color(0xFF777777),
                          size: 23.sp,
                        ),
                      )
                    : null,

                contentPadding: EdgeInsets.symmetric(
                  horizontal: 18.w,
                  vertical: 15.h,
                ),

                border: InputBorder.none,

                errorStyle: TextStyle(
                  color: Colors.redAccent,
                  fontSize: 12.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}