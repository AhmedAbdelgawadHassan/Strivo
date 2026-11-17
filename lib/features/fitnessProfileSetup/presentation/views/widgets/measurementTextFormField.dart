// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:strivo/core/utils/app_colors.dart';
import 'package:strivo/core/utils/app_sizes.dart';

class MeasurementTextFormField extends StatefulWidget {
  final String label;
  final String hint;
  final String unit;
  final String image;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? helperText;

  const MeasurementTextFormField({
    super.key,
    required this.label,
    required this.hint,
    required this.unit,
    required this.image,
    required this.controller,
    required this.validator,
    this.onChanged,
    this.keyboardType = TextInputType.number,
    this.inputFormatters,
    this.helperText,
  });

  @override
  State<MeasurementTextFormField> createState() =>
      _MeasurementTextFormFieldState();
}

class _MeasurementTextFormFieldState extends State<MeasurementTextFormField> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (mounted) setState(() => _isFocused = _focusNode.hasFocus);
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  OutlineInputBorder _border(Color color, double width) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide(color: color, width: width),
      );

  @override
  Widget build(BuildContext context) {
    const primaryColor = AppColors.primaryColor;
    const cardColor = AppColors.surfaceColor;
    const borderColor = Color(0xFF2E2E2E);
    const errorColor = Color(0xFFFF5252);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ===== Label =====
        Padding(
          padding: EdgeInsets.only(left: 4.w),
          child: Text(
            widget.label,
            style: TextStyle(
              color: _isFocused ? primaryColor : Colors.white,
              fontSize: AppSizes.font14,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.3,
            ),
          ),
        ),
        Gap(10.h),

        // ===== Field مع Glow عند الـ Focus =====
        AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: _isFocused
                ? [
                    BoxShadow(
                      color: primaryColor.withOpacity(0.25),
                      blurRadius: 16,
                      spreadRadius: 0.5,
                    ),
                  ]
                : [],
          ),
          child: TextFormField(
            focusNode: _focusNode,
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            inputFormatters: widget.inputFormatters,
            onChanged: widget.onChanged,
            validator: widget.validator,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            textDirection: TextDirection.ltr,
            cursorColor: primaryColor,
            cursorWidth: 2,
            cursorRadius: const Radius.circular(2),
            style: TextStyle(
              color: Colors.white,
              fontSize: AppSizes.font16,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: TextStyle(
                color: Colors.white.withOpacity(0.3),
                fontSize: AppSizes.font14,
                fontWeight: FontWeight.w500,
              ),

              // ===== الأيقونة داخل مربع صغير =====
              prefixIcon: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  width: 38.w,
                  decoration: BoxDecoration(
                    color: _isFocused
                        ? primaryColor.withOpacity(0.15)
                        : const Color(0xFF252525),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  padding: EdgeInsets.all(9.r),
                  child: SvgPicture.asset(
                    widget.image,
                    colorFilter: _isFocused
                        ? const ColorFilter.mode(
                            primaryColor,
                            BlendMode.srcIn,
                          )
                        : null,
                  ),
                ),
              ),
              prefixIconConstraints: BoxConstraints(
                minWidth: 58.w,
                minHeight: 58.h,
              ),

              // ===== وحدة القياس كـ Chip =====
              suffixIcon: Padding(
                padding: EdgeInsetsDirectional.only(
                  end: 12.w,
                  top: 12.h,
                  bottom: 12.h,
                ),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  decoration: BoxDecoration(
                    color: _isFocused
                        ? primaryColor.withOpacity(0.15)
                        : const Color(0xFF252525),
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(
                      color: _isFocused
                          ? primaryColor.withOpacity(0.5)
                          : Colors.transparent,
                    ),
                  ),
                  child: Center(
                    widthFactor: 1,
                    child: Text(
                      widget.unit,
                      style: TextStyle(
                        color: _isFocused ? primaryColor : Colors.white70,
                        fontSize: AppSizes.font12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
              suffixIconConstraints: const BoxConstraints(minWidth: 0),

              filled: true,
              fillColor: _isFocused ? const Color(0xFF1E1E1E) : cardColor,
              contentPadding: EdgeInsets.symmetric(vertical: 20.h),

              // ===== الحدود =====
              enabledBorder: _border(borderColor, 1),
              focusedBorder: _border(primaryColor, 1.5),
              errorBorder: _border(errorColor, 1),
              focusedErrorBorder: _border(errorColor, 1.5),

              // ===== رسالة الخطأ =====
              errorStyle: TextStyle(
                color: errorColor,
                fontSize: 11.sp,
                fontWeight: FontWeight.w500,
                height: 1.4,
              ),
            ),
          ),
        ),

        // ===== Helper Text =====
        if (widget.helperText != null) ...[
          Gap(7.h),
          Padding(
            padding: EdgeInsets.only(left: 4.w),
            child: Text(
              widget.helperText!,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.4),
                fontSize: 11.sp,
              ),
            ),
          ),
        ],
      ],
    );
  }
}