import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cloudinary/cloudinary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:social_media_app/apis/providers/api_provider.dart';
import 'package:social_media_app/apis/services/auth_service.dart';
import 'package:social_media_app/constants/secrets.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/extensions/file_extensions.dart';
import 'package:social_media_app/modules/home/controllers/profile_controller.dart';
import 'package:social_media_app/utils/utility.dart';

class EditProfilePictureController extends GetxController {
  static EditProfilePictureController get find => Get.find();

  final _profile = ProfileController.find;
  final _auth = AuthService.find;

  final _apiProvider = ApiProvider(http.Client());

  final _pickedImage = Rxn<File>();

  final _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  File? get pickedImage => _pickedImage.value;

  var cloudName = const String.fromEnvironment('CLOUDINARY_CLOUD_NAME',
      defaultValue: AppSecrets.cloudinaryCloudName);
  var uploadPreset = const String.fromEnvironment('CLOUDINARY_UPLOAD_PRESET',
      defaultValue: AppSecrets.cloudinaryUploadPreset);

  Future<void> selectSingleImage({ImageSource? imageSource}) async {
    final imagePicker = ImagePicker();
    final imageCropper = ImageCropper();
    const maxImageBytes = 1048576;

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
        compressFormat: ImageCompressFormat.jpg,
        aspectRatio: const CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
        cropStyle: CropStyle.circle,
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

      var croppedImage = File(croppedFile!.path);
      File? resultFile = croppedImage;
      var size = croppedImage.lengthSync();
      AppUtility.printLog('Original file size: ${resultFile.sizeToKb()} KB');

      if (size > (5 * maxImageBytes)) {
        AppUtility.showSnackBar(
          'Image size must be less than 5mb',
          '',
        );
      } else if (size < (maxImageBytes / 2)) {
        AppUtility.printLog('Result $resultFile');
        AppUtility.printLog('Result file size: ${resultFile.sizeToKb()} KB');
        _pickedImage.value = croppedImage;
        update();
      } else {
        var tempDir = await getTemporaryDirectory();

        /// --------- Compressing Image ------------------------------------

        AppUtility.showLoadingDialog(message: 'Compressing...');
        var timestamp = DateTime.now().millisecondsSinceEpoch;
        AppUtility.printLog('Compressing...');
        resultFile = await FlutterImageCompress.compressAndGetFile(
          resultFile.path,
          '${tempDir.absolute.path}/temp$timestamp.jpg',
          quality: 60,
          format: CompressFormat.jpeg,
        );
        size = resultFile!.lengthSync();
        AppUtility.closeDialog();

        /// ----------------------------------------------------------------
        AppUtility.printLog('Result $resultFile');
        AppUtility.printLog('Result file size: ${resultFile.sizeToKb()} KB');
        _pickedImage.value = croppedImage;
        update();
      }
    }
  }

  Future<void> chooseImage() async {
    await selectSingleImage();

    if (_pickedImage.value == null) {
      AppUtility.showSnackBar(
        'Select a profile picture',
        StringValues.warning,
      );
      return;
    }
    await _uploadProfilePicture();
  }

  Future<void> _uploadProfilePicture() async {
    final cloudinary = Cloudinary.unsignedConfig(cloudName: cloudName);
    AppUtility.printLog("Update Profile Picture Request");

    var filePath = _pickedImage.value!.path;

    AppUtility.showLoadingDialog();
    _isLoading.value = true;
    update();

    String? publicId = '';
    String? url = '';

    await cloudinary
        .unsignedUpload(
      uploadPreset: uploadPreset,
      file: filePath,
      resourceType: CloudinaryResourceType.image,
      folder: "social_media_api/avatars",
      progressCallback: (count, total) {
        var progress = ((count / total) * 100).toStringAsFixed(2);
        AppUtility.printLog('Uploading : $progress %');
      },
    )
        .then((value) {
      publicId = value.publicId;
      url = value.secureUrl;
    }).catchError((err) {
      AppUtility.printLog(err);
      AppUtility.showSnackBar('image upload failed.', StringValues.error);
    });

    final body = {
      "public_id": publicId,
      "url": url,
    };

    try {
      final response = await _apiProvider.uploadProfilePicture(
        _auth.token,
        body,
      );

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        AppUtility.closeDialog();
        AppUtility.printLog("Update Profile Picture Success");
        await _profile.fetchProfileDetails(fetchPost: false);
        _isLoading.value = false;
        update();
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.success,
        );
      } else {
        AppUtility.closeDialog();
        AppUtility.printLog("Update Profile Picture Error");
        _isLoading.value = false;
        update();
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } on SocketException {
      AppUtility.closeDialog();
      AppUtility.printLog("Update Profile Picture Error");
      _isLoading.value = false;
      update();
      AppUtility.printLog(StringValues.internetConnError);
      AppUtility.showSnackBar(
          StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      AppUtility.closeDialog();
      AppUtility.printLog("Update Profile Picture Error");
      _isLoading.value = false;
      update();
      AppUtility.printLog(StringValues.connTimedOut);
      AppUtility.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      AppUtility.closeDialog();
      AppUtility.printLog("Update Profile Picture Error");
      _isLoading.value = false;
      update();
      AppUtility.printLog(StringValues.formatExcError);
      AppUtility.printLog(e);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      AppUtility.closeDialog();
      AppUtility.printLog("Update Profile Picture Error");
      _isLoading.value = false;
      update();
      AppUtility.printLog(StringValues.errorOccurred);
      AppUtility.printLog(exc);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    }
  }

  Future<void> _removeProfilePicture() async {
    AppUtility.printLog("Remove Profile Picture Request");
    AppUtility.showLoadingDialog();
    _isLoading.value = true;
    update();

    try {
      final response = await _apiProvider.deleteProfilePicture(_auth.token);
      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        AppUtility.closeDialog();
        AppUtility.printLog("Remove Profile Picture Success");
        await _profile.fetchProfileDetails();
        _isLoading.value = false;
        update();
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.success,
        );
      } else {
        AppUtility.closeDialog();
        AppUtility.printLog("Remove Profile Picture Error");
        _isLoading.value = false;
        update();
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } on SocketException {
      AppUtility.closeDialog();
      AppUtility.printLog("Remove Profile Picture Error");
      _isLoading.value = false;
      update();
      AppUtility.printLog(StringValues.internetConnError);
      AppUtility.showSnackBar(
          StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      AppUtility.closeDialog();
      AppUtility.printLog("Remove Profile Picture Error");
      _isLoading.value = false;
      update();
      AppUtility.printLog(StringValues.connTimedOut);
      AppUtility.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      AppUtility.closeDialog();
      AppUtility.printLog("Remove Profile Picture Error");
      _isLoading.value = false;
      update();
      AppUtility.printLog(StringValues.formatExcError);
      AppUtility.printLog(e);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      AppUtility.closeDialog();
      AppUtility.printLog("Remove Profile Picture Error");
      _isLoading.value = false;
      update();
      AppUtility.printLog(StringValues.errorOccurred);
      AppUtility.printLog(exc);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    }
  }

  Future<void> uploadProfilePicture() async {
    AppUtility.closeFocus();
    await _uploadProfilePicture();
  }

  Future<void> removeProfilePicture() async {
    AppUtility.closeFocus();
    await _removeProfilePicture();
  }
}
