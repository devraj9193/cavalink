import 'package:cavalink/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:provider/provider.dart';
import '../../../controllers/models/auth_models/login_model.dart';
import '../../../controllers/providers/auth_provider.dart';
import '../../../utils/app_config.dart';
import '../../../utils/constants.dart';
import '../../../widgets/button_widget.dart';
import '../../auth_screens/auth_screen.dart';

class LogoutScreen extends StatefulWidget {
  final UserDetails? userDetails;
  const LogoutScreen({super.key, this.userDetails});

  @override
  State<LogoutScreen> createState() => _LogoutScreenState();
}

class _LogoutScreenState extends State<LogoutScreen> {

  final pref = AppConfig().preferences!;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: const AssetImage("assets/images/logo1.png"),
            height: 15.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5.h),
            child: Text(
              'Logout',
              style: TextStyle(
                fontSize: fontSize15,
                fontFamily: kFontMedium,
                color: gBlackColor,
              ),
            ),
          ),
          Text(
            'Hi ${widget.userDetails?.name},',
            style: TextStyle(
              fontSize: fontSize13,
              fontFamily: kFontBook,
              color: gBlackColor,
            ),
          ),
          SizedBox(height: 0.5.h),
          Text(
            'Are you sure you want to log out from My App?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: fontSize12,
              fontFamily: kFontBook,
              color: gBlackColor,
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ButtonWidget(
                text: "No",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DashboardScreen(initialIndex: 0,tapIndex: 0,),
                    ),
                  );
                },
                isLoading: false,
                buttonWidth: 40.w ,
                radius: 8,
                color: gWhiteColor,
                textColor: gBlackColor,
              ),
              SizedBox(width: 3.w),
              ButtonWidget(
                text: "Yes",
                onPressed: () {
                  Provider.of<AuthProvider>(context, listen: false)
                      .logout(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AuthScreen(),
                    ),
                  );
                },
                isLoading: false,
                buttonWidth:40.w ,
                radius: 8,
                color: mainColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
