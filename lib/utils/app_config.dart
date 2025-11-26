import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'constants.dart';

class AppConfig {
  static AppConfig? instance;
  factory AppConfig() => instance ??= AppConfig._();
  AppConfig._();

  SharedPreferences? preferences;

  static const String isLogin = "is_login";
  static const String isToken = "is_token";

  ///user details
  static const String isUser="is_user";
  static const String deviceToken="deviceToken";

  static const String userId = "userId";
  static const String userName = "userName";
  static const String userEmail = "userEmail";
  static const String userMobile = "userMobile";
  static const String userAge = "userAge";
  static const String userAddress = "userAddress";
  static const String userSosNumber = "userSosNumber";

  static String networkErrorText =
      "No Internet. Please Check Your Network Connection";
  static String oopsMessage = "OOps ! Something went wrong.";

  showSnackBar(BuildContext context, String message,
      {int? duration,
      bool? isError,
      SnackBarAction? action,
      double? bottomPadding}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: (isError == null || isError == false)
            ? primaryColor
            : gSecondaryColor.withOpacity(0.55),
        content: Text(message),
        margin: (bottomPadding != null)
            ? EdgeInsets.only(bottom: bottomPadding)
            : null,
        duration: Duration(seconds: duration ?? 3),
        action: action,
      ),
    );
  }

  showSheet(BuildContext context, Widget viewWidget,
      {double? bottomSheetHeight, bool isDismissible = false}) {
    return showModalBottomSheet(
        isScrollControlled: true,
        isDismissible: isDismissible,
        enableDrag: false,
        context: context,
        backgroundColor: Colors.transparent,
        // shape: const RoundedRectangleBorder(
        //   borderRadius: BorderRadius.vertical(
        //     top: Radius.circular(30),
        //   ),
        // ),
        builder: (BuildContext context) {
          return AnimatedPadding(
            padding: MediaQuery.of(context).viewInsets,
            // EdgeInsets. only(bottom: MediaQuery.of(context).viewInsets),
            duration: const Duration(milliseconds: 100),
            child: Container(
              decoration: BoxDecoration(
                color: gWhiteColor,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
              ),
              height: bottomSheetHeight ?? 40.h,
              child: viewWidget,
            ),
          );
        });
  }
}
