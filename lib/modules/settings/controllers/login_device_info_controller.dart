import 'dart:async';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_app/apis/models/entities/login_device_info.dart';
import 'package:social_media_app/apis/models/responses/common_response.dart';
import 'package:social_media_app/apis/models/responses/device_info_response.dart';
import 'package:social_media_app/apis/providers/api_provider.dart';
import 'package:social_media_app/apis/services/auth_service.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/utils/utility.dart';

class LoginDeviceInfoController extends GetxController {
  static LoginDeviceInfoController get find => Get.find();

  final _auth = AuthService.find;

  final _apiProvider = ApiProvider(http.Client());

  final _loginDeviceInfoData = const DeviceInfoResponse().obs;
  final _isLoading = false.obs;
  final List<LoginDeviceInfo> _loginDeviceInfoList = [];

  bool get isLoading => _isLoading.value;

  DeviceInfoResponse? get deviceInfo => _loginDeviceInfoData.value;

  List<LoginDeviceInfo> get loginDeviceInfoList => _loginDeviceInfoList;

  set setLoginDeviceInfoData(DeviceInfoResponse value) =>
      _loginDeviceInfoData.value = value;

  Future<void> _getLoginDeviceInfo() async {
    _isLoading.value = true;
    update();

    try {
      final response = await _apiProvider.getDeviceInfo(_auth.token);

      if (response.isSuccessful) {
        final decodedData = response.data;
        setLoginDeviceInfoData = DeviceInfoResponse.fromJson(decodedData);
        _loginDeviceInfoList.clear();
        _loginDeviceInfoList.addAll(_loginDeviceInfoData.value.results!);
        _isLoading.value = false;
        update();
      } else {
        final decodedData = response.data;
        _isLoading.value = false;
        update();

        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } catch (exc) {
      _isLoading.value = false;
      update();
      AppUtility.showSnackBar('Error: ${exc.toString()}', StringValues.error);
    }
  }

  Future<void> _deleteLoginDeviceInfo(String deviceId) async {
    var isPresent =
        _loginDeviceInfoList.any((element) => element.deviceId == deviceId);

    if (isPresent == true) {
      var index = _loginDeviceInfoList
          .indexWhere((element) => element.deviceId == deviceId);
      _loginDeviceInfoList.removeAt(index);
      update();
    }

    try {
      final response =
          await _apiProvider.deleteDeviceInfo(_auth.token, deviceId);

      if (response.isSuccessful) {
        final decodedData = response.data;
        final apiResponse = CommonResponse.fromJson(decodedData);
        AppUtility.printLog("Delete LoginDeviceInfo Success");
        AppUtility.showSnackBar(
          apiResponse.message!,
          StringValues.success,
          duration: 1,
        );
      } else {
        final decodedData = response.data;
        final apiResponse = CommonResponse.fromJson(decodedData);
        update();
        AppUtility.printLog("Delete LoginDeviceInfo Error");
        AppUtility.showSnackBar(
          apiResponse.message!,
          StringValues.error,
        );
      }
    } catch (exc) {
      //_postList.insert(postIndex, post);
      update();
      AppUtility.showSnackBar('Error: ${exc.toString()}', StringValues.error);
    }
  }

  Future<void> getLoginDeviceInfo() async => await _getLoginDeviceInfo();

  Future<void> deleteLoginDeviceInfo(String deviceId) async =>
      await _deleteLoginDeviceInfo(deviceId);
}
