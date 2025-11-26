import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../utils/constants.dart';

buildThreeBounceIndicator({Color? color}) {
  return Center(
    child: SpinKitThreeBounce(
      color: color ?? gMainColor,
      size: 20,
    ),
  );
}

buildTextFieldHeading(String title) {
  return Padding(
    padding: EdgeInsets.only(left: 1.w, bottom: 1.h),
    child: Text(
      title,
      style: TextStyle(
        fontFamily: fontMedium,
        color: primaryColor,
        fontSize: fontSize15,
      ),
    ),
  );
}

// buildTextFieldHeading(String title, {bool isRequired = false}) {
//   return Padding(
//     padding: EdgeInsets.only(top: 2.h, bottom: 1.h),
//     child: Row(
//       children: [
//         Text(
//           title,
//           style: TextStyle(
//             fontFamily: kFontMedium,
//             fontSize: fontSize11,
//             color: gBlackColor.withOpacity(0.8),
//           ),
//         ),
//         isRequired
//             ? Text(
//                 " *",
//                 style: TextStyle(
//                   fontFamily: kFontMedium,
//                   fontSize: registerTextFieldHeading,
//                   color: gSecondaryColor,
//                 ),
//               )
//             : const SizedBox(),
//       ],
//     ),
//   );
// }

statusWidget(String title, String answer) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 0.5.h),
    child: IntrinsicWidth(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              height: 1.3,
              fontFamily: fontBook,
              color: gBlackColor,
              fontSize: fontSize14,
            ),
          ),
          Text(
            answer,
            style: TextStyle(
              fontFamily: fontMedium,
              height: 1.3,
              color: gBlackColor,
              fontSize: fontSize14,
            ),
          ),
        ],
      ),
    ),
  );
}

tabBarText(String title, int count) {
  return Row(
    children: [
      Text(title),
      SizedBox(width: 1.w),
      count == 0
          ? const SizedBox()
          : Container(
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(
                color: kNumberCircleRed,
                shape: BoxShape.circle,
              ),
              child: Text(
                count.toString(),
                style: TextStyle(
                  fontSize: fontSize07,
                  fontFamily: fontMedium,
                  color: gWhiteColor,
                ),
              ),
            )
    ],
  );
}

buildTextField({
  TextEditingController? controller,
  FormFieldValidator? validation,
  String? hintText,
  Widget? prefixWidget,
  Widget? suffixWidget,
  TextInputType? type,
  bool? isPassword,
}) {
  return TextFormField(
    controller: controller,
    style: TextStyles().textFieldMainText(),
    textInputAction: TextInputAction.next,
    textAlign: TextAlign.start,
    keyboardType: type,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    cursorColor: gBlackColor,
    textAlignVertical: TextAlignVertical.center,
    obscureText: isPassword!,
    validator: validation!,
    decoration: InputDecoration(
      fillColor: gWhiteColor,
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: gHintTextColor.withOpacity(0.5)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: gHintTextColor.withOpacity(0.5)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: gHintTextColor.withOpacity(0.5)),
      ),
      prefixIcon: prefixWidget,
      hintText: hintText,
      hintStyle: TextStyles().textFieldHintText(),
      suffixIcon: suffixWidget,
    ),
  );
}

// backButtonWidget({
//   VoidCallback? func,
//   Color? color,
//   bool isText = false,
//   bool isDrawer = false,
//   String? title,
//   bool showText = false,
//   Color? textColor,
//   double? textSize,
//   VoidCallback? drawerFunc,
// }) {
//   Color buttonColors = color ?? gWhiteColor;
//   Color textColors = textColor ?? gBlackColor;
//   double textSizes = textSize ?? fontSize12;
//   return AppBar(
//     elevation: 4.0, toolbarHeight: 6.h,
//     shadowColor:
//         gGreyColor.withOpacity(0.5), // Customize shadow color if needed
//     backgroundColor: gWhiteColor,
//     automaticallyImplyLeading: false,
//     title: Row(
//       children: [
//         isText
//             ? GestureDetector(
//                 onTap: func,
//                 child: Icon(
//                   Icons.arrow_back_ios_sharp,
//                   color: buttonColors,
//                   size: 3.h,
//                 ),
//               )
//             : const SizedBox(),
//         isText ? SizedBox(width: 2.w) : const SizedBox(),
//        showText ? Text(title.toString()) : Image(
//           image: const AssetImage("assets/images/logo1.png"),
//           height: 4.h,
//         ),
//       ],
//     ),
//     actions: isDrawer
//         ? [
//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.2.h),
//               color: secondaryColor,
//               child: GestureDetector(
//                 onTap: drawerFunc,
//                 child: Icon(
//                   Icons.menu,
//                   color: gWhiteColor,
//                   size: 3.h,
//                 ),
//               ),
//             ),
//             SizedBox(width: 3.w),
//           ]
//         : [],
//   );
// }

goToScreen({dynamic screenName, BuildContext? context}) {
  print(screenName);
  Navigator.of(context!).push(
    MaterialPageRoute(
      builder: (context) => screenName,
      // builder: (context) => isConsultationCompleted ? ConsultationSuccess() : const DoctorCalenderTimeScreen(),
    ),
  );
}
