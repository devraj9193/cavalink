import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

const primaryColor = Color(0xff005BE7);
const mainColor = Color(0xffA8A9B1);
const gPrimaryColor = Color(0xff00B1B0);
const secondaryColor = Color(0xffE4002B);
const footerColor = Color(0xff22262F);
const appointmentTabColor = Color(0xffF5F6FA);

const gGreyColor = Color(0xff707070);
const gBlackColor = Color(0xff000000);
const gWhiteColor = Color(0xffFFFFFF);
const gHintTextColor = Color(0xff676363);
const sosColor = Color(0xffFF5963);
const listIconColor = Color(0xffED8F5C);
const listIcon1Color = Color(0xff34D1BC);

const bgColor = Color(0xffE6E6E6);
const buttonColor = Color(0xffF20032);
const tapSelectedColor = gBlackColor;
const tapUnSelectedColor = gHintTextColor;
const tapIndicatorColor = Color(0xff6957D0);
const tealColor = Color(0xff39CCC4);
const containerBgColor = Color(0xffE1E4E9);

const newLightGreyColor = Color(0xffB9B4B4);

//fonts
const String fontBold = "GothamBold";
const String fontMedium = "GothamMedium";
const String fontBook = "GothamBook";

// --- NEW FONT SIZE --- //
double fontSize20 = 20.dp;
double fontSize19 = 19.dp;
double fontSize18 = 18.dp;
double fontSize17 = 17.dp;
double fontSize16 = 16.dp;
double fontSize15 = 15.dp;
double fontSize14 = 14.dp;
double fontSize13 = 13.dp;
double fontSize12 = 12.dp;
double fontSize11 = 11.dp;
double fontSize10 = 10.dp;
double fontSize09 = 9.dp;
double fontSize08 = 8.dp;
double fontSize07 = 7.dp;

//textStyles
class TextStyles {

  /// Auth Screen ///
  TextStyle tapSelectedText() {
    return TextStyle(
      fontFamily: fontMedium,
      color: gBlackColor,
      fontSize: fontSize14,
    );
  }

  TextStyle tapUnSelectedText() {
    return TextStyle(
      fontFamily: fontBook,
      color: lightTextColor,
      fontSize: fontSize12,
    );
  }

  TextStyle headingText() {
    return TextStyle(
      fontFamily: fontMedium,
      color: gBlackColor,
      fontSize: fontSize20,
    );
  }

  TextStyle subHeadingText() {
    return TextStyle(
      fontFamily: fontBook,
      color: gBlackColor,
      fontSize: fontSize15,
    );
  }

  TextStyle textFieldHintText() {
    return TextStyle(
      fontFamily: fontBook,
      color: gHintTextColor,
      fontSize: fontSize14,
    );
  }

  TextStyle textFieldMainText() {
    return TextStyle(
      fontFamily: fontMedium,
      color: gBlackColor,
      fontSize: fontSize15,
    );
  }
}







var bottomBarHeading = 10.dp;
var loginHeading = 20.dp;
var buttonFontSize = 10.dp;
var backButton = 14.dp;
var otpSubHeading = 11.dp;
var registerTextFieldHeading = 10.dp;
var textFieldHintText = 9.dp;
var textFieldText = 10.dp;
var resendTextSize = 11.dp;
var bottomSheetHeadingFontSize = 12.dp;
var listHeadingSize = 16.dp;
var listSubHeadingSize = 10.dp;
var listOtherSize = 13.dp;
var tapSelectedSize = 10.dp;
var tapUnSelectedSize = 10.dp;


const loginButtonColor = Color(0xffE6E6E6);
const loginButtonSelectedColor = Color(0xffF2F2F2);
const policyColor = Color(0xff0082FC);

const imageBackGround = Color(0xffB1B1B1);

String textFieldHintFont = kFontMedium;
String textFieldFont = kFontMedium;
String buttonFont = kFontBold;
String resendFont = kFontMedium;
String bottomSheetHeadingFontFamily = kFontBold;
String listHeadingFont = kFontBold;
String listSubHeadingFont = kFontMedium;
String listOtherFont = kFontBook;
String tapFont = kFontMedium;

const appPrimaryColor = Color(0xffFF6505);

const textFieldColor = gBlackColor;
const textFieldHintColor = gGreyColor;
const textFieldUnderLineColor = gGreyColor;
// const buttonColor = gBlackColor;
const resendDisableColor = gGreyColor;
const resendActiveColor = gSecondaryColor;
const bottomSheetHeadingColor = gBlackColor;
const containerBackGroundColor = loginButtonColor;

// const gPrimaryColor = Color(0xff4E7215);

// const gsecondaryColor = Color(0xffC10B02);
// const gsecondaryColor = Color(0xffD10034);
const gSecondaryColor = Color(0xffEE1004);

const gMainColor = Color(0xffC7A102);

const gTextColor = Color(0xff000000);
// const gHintTextColor = Color(0xff676363);
const kLineColor = Color(0xffB9B4B4);
const gBgColor = Color(0xffFAFAFA);

const lightTextColor = Color(0xffB9B4B4);

const String kFontMedium = 'GothamMedium';
const String kFontBook = 'GothamBook';
const String kFontBold = 'GothamBold';

const kBottomSheetHeadYellow = Color(0xffFFE281);
const kBottomSheetHeadGreen = Color(0xffA7C652);
const kBottomSheetHeadCircleColor = Color(0xffFFF9F8);

// new dashboard colors
const kNumberCircleRed = Color(0xffEF8484);
const kNumberCirclePurple = Color(0xff9C7ADF);
const kNumberCircleAmber = Color(0xffFFBD59);
const kNumberCircleGreen = Color(0xffA7CB52);

double bottomSheetSubHeadingXLFontSize = 12.dp;
double bottomSheetSubHeadingXFontSize = 11.dp;
double bottomSheetSubHeadingSFontSize = 10.dp;
String bottomSheetSubHeadingBoldFont = kFontBold;
String bottomSheetSubHeadingMediumFont = kFontMedium;
String bottomSheetSubHeadingBookFont = kFontBook;

const bsHeadPinIcon = "assets/images/bs-head-pin.png";
const bsHeadBellIcon = "assets/images/bs-head-bell.png";
const bsHeadBulbIcon = "assets/images/bs-head-bulb.png";
const bsHeadStarsIcon = "assets/images/bs-head-stars.png";



var headingFontSize = 12.dp;
var midSubHeadingFontSize = 11.dp;
var subHeadingFontSize = 10.dp;

var smallFontSize = 8.dp;
var mediumFontSize1 = 9.dp;
var mediumFontSize2 = 10.dp;

TextStyle hintStyle = TextStyle(
    fontSize: mediumFontSize2,
    color: gHintTextColor,
    fontFamily: kFontBook
);

TextStyle fieldTextStyle({Color? color, double? fontSize, String? fontFamily}){
  return TextStyle(
      fontSize: fontSize ?? mediumFontSize2,
      color: color ?? gTextColor,
      fontFamily: fontFamily ?? kFontMedium
  );
}

TextStyle btnTextStyle({Color? color, double? fontSize}){
  return TextStyle(
    fontSize: fontSize ?? mediumFontSize2,
    color: color ?? gWhiteColor,
    fontFamily: kFontMedium,
  );
}

// existing user
class User{
  var kRadioButtonColor = gSecondaryColor;
  var threeBounceIndicatorColor = gWhiteColor;

  var mainHeadingColor = gBlackColor;
  var mainHeadingFont = kFontBold;
  double mainHeadingFontSize = 15.dp;

  var userFieldLabelColor =  gBlackColor;
  var userFieldLabelFont = kFontMedium;
  double userFieldLabelFontSize = 15.dp;
  /*
  fontFamily: "GothamBook",
  color: gHintTextColor,
  fontSize: 11.dp
   */
  var userTextFieldColor =  gHintTextColor;
  var userTextFieldFont = kFontBook;
  double userTextFieldFontSize = 13.dp;

  var userTextFieldHintColor =  Colors.grey.withOpacity(0.5);
  var userTextFieldHintFont = kFontMedium;
  double userTextFieldHintFontSize = 13.dp;

  var focusedBorderColor = gBlackColor;
  var focusedBorderWidth = 1.5;

  var fieldSuffixIconColor = primaryColor;
  var fieldSuffixIconSize = 22;

  var fieldSuffixTextColor =  gBlackColor.withOpacity(0.5);
  var fieldSuffixTextFont = kFontMedium;
  double fieldSuffixTextFontSize = 8.dp;

  var resendOtpFontSize = 9.dp;
  var resendOtpFont = kFontBook;
  var resendOtpFontColor = gSecondaryColor;

  var buttonColor = gSecondaryColor;
  var buttonTextColor = gWhiteColor;
  double buttonTextSize = 14.dp;
  var buttonTextFont = kFontBold;
  var buttonBorderColor = kLineColor;
  double buttonBorderWidth = 1;



  var buttonBorderRadius = 30.0;

  var loginDummyTextColor =  Colors.black87;
  var loginDummyTextFont = kFontBook;
  double loginDummyTextFontSize = 9.dp;

  var anAccountTextColor =  gHintTextColor;
  var anAccountTextFont = kFontMedium;
  double anAccountTextFontSize = 10.dp;

  var loginSignupTextColor =  gSecondaryColor;
  var loginSignupTextFont = kFontBold;
  double loginSignupTextFontSize = 10.5.dp;

}