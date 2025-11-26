import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import '../../../utils/constants.dart';
import '../../../widgets/button_widget.dart';
import '../auth_screen.dart';

class PasswordResetSuccessScreen extends StatelessWidget {
  final String otp;
  const PasswordResetSuccessScreen({super.key, required this.otp});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200], // Light background
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle_outline_sharp,
              size: 10.h,
              color: Colors.teal,
            ),
            SizedBox(height: 2.h),
            Text(
              "Password Reset Link Sent",
              style: TextStyle(
                fontSize: fontSize15,
                fontFamily: fontMedium,
                color: gBlackColor,
              ),
            ),
            SizedBox(height: 1.h),
            Text(
              "We've sent a password reset link to your email address. Please check your inbox and follow the instructions to reset your password.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: fontSize12,
                color: gGreyColor,
                fontFamily: kFontBook,
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.only(top: 3.h, bottom: 2.h),
                child: ButtonWidget(
                  text: "Next",
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const AuthScreen(),
                      ),
                    );
                  },
                  isLoading: false,
                  buttonWidth: double.maxFinite,
                ),
              ),
            ),
            Text(
              "Didn't receive the email? Check your spam folder or try again.",
              textAlign: TextAlign.center,
              style: TextStyle(
              fontSize: fontSize12,
              color: gGreyColor,
              fontFamily: kFontBook,
            ),
            ),
          ],
        ),
      ),
    );
  }
}
