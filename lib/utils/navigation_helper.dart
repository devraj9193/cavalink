import 'package:flutter/material.dart';

class NavigationHelper {
  /// Replace the current screen with a new one
  static void pushReplacement(BuildContext context, Widget screen) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  /// Push a new screen on top of the stack
  static void push(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  /// Clear the entire stack and go to new screen
  static void pushAndRemoveUntil(BuildContext context, Widget screen) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => screen),
          (route) => false,
    );
  }

  /// Go back to previous screen
  static void pop(BuildContext context) {
    Navigator.pop(context);
  }
}
