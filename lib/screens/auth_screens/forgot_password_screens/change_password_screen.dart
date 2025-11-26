import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import '../../../utils/app_config.dart';
import '../../../utils/constants.dart';
import '../../../widgets/button_widget.dart';
import '../../../widgets/common_app_bar_widget.dart';
import '../../../widgets/common_widgets.dart';
import '../auth_screen.dart';

class ChangePasswordScreen extends StatefulWidget {
  final String otp;
  final String email;
  const ChangePasswordScreen(
      {super.key, required this.otp, required this.email});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController otpController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool isOtpVerified = false;
  bool isLoading = false;
  late bool passwordVisibility;
  late bool confirmPasswordVisibility;

  @override
  void initState() {
    super.initState();
    passwordVisibility = false;
    confirmPasswordVisibility = false;
  }

  void verifyOTP() {
    setState(() {
      isLoading = true;
    });

    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
        if (otpController.text == widget.otp) {
          isOtpVerified = true;
        } else {
          AppConfig().showSnackBar(context, 'Invalid OTP! Please try again.',
              isError: true);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: gWhiteColor,
      appBar: CommonAppBarWidget(
        showLogo: true,
        onBackTap: () =>Navigator.pop(context),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 2.h),
              Center(
                child: Text(
                  "Reset Password",
                  style: TextStyle(
                    fontSize: fontSize20,
                    fontFamily: kFontMedium,
                    color: gBlackColor,
                  ),
                ),
              ),
              SizedBox(height: 10),
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
                child: buildTextFieldHeading("Your OTP"),
              ),
              buildTextField(
                controller: otpController,
                hintText: "OTP",
                type: TextInputType.number,
                isPassword: false,
                prefixWidget: Icon(
                  Icons.email,
                  color: gHintTextColor,
                  size: 15.dp,
                ),
                validation: (value) {
                  if (value == null || value.isEmpty) {
                    return "Password cannot be empty";
                  } else if (value.length < 6) {
                    return "Password must be at least 6 characters";
                  }
                  return null; // No error
                },
              ),
              SizedBox(height: 10),
              if (!isOtpVerified) ...[
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 5.h, bottom: 2.h),
                    child: ButtonWidget(
                      text: "Verify OTP",
                      onPressed: isLoading
                          ? () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const AuthScreen(),
                                ),
                              );
                            }
                          : verifyOTP,
                      isLoading: isLoading,
                      radius: 12,
                      buttonWidth: 35.w,
                    ),
                  ),
                ),
              ],
              if (isOtpVerified) ...[
                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 3.h, bottom: 1.h),
                        child: buildTextFieldHeading("New Password"),
                      ),
                      buildTextField(
                        controller: passwordController,
                        hintText: "Password",
                        type: TextInputType.visiblePassword,
                        isPassword: !passwordVisibility,
                        prefixWidget: Icon(
                          Icons.lock_outline_sharp,
                          color: gBlackColor,
                          size: 15.dp,
                        ),
                        suffixWidget: InkWell(
                          onTap: () {
                            setState(() {
                              passwordVisibility = !passwordVisibility;
                            });
                          },
                          child: Icon(
                            passwordVisibility
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: passwordVisibility
                                ? primaryColor
                                : gHintTextColor,
                            size: 15.dp,
                          ),
                        ),
                        validation: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter a password";
                          } else if (value.length < 6) {
                            return "Password must be at least 6 characters long";
                          }
                          return null;
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 2.h, bottom: 1.h),
                        child: buildTextFieldHeading("Confirm Password"),
                      ),
                      buildTextField(
                        controller: confirmPasswordController,
                        hintText: "Confirm Password",
                        type: TextInputType.visiblePassword,
                        isPassword: !confirmPasswordVisibility,
                        prefixWidget: Icon(
                          Icons.lock_outline_sharp,
                          color: gBlackColor,
                          size: 15.dp,
                        ),
                        suffixWidget: InkWell(
                          onTap: () {
                            setState(() {
                              confirmPasswordVisibility =
                                  !confirmPasswordVisibility;
                            });
                          },
                          child: Icon(
                            confirmPasswordVisibility
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: confirmPasswordVisibility
                                ? primaryColor
                                : gHintTextColor,
                            size: 15.dp,
                          ),
                        ),
                        validation: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please confirm your password";
                          } else if (value != passwordController.text) {
                            return "Passwords do not match";
                          }
                          return null;
                        },
                      ),
                      Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 5.h, bottom: 2.h),
                          child: ButtonWidget(
                            text: "Reset Password",
                            onPressed: isReset
                                ? () {}
                                : () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const AuthScreen(),
                                      ),
                                    );
                                    // if (confirmPasswordController.text
                                    //         .trim()
                                    //         .isEmpty ||
                                    //     passwordController.text
                                    //         .trim()
                                    //         .isEmpty) {
                                    //   AppConfig().showSnackBar(
                                    //       context, "All fields are required",
                                    //       isError: true);
                                    //   return;
                                    // }
                                    // if (formKey.currentState!.validate()) {
                                    //   buildLogin(passwordController.text);
                                    // }
                                  },
                            isLoading: isReset,
                            radius: 12,
                            buttonWidth: 35.w,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  bool isReset = false;

  Future<void> buildLogin(String pwd) async {
    setState(() {
      isReset = true;
    });
    print("---------Reset Password---------");
    try {
      // final response = await supabase
      //     .from('users')
      //     .update({'password': pwd}).eq('email', widget.email);
      //
      // print("user profile : $response");
      AppConfig()
          .showSnackBar(context, "Reset Password Successful", isError: false);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const AuthScreen(),
        ),
      );
    }catch (error) {
      AppConfig()
          .showSnackBar(context, 'Unexpected error occurred', isError: true);
    } finally {
      if (mounted) {
        setState(() {
          isReset = false;
        });
      }
    }
  }
}
