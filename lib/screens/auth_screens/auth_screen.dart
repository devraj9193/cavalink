import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:provider/provider.dart';

import '../../controllers/providers/auth_provider.dart';
import '../../utils/app_config.dart';
import '../../utils/constants.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/exit_widget.dart';
import '../../widgets/text_field_widgets/custom_date_text_field.dart';
import 'forgot_password_screens/forgot_password_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final formKey = GlobalKey<FormState>();
  bool passwordVisible = false;

  Future<bool> _onWillPop() async {
    AppConfig().showSheet(
      context,
      const ExitWidget(),
      bottomSheetHeight: 45.h,
      isDismissible: true,
    );
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AuthProvider>();

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) => !didPop ? _onWillPop() : null,
      child: Scaffold(
        backgroundColor: gWhiteColor,
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
              child: IntrinsicHeight(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/logo1.png", height: 8.h),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 4.h),
                      child: Text('Login', style: TextStyles().headingText()),
                    ),
                    _buildForm(provider),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildForm(AuthProvider provider) {
    return Form(
      key: formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _fieldLabel("User Name"),
            CustomTextField(
              controller: provider.emailController,
              hintText: "User Name",
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              borderType: TextFieldBorderType.full,
              prefixIcon: Icons.person_outline,
              suffixWidget: _usernameSuffix(provider),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter your username';
                }
                if (value.trim().length < 3) {
                  return 'Username must be at least 3 characters';
                }
                return null;
              },
            ),
            SizedBox(height: 2.h),
            _fieldLabel("Password"),
            CustomTextField(
              controller: provider.passwordController,
              hintText: "Password",
              textInputAction: TextInputAction.done,
              obscureText: !passwordVisible,
              borderType: TextFieldBorderType.full,
              prefixIcon: Icons.lock_outline,
              suffixWidget: InkWell(
                onTap: () => setState(() => passwordVisible = !passwordVisible),
                child: Icon(
                  passwordVisible
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: passwordVisible ? Colors.teal : Colors.grey,
                ),
              ),
              onFieldSubmitted: (_) async {
                if (formKey.currentState!.validate()) {
                  await provider.login(context);
                }
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter your password";
                }
                if (value.length < 6) {
                  return "Password must be at least 6 characters";
                }
                return null;
              },
            ),
            SizedBox(height: 1.5.h),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ForgotPasswordScreen(),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(right: 3.w),
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                      fontFamily: fontMedium,
                      color: gHintTextColor,
                      fontSize: fontSize15,
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 5.h),
                child: ButtonWidget(
                  text: "Login",
                  isLoading: provider.isLoading,
                  onPressed: provider.isLoading
                      ? null
                      : () async {
                    if (formKey.currentState!.validate()) {
                      await provider.login(context);
                    }
                  },
                  buttonWidth: 20.w,
                  radius: 8,
                  color: mainColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _fieldLabel(String title) => Padding(
    padding: EdgeInsets.only(left: 1.w, bottom: 1.h),
    child: Text(
      title,
      style: TextStyle(
        fontFamily: fontMedium,
        color: gHintTextColor,
        fontSize: fontSize16,
      ),
    ),
  );

  Widget _usernameSuffix(AuthProvider provider) {
    final text = provider.emailController.text.trim();
    if (text.isEmpty) return const SizedBox();

    return InkWell(
      onTap: () => provider.emailController.clear(),
      child: Icon(Icons.close, color: gBlackColor, size: 15.dp),
    );
  }
}
