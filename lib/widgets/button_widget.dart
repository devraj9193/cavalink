import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import '../utils/constants.dart';
import 'common_widgets.dart';

/// Primary reusable button with optional loading state.
class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final Color? color;
  final Color? textColor;
  final Color? loadingColor;
  final double? radius;
  final double? buttonWidth;
  final String? font;

  const ButtonWidget({
    super.key,
    required this.text,
    required this.onPressed,
    required this.isLoading,
    this.color,
    this.textColor,
    this.loadingColor,
    this.radius,
    this.buttonWidth,
    this.font,
  });

  @override
  Widget build(BuildContext context) {
    final buttonColor = color ?? gSecondaryColor;
    final buttonTextColor = textColor ?? gWhiteColor;
    final loadingIndicatorColor = loadingColor ?? gWhiteColor;
    final borderRadius = radius ?? 30.0;
    final width = buttonWidth ?? 30.w;
    final buttonFont = font ?? User().buttonTextFont;

    return SizedBox(
      width: width,
      height: 4.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 0.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        onPressed: isLoading ? null : onPressed,
        child: Center(
          child: isLoading
              ? buildThreeBounceIndicator(color: mainColor)
              : Text(
            text,
            style: TextStyle(
              fontFamily: buttonFont,
              color: buttonTextColor,
              fontSize: User().buttonTextSize,
            ),
          ),
        ),
      ),
    );
  }
}

/// Simple common button with optional loading spinner.
class CommonButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final Color color;
  final Color textColor;

  const CommonButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.color = Colors.blue,
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: isLoading ? null : onPressed,
      child: isLoading
          ? const SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          strokeWidth: 2,
        ),
      )
          : Text(
        text,
        style: TextStyle(color: textColor, fontSize: 16),
      ),
    );
  }
}
