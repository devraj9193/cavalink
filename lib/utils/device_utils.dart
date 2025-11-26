import 'package:flutter/foundation.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

/// Enum for clearly identifying the environment + device type
enum DeviceType {
  mobileAppPhone,
  mobileAppTablet,
  webMobileBrowser,
  webTabletBrowser,
  webDesktopBrowser,
}

/// Utility class for device detection
class DeviceUtils {
  /// Get the detailed device type
  static DeviceType getDeviceType() {
    if (kIsWeb) {
      // Web version - now detect screen type
      if (Device.screenType == ScreenType.tablet) {
        return DeviceType.webTabletBrowser;
      } else if (Device.screenType == ScreenType.mobile) {
        return DeviceType.webMobileBrowser;
      } else {
        return DeviceType.webDesktopBrowser;
      }
    } else {
      // Mobile App (APK / IPA)
      if (Device.screenType == ScreenType.tablet) {
        return DeviceType.mobileAppTablet;
      } else {
        return DeviceType.mobileAppPhone;
      }
    }
  }

  /// Shortcuts
  static bool isWeb() => kIsWeb;
  static bool isMobileApp() => !kIsWeb;

  static bool isWebMobileBrowser() =>
      isWeb() && getDeviceType() == DeviceType.webMobileBrowser;

  static bool isWebTabletBrowser() =>
      isWeb() && getDeviceType() == DeviceType.webTabletBrowser;

  static bool isWebDesktopBrowser() =>
      isWeb() && getDeviceType() == DeviceType.webDesktopBrowser;

  static bool isMobileAppPhone() =>
      isMobileApp() && getDeviceType() == DeviceType.mobileAppPhone;

  static bool isMobileAppTablet() =>
      isMobileApp() && getDeviceType() == DeviceType.mobileAppTablet;
}
