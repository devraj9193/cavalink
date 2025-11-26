import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

import '../../utils/constants.dart';

class CommonDropdown extends StatelessWidget {
  final String label;
  final String? value;
  final bool isApp;
  final List<String>? priority;
  final ValueChanged<String?> onChanged;
  final bool isFullBorder;
  final String? Function(String?)? validator;
  final double? height;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color? errorBorderColor;
  final double? borderWidth;
  final bool showCheckIcon; // 👈 New parameter

  const CommonDropdown({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    this.priority,
    this.isFullBorder = false,
    this.isApp = false,
    this.validator,
    this.height,
    this.borderColor,
    this.focusedBorderColor,
    this.errorBorderColor,
    this.borderWidth,
    this.showCheckIcon = true, // 👈 default to true
  });

  InputBorder getInputBorder(Color color, double width) {
    return isFullBorder
        ? OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: color, width: width),
    )
        : UnderlineInputBorder(
      borderSide: BorderSide(color: color, width: width),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final defaultColor = borderColor ?? Colors.grey.shade400;
    final focusColor = focusedBorderColor ?? theme.colorScheme.primary;
    final errColor = errorBorderColor ?? theme.colorScheme.error;
    final width = borderWidth ?? 1.2;

    return SizedBox(
      height: height ?? 5.h,
      child: DropdownButtonFormField2<String>(
        value: value?.isNotEmpty == true ? value : null,
        isExpanded: true,
        style: TextStyle(
          overflow: TextOverflow.ellipsis,
          fontSize: fontSize13,
          color: gBlackColor,
          fontFamily: fontMedium,
        ),
        decoration: InputDecoration(
          isDense: true,
          contentPadding:
          EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.3.h),
          border: getInputBorder(defaultColor, width),
          enabledBorder: getInputBorder(defaultColor, width),
          focusedBorder: getInputBorder(focusColor, width + 0.3),
          errorBorder: getInputBorder(errColor, width),
          focusedErrorBorder: getInputBorder(errColor, width + 0.3),
          suffixIconConstraints:
          const BoxConstraints(minWidth: 0, minHeight: 0),
          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (showCheckIcon &&
                  value != null &&
                  value!.isNotEmpty &&
                  value != 'Select Vendor')
                Icon(Icons.check, color: primaryColor, size: 3.h),
              Icon(Icons.keyboard_arrow_down, color: gGreyColor, size: 3.h),
              SizedBox(width: 1.w),
            ],
          ),
        ),
        hint: Text(
          label,
          style: TextStyle(
            fontSize: fontSize12,
            fontFamily: fontBook,
            color: gGreyColor,
          ),
        ),
        buttonStyleData: const ButtonStyleData(
          padding: EdgeInsets.zero,
          width: double.infinity,
        ),
        iconStyleData: const IconStyleData(icon: SizedBox.shrink()),
        dropdownStyleData: DropdownStyleData(
          offset: const Offset(0, -4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: gWhiteColor,
          ),
        ),
        items: priority?.map((item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(
              item,
              style: TextStyle(
                fontSize: fontSize12,
                fontFamily: fontMedium,
                color: gBlackColor,
              ),
            ),
          );
        }).toList(),
        validator: validator ??
                (val) {
              if (val == null || val == 'Select Vendor') {
                return 'Please select a vendor';
              }
              return null;
            },
        onChanged: onChanged,
      ),
    );
  }
}
