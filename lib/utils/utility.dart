import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:social_media_app/constants/assets.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/extensions/string_extensions.dart';
import 'package:social_media_app/global_widgets/asset_image.dart';
import 'package:social_media_app/global_widgets/circular_progress_indicator.dart';
import 'package:social_media_app/global_widgets/primary_text_btn.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_compress_ds/video_compress_ds.dart';

abstract class AppUtility {
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

  static void showLoadingDialog(
      {double? value, bool? barrierDismissible, String? message}) {
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
                    color: Theme.of(Get.context!).textTheme.bodyText1!.color,
                    size: Dimens.fourtyEight,
                  ),
                  Dimens.boxHeight12,
                  Text(
                    message ?? 'Please wait...',
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
    );
  }

  /// Text Logo

  static buildAppLogo({double? fontSize, bool? isCentered = false}) => Text(
        StringValues.appName.toUpperCase(),
        style: AppStyles.style24Bold.copyWith(
          fontFamily: "Muge",
          fontSize: fontSize,
          letterSpacing: Dimens.four,
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
            padding: Dimens.edgeInsets16,
            child: Align(
              alignment: Alignment.center,
              child: Material(
                type: MaterialType.card,
                color: Theme.of(Get.context!).dialogBackgroundColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(Dimens.eight),
                ),
                child: child,
              ),
            ),
          ),
        ),
      ),
      barrierDismissible: barrierDismissible,
      barrierColor: ColorValues.blackColor.withOpacity(0.75),
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
                NxAssetImage(
                  imgAsset: AssetValues.error,
                  width: Dimens.hundred * 1.6,
                  height: Dimens.hundred * 1.6,
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
    );
  }

  /// Show BottomSheet

  static void showBottomSheet(List<Widget> children, {double? borderRadius}) {
    closeBottomSheet();
    Get.bottomSheet(
      Padding(
        padding: Dimens.edgeInsets8_0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
      barrierColor: ColorValues.blackColor.withOpacity(0.75),
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
          left: Dimens.sixTeen,
          right: Dimens.sixTeen,
          top: Dimens.eight,
        ),
        borderRadius: Dimens.eight,
        padding: Dimens.edgeInsets16,
        snackStyle: SnackStyle.FLOATING,
        snackPosition: SnackPosition.TOP,
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
          child: const NxTextButton(
            label: 'OK',
            onTap: closeSnackBar,
          ),
        ),
        shouldIconPulse: false,
        backgroundColor: Theme.of(Get.context!)
            .snackBarTheme
            .backgroundColor!
            .withOpacity(0.25),
        barBlur: Dimens.twentyFour,
        dismissDirection: DismissDirection.horizontal,
        duration: Duration(seconds: duration ?? 3),
      ),
    );
  }

  /// Render Text Color
  static Color renderTextColor(String type) {
    return Theme.of(Get.context!).textTheme.bodyText1!.color!;
  }

  /// Render Icon Color
  static Color renderIconColor(String type) {
    return Theme.of(Get.context!).textTheme.bodyText1!.color!;
  }

  /// Render Icon
  static IconData renderIcon(String type) {
    if (type == StringValues.success) {
      return CupertinoIcons.check_mark_circled_solid;
    }

    return CupertinoIcons.info_circle_fill;
  }

  static Future<void> saveLoginDataToLocalStorage(
      String token, int expiresAt) async {
    final storage = GetStorage();
    if (token.isNotEmpty && expiresAt > 0) {
      final data = jsonEncode({
        StringValues.token: token,
        StringValues.expiresAt: expiresAt,
      });

      await storage.write(StringValues.loginData, data);
      printLog(StringValues.authDetailsSaved);
    } else {
      printLog(StringValues.authDetailsNotSaved);
    }
  }

  static Future<dynamic> readLoginDataFromLocalStorage() async {
    final storage = GetStorage();
    if (storage.hasData(StringValues.loginData)) {
      final data = await storage.read(StringValues.loginData);
      var decodedData = jsonDecode(data) as Map<String, dynamic>;
      printLog(StringValues.authDetailsFound);
      return decodedData;
    }
    printLog(StringValues.authDetailsNotFound);
    return null;
  }

  /// Profile Data -------------------------------------------------------------

  static Future<void> saveProfileDataToLocalStorage(response) async {
    final storage = GetStorage();
    if (response != null) {
      final data = jsonEncode(response);

      await storage.write(StringValues.profileData, data);
      printLog(StringValues.profileDetailsSaved);
    } else {
      printLog(StringValues.profileDetailsNotSaved);
    }
  }

  static Future<dynamic> readProfileDataFromLocalStorage() async {
    final storage = GetStorage();
    if (storage.hasData(StringValues.profileData)) {
      final data = await storage.read(StringValues.profileData);
      var decodedData = jsonDecode(data);
      printLog(StringValues.profileDetailsFound);
      return decodedData;
    }
    printLog(StringValues.profileDetailsNotFound);
    return null;
  }

  static Future<void> clearLoginDataFromLocalStorage() async {
    final storage = GetStorage();
    await storage.remove(StringValues.loginData);
    await storage.remove(StringValues.profileData);
    printLog(StringValues.authDetailsRemoved);
    printLog(StringValues.profileDetailsRemoved);
  }

  /// --------------------------------------------------------------------------

  /// Profile Post Data --------------------------------------------------------

  static Future<void> saveProfilePostDataToLocalStorage(postData) async {
    final storage = GetStorage();
    if (postData != null) {
      await storage.write("profilePosts", jsonEncode(postData));
      printLog("Profile Post Data Saved To Local Storage");
    } else {
      printLog("Failed To Save Profile Post Data To Local Storage");
    }
  }

  static Future<dynamic> readProfilePostDataFromLocalStorage() async {
    final storage = GetStorage();
    if (storage.hasData("profilePosts")) {
      final data = await storage.read("profilePosts");
      printLog("Profile Post Data Fetched From Local Storage");
      return jsonDecode(data);
    }
    printLog("Failed To Fetch Profile Post Data From Local Storage");
    return null;
  }

  static Future<void> deleteProfilePostDataFromLocalStorage() async {
    final storage = GetStorage();
    await storage.remove("profilePosts");
    printLog("Profile Post Data Deleted From Local Storage");
  }

  /// --------------------------------------------------------------------------

  static void printLog(message) {
    debugPrint(
        "=======================================================================");
    debugPrint(message.toString(), wrapWidth: 1024);
    debugPrint(
        "=======================================================================");
  }

  static Future<dynamic> selectSingleImage({ImageSource? imageSource}) async {
    final imagePicker = ImagePicker();
    final imageCropper = ImageCropper();
    final pickedImage = await imagePicker.pickImage(
      maxWidth: 1080.0,
      maxHeight: 1080.0,
      source: imageSource ?? ImageSource.gallery,
    );

    if (pickedImage != null) {
      var croppedFile = await imageCropper.cropImage(
        maxWidth: 1080,
        maxHeight: 1080,
        sourcePath: pickedImage.path,
        compressFormat: ImageCompressFormat.png,
        aspectRatio: const CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
        cropStyle: CropStyle.circle,
        uiSettings: [
          AndroidUiSettings(
            toolbarColor: Theme.of(Get.context!).scaffoldBackgroundColor,
            toolbarTitle: StringValues.cropImage,
            toolbarWidgetColor: Theme.of(Get.context!).primaryColor,
            backgroundColor: Theme.of(Get.context!).scaffoldBackgroundColor,
          ),
          IOSUiSettings(
            title: StringValues.cropImage,
            minimumAspectRatio: 1.0,
          ),
        ],
        compressQuality: 70,
      );

      return File(croppedFile!.path);
    }

    return null;
  }

  static Future<dynamic> selectMultipleImage() async {
    final imagePicker = ImagePicker();
    final imageCropper = ImageCropper();
    var imageList = <File>[];
    final pickedImages = await imagePicker.pickMultiImage(
      maxWidth: 1920.0,
      maxHeight: 1920.0,
    );

    if (pickedImages != null) {
      for (var pickedImage in pickedImages) {
        var croppedFile = await imageCropper.cropImage(
          maxWidth: 1920,
          maxHeight: 1920,
          sourcePath: pickedImage.path,
          aspectRatio: const CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
          uiSettings: [
            AndroidUiSettings(
              toolbarColor: Theme.of(Get.context!).scaffoldBackgroundColor,
              toolbarTitle: StringValues.cropImage,
              toolbarWidgetColor: Theme.of(Get.context!).primaryColor,
              backgroundColor: Theme.of(Get.context!).scaffoldBackgroundColor,
            ),
            IOSUiSettings(
              title: StringValues.cropImage,
              minimumAspectRatio: 1.0,
            ),
          ],
          compressQuality: 70,
        );
        imageList.add(File(croppedFile!.path));
      }
    }

    return imageList;
  }

  static Future<dynamic> selectMultipleFiles() async {
    final filePicker = FilePicker.platform;
    final imageCropper = ImageCropper();
    var fileList = <PlatformFile>[];
    var resultList = <File>[];
    final pickedFiles = await filePicker.pickFiles(
      allowMultiple: true,
      withReadStream: true,
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg', 'jpeg', 'mp4', 'mkv'],
    );

    if (pickedFiles != null) {
      fileList = pickedFiles.files;

      for (var pickedImage in fileList) {
        var fileExt = pickedImage.extension;

        if (['png', 'jpg', 'jpeg'].contains(fileExt)) {
          var croppedFile = await imageCropper.cropImage(
            maxWidth: 1920,
            maxHeight: 1920,
            sourcePath: pickedImage.path!,
            compressFormat: ImageCompressFormat.png,
            aspectRatio: const CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
            uiSettings: [
              AndroidUiSettings(
                toolbarColor: Theme.of(Get.context!).scaffoldBackgroundColor,
                toolbarTitle: StringValues.cropImage,
                toolbarWidgetColor: Theme.of(Get.context!).colorScheme.primary,
                backgroundColor: Theme.of(Get.context!).scaffoldBackgroundColor,
              ),
              IOSUiSettings(
                title: StringValues.cropImage,
                minimumAspectRatio: 1.0,
              ),
            ],
            compressQuality: 100,
          );
          resultList.add(File(croppedFile!.path));
        } else {
          resultList.add(File(pickedImage.path!));
        }
      }
    }

    return resultList;
  }

  /// Check if video file
  static bool isVideoFile(String path) {
    const videoFilesTypes = [".mp4", ".mkv"];
    var ext = p.extension(path);
    // printLog('extension : $ext');
    // printLog(videoFilesTypes.contains(ext).toString());
    return videoFilesTypes.contains(ext);
  }

  /// Get Video Thumbnail
  static Future<File> getVideoThumb(String path) async {
    var thumbFile = await VideoCompress.getFileThumbnail(
      path,
      quality: 50,
    );
    return thumbFile;
  }

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
