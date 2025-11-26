import 'dart:convert';

import 'package:cavalink/controllers/providers/fence_providers.dart';
import 'package:cavalink/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:provider/provider.dart';
import '../../utils/constants.dart';
import '../controllers/models/auth_models/login_model.dart';
import '../utils/app_config.dart';
import '../utils/opacity_to_alpha.dart';
import '../widgets/common_app_bar_widget.dart';
import '../widgets/exit_widget.dart';
import 'my_event_screens/my_events.dart';
import 'profile_screens/logout_screens/logout_screen.dart';

class DashboardScreen extends StatefulWidget {
  final int initialIndex;
  final int? tapIndex;

  const DashboardScreen({
    super.key,
    this.initialIndex = 0,
    this.tapIndex,
  });

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;
  UserDetails? userDetails;
  final pref = AppConfig().preferences;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
    loadUser();
  }

  void loadUser() async {
    final prefs = pref; // or await SharedPreferences.getInstance()

    final userString = prefs?.getString(AppConfig.isUser);

    if (userString == null) return;

    try {
      final Map<String, dynamic> userMap =
      jsonDecode(userString) as Map<String, dynamic>;

      userDetails = UserDetails.fromJson(userMap);

      // Call provider AFTER build() is ready
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Provider.of<FenceProvider>(context, listen: false)
            .fetchEvents(context, userDetails?.clubId ?? 0);
      });

      setState(() {});
    } catch (e) {
      print("User parse error: $e");
    }
  }

  void _onDrawerItemTapped(int index) {
    setState(() => _selectedIndex = index);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final eventProv = Provider.of<FenceProvider>(context);

    final screens = [
      // My Events Screen
      MyEvents(
        ongoing: eventProv.myOngoing,
        upcoming: eventProv.myUpcoming,
        completed: eventProv.myCompleted,
      ),

      // All Events Screen (Other Events)
      MyEvents(
        ongoing: eventProv.otherOngoing,
        upcoming: eventProv.otherUpcoming,
        completed: eventProv.otherCompleted,
      ),

      LogoutScreen(userDetails: userDetails),
    ];

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) showLogoutDialog();
      },
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: gWhiteColor,
        appBar: CommonAppBarWidget(
          showBack: false,
          showLogo: true,
          showDrawer: true,
          appBarHeight: 7,
          onDrawerTap: () => _scaffoldKey.currentState?.openDrawer(),
          elevation: 0,
        ),
        drawer: SizedBox(
          width: 60.w,
          child: Drawer(
            backgroundColor: gWhiteColor,
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.only(left: 3.w, top: 3.h, right: 2.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Logo and close button row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          "assets/images/logo1.png",
                          height: 4.5.h,
                          // color: gBlackColor,
                        ),
                        IconButton(
                          icon: Icon(Icons.close,
                              color: gHintTextColor, size: 3.h),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
                    ),
                    SizedBox(height: 3.h),

                    /// Drawer items
                    _buildDrawerItem('My Events', 0),
                    _buildDrawerItem('All Events', 1),
                    _buildDrawerItem('Logout', 2),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: eventProv.isEventsLoading
            ? LoadingIndicator()
            : screens[_selectedIndex],
      ),
    );
  }

  Widget _buildDrawerItem(String title, int index) {
    final isSelected = _selectedIndex == index;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.5.h),
      child: GestureDetector(
        onTap: () => _onDrawerItemTapped(index),
        child: Row(
          children: [
            if (isSelected)
              Container(
                width: 1.w,
                height: 2.h,
                color: gBlackColor,
                margin: EdgeInsets.only(right: 2.w),
              ),
            Text(
              title,
              style: TextStyle(
                color: isSelected ? gBlackColor : gHintTextColor,
                fontFamily: isSelected ? kFontMedium : kFontBook,
                fontSize: isSelected ? fontSize16 : fontSize15,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Show exit confirmation dialog (like logout)
  void showLogoutDialog() {
    showDialog(
      barrierDismissible: false,
      barrierColor: gWhiteColor.withAlpha(AlphaHelper.fromOpacity(0.8)),
      context: context,
      builder: (context) => Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 8.w),
            padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: gWhiteColor,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: lightTextColor),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                ExitWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
