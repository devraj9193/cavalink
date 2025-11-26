import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

import '../../utils/constants.dart';

enum TextFieldBorderType { underline, full }

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final bool readOnly;
  final VoidCallback? onTap;
  final Color? fillColor;
  final ValueChanged<String>? onChanged;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final Widget? suffixWidget;
  final int maxLength;
  final TextFieldBorderType borderType;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool? autofocus;
  final double? height;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color? errorBorderColor;
  final double? borderWidth;
  final FocusNode? focusNode;
  final ValueChanged<String>? onFieldSubmitted;
  final bool obscureText;
  final TextAlign align;
  final double contentPadding;

  const CustomTextField({
    Key? key,
    required this.controller,
    this.hintText,
    this.readOnly = false,
    this.onTap,
    this.onChanged,
    this.maxLength = 1,
    this.fillColor = Colors.white,
    this.prefixIcon,
    this.suffixIcon,
    this.suffixWidget,
    this.borderType = TextFieldBorderType.underline,
    this.validator,
    this.keyboardType,
    this.textInputAction,
    this.autofocus = false,
    this.height,
    this.borderColor,
    this.focusedBorderColor,
    this.errorBorderColor,
    this.borderWidth,
    this.obscureText = false,
    this.focusNode,
    this.onFieldSubmitted,
    this.align = TextAlign.start,
    this.contentPadding = 12,
  }) : super(key: key);

  InputBorder getBorder({
    required BuildContext context,
    required Color color,
    required double width,
  }) {
    switch (borderType) {
      case TextFieldBorderType.full:
        return OutlineInputBorder(
          borderSide: BorderSide(color: color, width: width),
          borderRadius: BorderRadius.circular(6),
        );
      case TextFieldBorderType.underline:
        return UnderlineInputBorder(
          borderSide: BorderSide(color: color, width: width),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final defaultColor = borderColor ?? Colors.grey.shade400;
    final focusColor = focusedBorderColor ?? theme.colorScheme.primary;
    final errColor = errorBorderColor ?? theme.colorScheme.error;
    final width = borderWidth ?? 1.2;

    return SizedBox(
      height: height,
      child: TextFormField(
        controller: controller,
        readOnly: readOnly,
        onTap: onTap,
        onChanged: onChanged,
        validator: validator,
        maxLines: maxLength,
        textAlign: align,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        autofocus: autofocus ?? false,
        obscureText: obscureText,
        focusNode: focusNode,
        onFieldSubmitted: onFieldSubmitted,
        style: TextStyle(
          fontFamily: fontMedium,
          color: gBlackColor,
          fontSize: 14.dp,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            fontFamily: fontBook,
            color: newLightGreyColor,
            fontSize: 12.dp,
          ),
          filled: true,
          fillColor: fillColor,
          prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
          suffixIcon:
          suffixWidget ?? (suffixIcon != null ? Icon(suffixIcon) : null),
          border:
          getBorder(context: context, color: defaultColor, width: width),
          enabledBorder:
          getBorder(context: context, color: defaultColor, width: width),
          focusedBorder: getBorder(
              context: context, color: focusColor, width: width + 0.3),
          errorBorder:
          getBorder(context: context, color: errColor, width: width),
          focusedErrorBorder:
          getBorder(context: context, color: errColor, width: width + 0.3),
          isDense: true,
          contentPadding:
          EdgeInsets.symmetric(horizontal: contentPadding, vertical: height == null ? 2.5.h : 10),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:gwc_shipping_web/utils/constants.dart';
//
// enum TextFieldBorderType { underline, full }
//
// class CustomTextField extends StatelessWidget {
//   final TextEditingController controller;
//   final String? hintText;
//   final bool readOnly;
//   final VoidCallback? onTap;
//   final Color? fillColor;
//   final ValueChanged<String>? onChanged;
//   final IconData? suffixIcon;
//   final int maxLength;
//   final TextFieldBorderType borderType;
//   final FormFieldValidator<String>? validator;
//   final TextInputType? keyboardType;
//   final TextInputAction? textInputAction;
//   final bool? autofocus;
//
//   const CustomTextField({
//     Key? key,
//     required this.controller,
//     this.hintText,
//     this.readOnly = false,
//     this.onTap,
//     this.onChanged,
//     this.maxLength = 1,
//     this.fillColor = gWhiteColor,
//     this.suffixIcon,
//     this.borderType = TextFieldBorderType.underline,
//     this.validator,
//     this.keyboardType,
//     this.textInputAction,
//     this.autofocus = false,
//   }) : super(key: key);
//
//   InputBorder getBorder() {
//     switch (borderType) {
//       case TextFieldBorderType.full:
//         return const OutlineInputBorder();
//       case TextFieldBorderType.underline:
//       default:
//         return const UnderlineInputBorder();
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       controller: controller,
//       readOnly: readOnly,
//       onTap: onTap,
//       onChanged: onChanged,
//       validator: validator,
//       maxLines: maxLength,
//       keyboardType: keyboardType,
//       textInputAction: textInputAction,
//       autofocus: autofocus ?? false,
//       decoration: InputDecoration(
//         hintText: hintText,
//         filled: true,
//         fillColor: fillColor,
//         suffixIcon: suffixIcon != null ? Icon(suffixIcon) : null,
//         border: getBorder(),
//         enabledBorder: getBorder(),
//         focusedBorder: getBorder(),
//         errorBorder: getBorder().copyWith(
//           borderSide: const BorderSide(color: Colors.red),
//         ),
//         focusedErrorBorder: getBorder().copyWith(
//           borderSide: const BorderSide(color: Colors.red),
//         ),
//       ),
//     );
//   }
// }
