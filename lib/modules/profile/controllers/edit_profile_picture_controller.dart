import 'dart:async';
import 'dart:io';

import 'package:cloudinary/cloudinary.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:social_media_app/apis/providers/api_provider.dart';
import 'package:social_media_app/apis/services/auth_service.dart';
import 'package:social_media_app/constants/secrets.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/modules/home/controllers/profile_controller.dart';
import 'package:social_media_app/utils/file_utility.dart';
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

  Future<void> selectProfileImage({ImageSource? imageSource}) async {
    var imageFile = await FileUtility.selectImage(source: imageSource);

    if (imageFile == null) {
      AppUtility.log('Image file is null', tag: 'error');
      return;
    }

    var compressdFile = await FileUtility.compressImage(imageFile.path);

    if (compressdFile == null) {
      AppUtility.log('Compressed file is null', tag: 'error');
      return;
    }
    _pickedImage.value = compressdFile;
    update();
  }

  Future<void> chooseImage() async {
    await selectProfileImage();

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
        AppUtility.log('Uploading : $progress %');
      },
    )
        .then((value) {
      publicId = value.publicId;
      url = value.secureUrl;
    }).catchError((err) {
      AppUtility.log('Error: $err', tag: 'error');
      AppUtility.showSnackBar('Error: $err', StringValues.error);
    });

    final body = {
      "public_id": publicId,
      "url": url,
    };

    try {
      final response =
          await _apiProvider.uploadProfilePicture(_auth.token, body);

      if (response.isSuccessful) {
        final decodedData = response.data;
        AppUtility.closeDialog();
        await _profile.fetchProfileDetails(fetchPost: false);
        _isLoading.value = false;
        update();
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.success,
        );
      } else {
        final decodedData = response.data;
        AppUtility.closeDialog();
        _isLoading.value = false;
        update();
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } catch (exc) {
      AppUtility.closeDialog();
      _isLoading.value = false;
      update();
      AppUtility.log('Error: $exc', tag: 'error');
      AppUtility.showSnackBar('Error: $exc', StringValues.error);
    }
  }

  Future<void> _removeProfilePicture() async {
    AppUtility.showLoadingDialog();
    _isLoading.value = true;
    update();

    try {
      final response = await _apiProvider.deleteProfilePicture(_auth.token);

      if (response.isSuccessful) {
        final decodedData = response.data;
        AppUtility.closeDialog();
        await _profile.fetchProfileDetails();
        _isLoading.value = false;
        update();
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.success,
        );
      } else {
        final decodedData = response.data;
        AppUtility.closeDialog();
        _isLoading.value = false;
        update();
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } catch (exc) {
      AppUtility.closeDialog();
      _isLoading.value = false;
      update();
      AppUtility.log('Error: $exc', tag: 'error');
      AppUtility.showSnackBar('Error: $exc', StringValues.error);
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
