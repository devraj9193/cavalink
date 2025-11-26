import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import '../../../utils/constants.dart';
import '../../../widgets/button_widget.dart';
import '../../../widgets/common_app_bar_widget.dart';
import '../../../widgets/common_widgets.dart';
import 'change_password_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: gWhiteColor,
      appBar: CommonAppBarWidget(
        showLogo: true,
        onBackTap: () => Navigator.pop(context),
      ),
      body: SafeArea(
        child: buildForm(),
      ),
    );
  }

  buildForm() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                "Forgot Password",
                style: TextStyle(
                  fontSize: fontSize20,
                  fontFamily: kFontMedium,
                  color: gBlackColor,
                ),
              ),
            ),
            SizedBox(height: 1.h),
            Text(
              "We will send you an email with a link to reset your password, please enter the email associated with your account below.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: fontSize15,
                fontFamily: kFontBook,
                color: gGreyColor,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 3.h, bottom: 1.h),
              child: buildTextFieldHeading("Your email address..."),
            ),
            buildTextField(
              controller: emailController,
              hintText: "Email",
              type: TextInputType.emailAddress,
              isPassword: false,
              prefixWidget: Icon(
                Icons.mail_outline_sharp,
                color: gBlackColor,
                size: 15.dp,
              ),
              suffixWidget: (!RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(emailController.value.text))
                  ? emailController.text.isEmpty
                      ? Container(
                          width: 0,
                        )
                      : InkWell(
                          onTap: () {
                            emailController.clear();
                          },
                          child: const Icon(
                            Icons.close,
                            color: gBlackColor,
                            size: 15,
                          ),
                        )
                  : Icon(
                      Icons.check_circle,
                      color: primaryColor,
                      size: 15.dp,
                    ),
              validation: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your Email ID';
                } else if (!RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(value)) {
                  return 'Please enter your valid Email ID';
                } else {
                  return null;
                }
              },
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.only(top: 5.h, bottom: 2.h),
                child: ButtonWidget(
                  text: "Reset Password",
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ChangePasswordScreen(
                          otp: "123455",
                          email: emailController.text,
                        ),
                      ),
                    );
                  },
                  isLoading: false,
                  radius: 12,
                  buttonWidth: 35.w,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
