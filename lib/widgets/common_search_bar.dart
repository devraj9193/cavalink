import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

import '../../../../utils/opacity_to_alpha.dart';
import '../utils/constants.dart';

class CommonSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClear;
  final String hintText;
  final bool autoFocus;
  final double width;

  const CommonSearchBar({
    super.key,
    required this.controller,
    this.onChanged,
    this.onClear,
    this.hintText = "Search...",
    this.autoFocus = false,
    this.width = 20,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        width: width.w,
        height: 5.h,
        margin: EdgeInsets.only(top: 1.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          border: Border.all(
            color: gGreyColor.withAlpha(AlphaHelper.fromOpacity(0.3)),
          ),
          boxShadow: [
            BoxShadow(
              color: gGreyColor.withAlpha(AlphaHelper.fromOpacity(0.3)),
              blurRadius: 2,
            ),
          ],
        ),
        child: TextField(
          controller: controller,
          cursorColor: gBlackColor,
          cursorHeight: 2.h,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.search,
              size: 2.5.h,
              color: gHintTextColor,
            ),
            hintText: hintText,
            border: InputBorder.none,
            suffixIcon: controller.text.isNotEmpty
                ? IconButton(
              icon: Icon(
                Icons.close_outlined,
                size: 2.5.h,
                color: gHintTextColor,
              ),
              onPressed: onClear,
            )
                : null,
            hintStyle: TextStyle(
              fontSize: 12.dp,
              color: gHintTextColor,
              fontFamily: fontMedium,
            ),
          ),
          onChanged: onChanged,
          autofocus: autoFocus,
          style: fieldTextStyle(),
        ),
      ),
    );
  }
}
