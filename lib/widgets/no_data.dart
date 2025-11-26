import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class NoData extends StatelessWidget {
  final String? reason;
  const NoData({super.key, this.reason});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.h),
      child: Text(reason ?? "No Data"),
      // Image.asset(
      //   "assets/images/Group 5295.png",
      //   height: 40.h,
      // ),
    );
  }
}
