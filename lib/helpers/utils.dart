import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/strings.dart';

import '../constants/dimens.dart';

abstract class AppUtils {
  static final storage = GetStorage();

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

  static void showBottomSheet(List<Widget> children) {
    closeBottomSheet();
    Get.bottomSheet(
      Padding(
        padding: Dimens.edgeInsets8_16,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: children,
        ),
      ),
      barrierColor:
          Theme.of(Get.context!).textTheme.bodyText1!.color!.withAlpha(90),
      backgroundColor: Theme.of(Get.context!).bottomSheetTheme.backgroundColor,
    );
  }

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

  static void showSnackBar(String message, String type) {
    closeSnackBar();
    Get.showSnackbar(
      GetSnackBar(
        margin: Dimens.edgeInsets8,
        borderRadius: Dimens.eight,
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

  static void closeFocus() {
    if (FocusManager.instance.primaryFocus!.hasFocus) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  static Future<void> saveLoginDataToLocalStorage(_token, _expiresAt) async {
    if (_token!.isNotEmpty && _expiresAt!.isNotEmpty) {
      final data = jsonEncode({
        StringValues.token: _token,
        StringValues.expiresAt: _expiresAt,
      });

      await storage.write(StringValues.loginData, data);
      debugPrint('Auth details saved.');
    } else {
      debugPrint('Auth details could not saved.');
    }
  }

  static Future<dynamic> readLoginDataFromLocalStorage() async {
    if (storage.hasData(StringValues.loginData)) {
      final data = await storage.read(StringValues.loginData);
      var decodedData = jsonDecode(data) as Map<String, dynamic>;
      debugPrint('Auth details found.');
      return decodedData;
    }
    return null;
  }

  static Future<void> clearLoginDataFromLocalStorage() async {
    await storage.remove(StringValues.loginData);
    debugPrint('Auth details removed.');
  }
}
