import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:im_animations/im_animations.dart';
import 'package:provider/provider.dart';

import 'controllers/providers/auth_provider.dart';
import 'utils/app_config.dart';
import 'utils/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with WidgetsBindingObserver {
  final pref = AppConfig().preferences!;

  @override
  void initState() {
    super.initState();
    Provider.of<AuthProvider>(context, listen: false).checkLoginStatus(context);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: gWhiteColor,
      body: Center(
        child: HeartBeat(
          beatsPerMinute: 25,
          child: Image(
            width:  80.w,
            height:100.h,
            image: const AssetImage("assets/images/logo1.png"),
          ),
        ),
      ),
    );
  }
}
