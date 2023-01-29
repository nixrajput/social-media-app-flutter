import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';
import 'package:social_media_app/constants/assets.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/extensions/string_extensions.dart';
import 'package:social_media_app/global_widgets/circular_progress_indicator.dart';
import 'package:social_media_app/global_widgets/primary_text_btn.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

abstract class AppUtility {
  /// Logger

  static final logger = TalkerFlutter.init();

  static void log(dynamic message, {String? tag}) {
    switch (tag) {
      case 'error':
        logger.error(message);
        break;
      case 'warning':
        logger.warning(message);
        break;
      case 'info':
        logger.info(message);
        break;
      case 'debug':
        logger.debug(message);
        break;
      case 'critical':
        logger.critical(message);
        break;
      default:
        logger.verbose(message);
        break;
    }
  }

  /// Close any open snack bar.

  static void closeSnackBar() {
    if (Get.isSnackbarOpen) Get.back<void>();
  }

  /// Close any open dialog.

  static void closeDialog() {
    if (Get.isDialogOpen ?? false) Get.back<void>();
  }

  /// Close any open bottom sheet.

  static void closeBottomSheet() {
    if (Get.isBottomSheetOpen ?? false) Get.back<void>();
  }

  static void closeFocus() {
    if (FocusManager.instance.primaryFocus!.hasFocus) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  /// Show Loading Dialog

  static void showLoadingDialog({
    double? value,
    bool? barrierDismissible,
    String? message,
  }) {
    closeSnackBar();
    closeDialog();
    Get.dialog(
      WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Container(
              padding: Dimens.edgeInsets16,
              decoration: BoxDecoration(
                color: Theme.of(Get.context!).dialogTheme.backgroundColor,
                borderRadius: BorderRadius.circular(Dimens.eight),
              ),
              constraints: BoxConstraints(
                maxWidth: Dimens.screenWidth,
                maxHeight: Dimens.screenHeight,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  NxCircularProgressIndicator(
                    size: Dimens.thirtyTwo,
                    strokeWidth: Dimens.four,
                    value: value,
                  ),
                  Dimens.boxHeight12,
                  Text(
                    message ?? StringValues.pleaseWait,
                    style: AppStyles.style16Normal.copyWith(
                      color: Theme.of(Get.context!).textTheme.bodyText1!.color,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      barrierDismissible: barrierDismissible ?? false,
      name: 'loading_dialog',
      navigatorKey: GlobalKey<NavigatorState>(),
    );
  }

  /// Text Logo

  static buildAppLogo(BuildContext context,
          {double? fontSize, bool? isCentered = false}) =>
      Text(
        StringValues.appName.toUpperCase(),
        style: AppStyles.style24Bold.copyWith(
          fontFamily: "Muge",
          fontSize: fontSize,
          letterSpacing: Dimens.four,
          color: Theme.of(context).textTheme.bodyText1!.color,
        ),
        textAlign: isCentered == true ? TextAlign.center : TextAlign.start,
      );

  /// Show Simple Dialog

  static void showSimpleDialog(Widget child,
      {bool barrierDismissible = false}) {
    closeSnackBar();
    closeDialog();
    Get.dialog(
      MediaQuery.removeViewInsets(
        context: Get.context!,
        removeLeft: true,
        removeTop: true,
        removeRight: true,
        removeBottom: true,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: Dimens.screenHeight,
            maxWidth: Dimens.hundred * 6,
          ),
          child: Padding(
            padding: Dimens.edgeInsets12,
            child: Align(
              alignment: Alignment.center,
              child: Material(
                type: MaterialType.card,
                color: Theme.of(Get.context!).dialogBackgroundColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(Dimens.four),
                ),
                child: child,
              ),
            ),
          ),
        ),
      ),
      barrierDismissible: barrierDismissible,
      barrierColor: ColorValues.blackColor.withOpacity(0.75),
      name: 'simple_dialog',
    );
  }

  /// Show Delete Dialog

  static void showDeleteDialog(BuildContext context, Function onDelete) {
    closeDialog();
    Get.dialog(
      MediaQuery.removeViewInsets(
        context: context,
        removeLeft: true,
        removeTop: true,
        removeRight: true,
        removeBottom: true,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: Dimens.screenHeight,
            maxWidth: Dimens.hundred * 6,
          ),
          child: Padding(
            padding: Dimens.edgeInsets12,
            child: Align(
              alignment: Alignment.center,
              child: Material(
                type: MaterialType.card,
                color: Theme.of(Get.context!).dialogBackgroundColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(Dimens.four),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Dimens.boxHeight8,
                    Padding(
                      padding: Dimens.edgeInsetsHorizDefault,
                      child: Text(
                        StringValues.delete,
                        textAlign: TextAlign.center,
                        style: AppStyles.style20Bold,
                      ),
                    ),
                    Dimens.boxHeight10,
                    Padding(
                      padding: Dimens.edgeInsetsHorizDefault,
                      child: Text(
                        StringValues.deleteConfirmationText,
                        textAlign: TextAlign.center,
                        style: AppStyles.style14Normal,
                      ),
                    ),
                    Dimens.boxHeight8,
                    Padding(
                      padding: Dimens.edgeInsetsHorizDefault,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          NxTextButton(
                            label: StringValues.no,
                            labelStyle: AppStyles.style16Bold.copyWith(
                              color: ColorValues.errorColor,
                            ),
                            onTap: AppUtility.closeDialog,
                            padding: Dimens.edgeInsets8,
                          ),
                          Dimens.boxWidth16,
                          NxTextButton(
                            label: StringValues.yes,
                            labelStyle: AppStyles.style16Bold.copyWith(
                              color: ColorValues.successColor,
                            ),
                            onTap: () => onDelete(),
                            padding: Dimens.edgeInsets8,
                          ),
                        ],
                      ),
                    ),
                    Dimens.boxHeight8,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      barrierDismissible: false,
      barrierColor: ColorValues.blackColor.withOpacity(0.75),
      name: 'delete_dialog',
    );
  }

  static void showError(String message) {
    closeSnackBar();
    closeBottomSheet();
    if (message.isEmpty) return;
    Get.rawSnackbar(
      messageText: Text(
        message,
      ),
      mainButton: TextButton(
        onPressed: () {
          if (Get.isSnackbarOpen) {
            Get.back<void>();
          }
        },
        child: const Text(
          StringValues.okay,
        ),
      ),
      backgroundColor: const Color(0xFF503E9D),
      margin: Dimens.edgeInsets16,
      borderRadius: Dimens.fifteen,
      snackStyle: SnackStyle.FLOATING,
    );
  }

  /// Show No Internet Dialog

  static void showNoInternetDialog() {
    closeDialog();
    Get.dialog<void>(
      WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          body: Padding(
            padding: Dimens.edgeInsets16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: Dimens.screenWidth * 0.75,
                  height: Dimens.screenWidth * 0.75,
                  child: const RiveAnimation.asset(
                    RiveAssets.error,
                    alignment: Alignment.center,
                  ),
                ),
                Dimens.boxHeight16,
                Text(
                  'No Internet!',
                  textAlign: TextAlign.center,
                  style: AppStyles.style24Bold.copyWith(
                    color: ColorValues.errorColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: false,
      name: 'no_internet_dialog',
    );
  }

  /// Show BottomSheet
  static void showBottomSheet(
      {required List<Widget> children,
      double? borderRadius,
      MainAxisAlignment? mainAxisAlignment,
      CrossAxisAlignment? crossAxisAlignment,
      bool? isScrollControlled}) {
    closeBottomSheet();
    Get.bottomSheet(
      Padding(
        padding: Dimens.edgeInsets8_0,
        child: Column(
          mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
          crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: children,
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(borderRadius ?? Dimens.zero),
          topRight: Radius.circular(borderRadius ?? Dimens.zero),
        ),
      ),
      isScrollControlled: isScrollControlled ?? false,
      barrierColor: ColorValues.blackColor.withOpacity(0.5),
      backgroundColor: Theme.of(Get.context!).bottomSheetTheme.backgroundColor,
    );
  }

  /// Show Overlay
  static void showOverlay(Function func) {
    Get.showOverlay(
      loadingWidget: const CupertinoActivityIndicator(),
      opacityColor: Theme.of(Get.context!).bottomSheetTheme.backgroundColor!,
      opacity: 0.5,
      asyncFunction: () async {
        await func();
      },
    );
  }

  /// Show SnackBar

  static void showSnackBar(String message, String type, {int? duration}) {
    closeSnackBar();
    Get.showSnackbar(
      GetSnackBar(
        margin: EdgeInsets.only(
          left: Dimens.zero,
          right: Dimens.zero,
          top: Dimens.zero,
          bottom: Dimens.zero,
        ),
        borderRadius: Dimens.zero,
        padding: Dimens.edgeInsets16_12,
        snackStyle: SnackStyle.FLOATING,
        snackPosition: SnackPosition.BOTTOM,
        borderWidth: Dimens.zero,
        messageText: Text(
          message.toCapitalized(),
          style: AppStyles.style14Normal.copyWith(
            color: renderTextColor(type),
          ),
        ),
        icon: Icon(
          renderIcon(type),
          color: renderIconColor(type),
          size: Dimens.twenty,
        ),
        mainButton: Padding(
          padding: Dimens.edgeInsets0_8,
          child: NxTextButton(
            label: StringValues.ok.toUpperCase(),
            labelStyle: AppStyles.style13Bold.copyWith(
              color: ColorValues.linkColor,
            ),
            onTap: closeSnackBar,
          ),
        ),
        shouldIconPulse: false,
        backgroundColor: Theme.of(Get.context!).snackBarTheme.backgroundColor!,
        dismissDirection: DismissDirection.horizontal,
        duration: Duration(seconds: duration ?? 3),
      ),
    );
  }

  /// Render Text Color
  static Color renderTextColor(String type) {
    return Theme.of(Get.context!).snackBarTheme.contentTextStyle!.color!;
  }

  /// Render Icon Color
  static Color renderIconColor(String type) {
    if (type == StringValues.success) {
      return ColorValues.successColor;
    }
    return Theme.of(Get.context!).snackBarTheme.contentTextStyle!.color!;
  }

  /// Render Icon
  static IconData renderIcon(String type) {
    if (type == StringValues.success) {
      return CupertinoIcons.check_mark_circled_solid;
    }

    return CupertinoIcons.info_circle_fill;
  }

  /// --------------------------------------------------------------------------

  static void printLog(message) {
    debugPrint(
        "=======================================================================");
    debugPrint(message.toString(), wrapWidth: 1024);
    debugPrint(
        "=======================================================================");
  }

  /// --------------------------------------------------------------------------

  /// Open Url
  static Future<void> openUrl(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      showSnackBar("Couldn't launch url", StringValues.error);
    }
  }

  /// Random String
  static String generateUid(int length) {
    const chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890@!%&_';
    var rnd = Random();

    return String.fromCharCodes(
      Iterable.generate(
        16,
        (_) => chars.codeUnitAt(rnd.nextInt(chars.length)),
      ),
    );
  }
}
