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
    this.keyboardType = TextInputType.number,
    this.inputFormatters,
    this.helperText,
  });

  @override
  State<MeasurementTextFormField> createState() =>
      _MeasurementTextFormFieldState();
}

class _MeasurementTextFormFieldState extends State<MeasurementTextFormField> {
  bool isFocused = false;

  @override
  Widget build(BuildContext context) {
    const primaryColor = AppColors.primaryColor;
    const cardColor = AppColors.surfaceColor;
    const borderColor = Color.fromARGB(255, 67, 67, 67);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Text(
          widget.label,
          style: TextStyle(
            color: Colors.white,
            fontSize: AppSizes.font14,
            fontWeight: FontWeight.w600,
          ),
        ),
        Gap(10.h),

        // Input Field
        Focus(
          onFocusChange: (focused) {
            setState(() {
              isFocused = focused;
            });
          },
          child: TextFormField(
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            inputFormatters: widget.inputFormatters,
            validator: widget.validator,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            textDirection: TextDirection.ltr,
            style: TextStyle(
              color: Colors.white,
              fontSize: AppSizes.font16,
              fontWeight: FontWeight.w600,
            ),
            cursorColor: primaryColor,
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: TextStyle(
                color: AppColors.secondaryTextColor,
                fontSize: AppSizes.font14,
                fontWeight: FontWeight.w500,
              ),
              // Leading Icon
              prefixIcon: Padding(
                padding:  EdgeInsets.symmetric(horizontal: 12.w),
                child: SvgPicture.asset(widget.image),
              ),
              prefixIconConstraints: BoxConstraints(
                minWidth: 30.w,
                minHeight: 30.h,
              ),
              // Unit Container
              suffixIcon: Padding(
                padding: const EdgeInsetsDirectional.only(
                  end: 12,
                  top: 10,
                  bottom: 10,
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF252525),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    widthFactor: 1.5,
                    child: Text(
                      widget.unit,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: AppSizes.font12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),

              filled: true,
              fillColor: cardColor,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 19,
              ),

              // Default Border
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: borderColor, width: 1),
              ),

              // Focus Border
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: primaryColor, width: 1.5),
              ),

              // Error Border
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: Colors.redAccent, width: 1),
              ),

              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(
                  color: Colors.redAccent,
                  width: 1.5,
                ),
              ),

              errorStyle: const TextStyle(
                color: Colors.redAccent,
                fontSize: 11,
              ),
            ),
          ),
        ),

        if (widget.helperText != null) ...[
          const SizedBox(height: 7),
          Text(
            widget.helperText!,
            style: const TextStyle(color: Color(0xFF777777), fontSize: 11),
          ),
        ],
      ],
    );
  }
}
