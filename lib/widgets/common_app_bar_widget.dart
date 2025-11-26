import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import '../utils/constants.dart';
import '../utils/opacity_to_alpha.dart';

class CommonAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final VoidCallback? onBackTap;
  final double? elevation;
  final String? title;
  final bool showBack;
  final bool showTitleText;
  final bool showLogo;
  final Color? backIconColor;
  final double? titleFontSize;
  final bool showDrawer;
  final VoidCallback? onDrawerTap;
  final bool isDownloading;
  final int downloadProgress;
  final Widget? customTitle;
  final Widget? customAction;
  final VoidCallback? onDownloadTap;
  final VoidCallback? onShareTap;
  final VoidCallback? onGraphTap;
  final double appBarHeight;

  const CommonAppBarWidget({
    super.key,
    this.onBackTap,
    this.elevation = 4,
    this.title,
    this.showBack = true,
    this.showTitleText = false,
    this.showLogo = false,
    this.backIconColor,
    this.titleFontSize,
    this.showDrawer = false,
    this.onDrawerTap,
    this.isDownloading = false,
    this.downloadProgress = 0,
    this.customAction,
    this.onDownloadTap,
    this.onShareTap,
    this.onGraphTap,
    this.customTitle, this.appBarHeight = 10,
  });

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(appBarHeight.h),
      child: AppBar(
        elevation: elevation,
        backgroundColor: gWhiteColor,
        automaticallyImplyLeading: false,
        centerTitle: false, // 👈 Important
        titleSpacing: 0,    // 👈 Removes the default 16px padding
        toolbarHeight: appBarHeight.h,  // correct
        shadowColor: gGreyColor.withAlpha(AlphaHelper.fromOpacity(0.5)),
        title: customTitle ??
            Row(
              children: [
                if (showBack)
                  InkWell(
                    onTap: onBackTap ?? () => Navigator.pop(context),
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.arrow_back_ios_sharp,
                        color: backIconColor ?? gBlackColor,
                        size: 2.5.h,
                      ),
                    ),
                  ),
                // if (showBack) SizedBox(width: 1.w),
                if (showTitleText && title != null)
                  Expanded(
                    child: Text(
                      title!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: gBlackColor,
                        fontSize: titleFontSize ?? fontSize18,
                        fontFamily: kFontMedium,
                      ),
                    ),
                  )
                else if (showLogo)
                  Padding(
                    padding: EdgeInsets.only(left: 2.w),
                    child: Image.asset("assets/images/logo1.png", height: 5.h),
                  ),
              ],
            ),
        actions: [
          if (onDownloadTap != null)
            isDownloading
                ? Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: 3.h,
                    width: 3.h,
                    child: CircularProgressIndicator(
                      value: downloadProgress / 100,
                      color: gBlackColor,
                      strokeWidth: 2,
                    ),
                  ),
                  Text(
                    "$downloadProgress%",
                    style: TextStyle(
                      color: gBlackColor,
                      fontSize: fontSize10,
                      fontFamily: fontBook,
                    ),
                  ),
                ],
              ),
            )
                : Container(
              margin: EdgeInsets.only(right: 1.w),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: onDownloadTap,
                child:
                Icon(Icons.download, color: gBlackColor, size: 3.h),
              ),
            ),
          if (onShareTap != null)
            Container(
              margin: EdgeInsets.only(right: 3.w),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: onShareTap,
                child: Icon(Icons.share, color: gBlackColor, size: 3.h),
              ),
            ),
          if (showDrawer)
            InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: onDrawerTap,
              child: Container(
                margin: EdgeInsets.only(right: 3.w),
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.2.h),
                color: secondaryColor,
                child: Icon(Icons.menu, color: gWhiteColor, size: 3.h),
              ),
            ),
          if (onGraphTap != null)
            InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: onGraphTap,
              child: Container(
                  margin: EdgeInsets.only(right: 3.w),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.bar_chart, color: gBlackColor, size: 3.h)),
            ),
          customAction ?? SizedBox()
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBarHeight.h);
}


// import 'package:quantilab/utils/opacity_to_alpha.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_sizer/flutter_sizer.dart';
// import '../utils/constants.dart';
//
// class CommonAppBarWidget extends StatelessWidget
//     implements PreferredSizeWidget {
//   final VoidCallback? onBackTap;
//   final double? elevation;
//   final String? title;
//   final bool showBack;
//   final bool showTitleText;
//   final bool showLogo;
//   final Color? backIconColor;
//   final double? titleFontSize;
//   final bool showDrawer;
//   final VoidCallback? onDrawerTap;
//   final bool isDownloading;
//   final int downloadProgress;
//   final VoidCallback? onDownloadTap;
//   final VoidCallback? onShareTap;
//   final VoidCallback? onGraphTap;
//
//   const CommonAppBarWidget({
//     super.key,
//     this.onBackTap,
//     this.elevation = 4,
//     this.title,
//     this.showBack = true,
//     this.showTitleText = false,
//     this.showLogo = false,
//     this.backIconColor,
//     this.titleFontSize,
//     this.showDrawer = false,
//     this.onDrawerTap,
//     this.isDownloading = false,
//     this.downloadProgress = 0,
//     this.onDownloadTap,
//     this.onShareTap,
//     this.onGraphTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//
//     return PreferredSize(
//       preferredSize: Size.fromHeight(6.h ),
//       child: AppBar(
//         elevation: elevation,
//         backgroundColor: gWhiteColor,
//         automaticallyImplyLeading: false,
//         shadowColor: gGreyColor.withAlpha(AlphaHelper.fromOpacity(0.5)),
//         title: Row(
//           children: [
//             if (showBack)
//               InkWell(
//                 onTap: onBackTap ?? () => Navigator.pop(context),
//                 borderRadius: BorderRadius.circular(8),
//                 child: Container(
//                   padding: EdgeInsets.all(8),
//                   decoration: BoxDecoration(
//                     color: Colors.transparent,
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Icon(
//                     Icons.arrow_back_ios_sharp,
//                     color: backIconColor ?? gBlackColor,
//                     size: 2.5.h,
//                   ),
//                 ),
//               ),
//             if (showBack) SizedBox(width: 2.w),
//             if (showTitleText && title != null)
//               Text(
//                 title!,
//                 style: TextStyle(
//                   color: gBlackColor,
//                   fontSize: titleFontSize ?? fontSize16,
//                   fontFamily: kFontMedium,
//                 ),
//               )
//             else if (showLogo)
//               Image.asset("assets/images/logo1.png", height:  4.h ),
//           ],
//         ),
//         actions: [
//           if (onDownloadTap != null)
//             isDownloading
//                 ? Center(
//                     child: Stack(
//                       alignment: Alignment.center,
//                       children: [
//                         SizedBox(
//                           height: 3.h,
//                           width: 3.h,
//                           child: CircularProgressIndicator(
//                             value: downloadProgress / 100,
//                             color: gBlackColor,
//                             strokeWidth: 2,
//                           ),
//                         ),
//                         Text(
//                           "$downloadProgress%",
//                           style: TextStyle(
//                             color: gBlackColor,
//                             fontSize: fontSize10,
//                             fontFamily: fontBook,
//                           ),
//                         ),
//                       ],
//                     ),
//                   )
//                 : Container(
//                   margin: EdgeInsets.only(right: 1.w),
//                   padding: EdgeInsets.all(8),
//                   decoration: BoxDecoration(
//                         color: Colors.transparent,
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                   child: InkWell(
//                     borderRadius: BorderRadius.circular(8),
//                     onTap: onDownloadTap,
//                     child: Icon(Icons.download,
//                             color: gBlackColor, size: 3.h),
//                   ),
//                 ),
//           if (onShareTap != null)
//             Container(
//               margin: EdgeInsets.only(right: 3.w),
//               padding: EdgeInsets.all(8),
//               decoration: BoxDecoration(
//                   color: Colors.transparent,
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               child: InkWell(
//                 borderRadius: BorderRadius.circular(8),
//                 onTap: onShareTap,
//                 child: Icon(Icons.share, color: gBlackColor, size: 3.h),
//               ),
//             ),
//           if (showDrawer)
//             InkWell(
//               borderRadius: BorderRadius.circular(8),
//               onTap: onDrawerTap,
//               child: Container(
//                 margin: EdgeInsets.only(right: 3.w),
//                 padding: EdgeInsets.symmetric(horizontal: 2.w , vertical: 0.2.h),
//                 color: secondaryColor,
//                 child: Icon(Icons.menu, color: gWhiteColor, size: 3.h),
//               ),
//             ),
//           if (onGraphTap != null)
//             InkWell(
//               borderRadius: BorderRadius.circular(8),
//               onTap: onGraphTap,
//               child: Container(
//                   margin: EdgeInsets.only(right: 3.w),
//                   padding: EdgeInsets.all(8),
//                   decoration: BoxDecoration(
//                     color: Colors.transparent,
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Icon(Icons.bar_chart, color: gBlackColor, size:3.h)),
//             ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   Size get preferredSize => Size.fromHeight(8.h);
// }
