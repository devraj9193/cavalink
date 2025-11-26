import 'dart:convert';
import 'package:flutter/material.dart';
import '../../screens/auth_screens/auth_screen.dart';
import '../../screens/dashboard_screen.dart';
import '../../utils/api_end_points.dart';
import '../../utils/app_config.dart';
import '../../utils/navigation_helper.dart';
import '../../utils/network_service.dart';
import '../models/auth_models/login_model.dart';

class AuthProvider with ChangeNotifier {
  final pref = AppConfig().preferences!;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;
  LoginModel? loginModel;

  /// Login Method
  Future<void> login(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await NetworkService.post(
        ApiEndpoints.loginApiUrl(),
        {
          'email': emailController.text.trim(),
          'password': passwordController.text.trim(),
        },
        useToken: false,
      );
      // Check API status
      if (response['status'] == true) {
        loginModel = LoginModel.fromJson(response);

        final token = loginModel?.data?.token;

        if (token != null && token.isNotEmpty) {
          /// ---- SAVE LOGIN STATUS ---- ///
          await pref.setBool(AppConfig.isLogin, true);
          await pref.setString(AppConfig.isToken, token);

          /// ---- SAVE USER DATA ---- ///
          final userData = loginModel?.data?.userDetails;
          if (userData != null) {
            await pref.setString(
                AppConfig.isUser, jsonEncode(userData.toJson()));
          }

          isLoading = false;
          notifyListeners();

          /// ---- NAVIGATE ---- ///
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => DashboardScreen(initialIndex: 0),
            ),
          );
          return;
        }
      }

      // If reached here = login failed
      isLoading = false;
      notifyListeners();
      AppConfig().showSnackBar(
        context,
        response['message'] ?? "Login failed.",
        isError: true,
      );
    } catch (e) {
      isLoading = false;
      notifyListeners();
      AppConfig().showSnackBar(
        context,
        "Something went wrong! $e",
        isError: true,
      );
    }
  }

  /// Check Login Status on App Launch
  Future<void> checkLoginStatus(BuildContext context) async {
    await Future.delayed(Duration(seconds: 2));
    bool isLoggedIn = pref.getBool(AppConfig.isLogin) ?? false;

    if (isLoggedIn) {
      NavigationHelper.pushReplacement(
          context, DashboardScreen(initialIndex: 0));
    } else {
      NavigationHelper.pushReplacement(context, AuthScreen());
    }
  }

  /// Logout and clear preferences
  Future<void> logout(BuildContext context) async {
    await pref.clear();
    clearForm();
    isLoading = false;
    notifyListeners();
    NavigationHelper.pushReplacement(context, AuthScreen());
  }

  /// Clear the form inputs
  void clearForm() {
    emailController.clear();
    passwordController.clear();
    notifyListeners();
  }

  /// Dispose controllers
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
