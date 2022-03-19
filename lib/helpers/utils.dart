import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/strings.dart';

import '../constants/dimens.dart';

abstract class AppUtils {
  static void showLoadingDialog() {
    closeDialog();
    Get.dialog<void>(
      WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: SizedBox(
              height: Dimens.hundred,
              child: CupertinoTheme(
                data: CupertinoTheme.of(Get.context!).copyWith(
                    brightness: Brightness.dark, primaryColor: Colors.white),
                child: const CupertinoActivityIndicator(),
              ),
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  static void showError(String message) {
    closeSnackBar();
    closeDialog();
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

  static void showSnackBar(String message, String type) {
    closeSnackBar();
    Get.showSnackbar(
      GetSnackBar(
        messageText: Text(
          message,
          style: TextStyle(
            color: (type == StringValues.error ||
                    type == StringValues.success ||
                    type == StringValues.warning)
                ? ColorValues.whiteColor
                : ThemeData().textTheme.bodyText1!.color,
          ),
        ),
        icon: Icon(
          type == StringValues.error
              ? CupertinoIcons.clear_circled_solid
              : type == StringValues.success
                  ? CupertinoIcons.check_mark_circled_solid
                  : CupertinoIcons.info_circle_fill,
          color: (type == StringValues.error ||
                  type == StringValues.success ||
                  type == StringValues.warning)
              ? ColorValues.whiteColor
              : ThemeData().iconTheme.color,
        ),
        shouldIconPulse: false,
        backgroundColor: type == StringValues.error
            ? ColorValues.errorColor
            : type == StringValues.warning
                ? ColorValues.warningColor
                : type == StringValues.success
                    ? ColorValues.successColor
                    : ThemeData().snackBarTheme.backgroundColor!,
        duration: const Duration(seconds: 5),
      ),
    );
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
}
