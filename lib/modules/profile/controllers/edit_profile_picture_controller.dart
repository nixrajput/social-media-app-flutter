import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_app/apis/providers/api_provider.dart';
import 'package:social_media_app/apis/services/auth_service.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/helpers/utils.dart';
import 'package:social_media_app/modules/home/controllers/profile_controller.dart';

class EditProfilePictureController extends GetxController {
  static EditProfilePictureController get find => Get.find();

  final _profile = ProfileController.find;
  final _auth = AuthService.find;

  final _apiProvider = ApiProvider(http.Client());

  final _pickedImage = Rxn<File>();

  final _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  File? get pickedImage => _pickedImage.value;

  Future<void> chooseImage() async {
    _pickedImage.value = await AppUtils.selectSingleImage();

    if (_pickedImage.value != null) {
      AppUtils.printLog(_pickedImage.value!.path);
      await _uploadProfilePicture();
    }
  }

  Future<void> _uploadProfilePicture() async {
    AppUtils.printLog("Update Profile Picture Request...");
    AppUtils.showLoadingDialog();
    _isLoading.value = true;
    update();

    try {
      final fileStream = http.ByteStream(pickedImage!.openRead());
      final fileLength = await pickedImage!.length();
      final multiPartFile = http.MultipartFile(
        "avatar",
        fileStream,
        fileLength,
        filename: pickedImage!.path,
      );

      final response = await _apiProvider.uploadProfilePicture(
        _auth.token,
        multiPartFile,
      );

      final responseDataFromStream = await http.Response.fromStream(response);
      final decodedData =
          jsonDecode(utf8.decode(responseDataFromStream.bodyBytes));

      if (response.statusCode == 200) {
        AppUtils.closeDialog();
        await _profile.fetchProfileDetails(fetchPost: false);
        _isLoading.value = false;
        update();
        AppUtils.showSnackBar(
          decodedData[StringValues.message],
          StringValues.success,
        );
      } else {
        AppUtils.closeDialog();
        _isLoading.value = false;
        update();
        AppUtils.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } on SocketException {
      AppUtils.closeDialog();
      _isLoading.value = false;
      update();
      AppUtils.printLog(StringValues.internetConnError);
      AppUtils.showSnackBar(StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      AppUtils.closeDialog();
      _isLoading.value = false;
      update();
      AppUtils.printLog(StringValues.connTimedOut);
      AppUtils.printLog(StringValues.connTimedOut);
      AppUtils.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      AppUtils.closeDialog();
      _isLoading.value = false;
      update();
      AppUtils.printLog(StringValues.formatExcError);
      AppUtils.printLog(e);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      AppUtils.closeDialog();
      _isLoading.value = false;
      update();
      AppUtils.printLog(StringValues.errorOccurred);
      AppUtils.printLog(exc);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    }
  }

  Future<void> _removeProfilePicture() async {
    AppUtils.printLog("Remove Profile Picture Request...");
    AppUtils.showLoadingDialog();
    _isLoading.value = true;
    update();

    try {
      final response = await _apiProvider.deleteProfilePicture(_auth.token);
      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        AppUtils.closeDialog();
        await _profile.fetchProfileDetails();
        _isLoading.value = false;
        update();
        AppUtils.showSnackBar(
          decodedData[StringValues.message],
          StringValues.success,
        );
      } else {
        AppUtils.closeDialog();
        _isLoading.value = false;
        update();
        AppUtils.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } on SocketException {
      AppUtils.closeDialog();
      _isLoading.value = false;
      update();
      AppUtils.printLog(StringValues.internetConnError);
      AppUtils.showSnackBar(StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      AppUtils.closeDialog();
      _isLoading.value = false;
      update();
      AppUtils.printLog(StringValues.connTimedOut);
      AppUtils.printLog(StringValues.connTimedOut);
      AppUtils.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      AppUtils.closeDialog();
      _isLoading.value = false;
      update();
      AppUtils.printLog(StringValues.formatExcError);
      AppUtils.printLog(e);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      AppUtils.closeDialog();
      _isLoading.value = false;
      update();
      AppUtils.printLog(StringValues.errorOccurred);
      AppUtils.printLog(exc);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    }
  }

  Future<void> uploadProfilePicture() async {
    AppUtils.closeFocus();
    await _uploadProfilePicture();
  }

  Future<void> removeProfilePicture() async {
    AppUtils.closeFocus();
    await _removeProfilePicture();
  }
}
