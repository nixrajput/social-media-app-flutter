import 'dart:async';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_app/apis/models/entities/login_info.dart';
import 'package:social_media_app/apis/models/responses/login_history_response.dart';
import 'package:social_media_app/apis/providers/api_provider.dart';
import 'package:social_media_app/app_services/auth_service.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/utils/utility.dart';

class LoginInfoController extends GetxController {
  static LoginInfoController get find => Get.find();

  final _auth = AuthService.find;

  final _apiProvider = ApiProvider(http.Client());

  final _loginHistoryData = const LoginHistoryResponse().obs;
  final _isLoading = false.obs;
  final _isMoreLoading = false.obs;
  final List<LoginInfo> _loginInfoList = [];

  bool get isLoading => _isLoading.value;

  bool get isMoreLoading => _isMoreLoading.value;

  LoginHistoryResponse? get loginHistoryData => _loginHistoryData.value;

  List<LoginInfo> get loginInfoList => _loginInfoList;

  set setLoginDeviceInfoData(LoginHistoryResponse value) =>
      _loginHistoryData.value = value;

  @override
  onInit() {
    super.onInit();
    _getLoginHistory();
  }

  Future<void> _getLoginHistory() async {
    _isLoading.value = true;
    update();

    try {
      final response = await _apiProvider.getLoginHistory(_auth.token);

      if (response.isSuccessful) {
        final decodedData = response.data;
        setLoginDeviceInfoData = LoginHistoryResponse.fromJson(decodedData);
        _loginInfoList.clear();
        _loginInfoList.addAll(_loginHistoryData.value.results!);
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

  Future<void> _loadMore({int? page}) async {
    _isMoreLoading.value = true;
    update();

    try {
      final response = await _apiProvider.getLoginHistory(
        _auth.token,
        page: page,
      );

      if (response.isSuccessful) {
        final decodedData = response.data;
        setLoginDeviceInfoData = LoginHistoryResponse.fromJson(decodedData);
        _loginInfoList.addAll(_loginHistoryData.value.results!);
        _isMoreLoading.value = false;
        update();
      } else {
        final decodedData = response.data;
        _isMoreLoading.value = false;
        update();

        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } catch (exc) {
      _isMoreLoading.value = false;
      update();
      AppUtility.showSnackBar('Error: ${exc.toString()}', StringValues.error);
    }
  }

  Future<void> _deleteLoginDeviceInfo(String deviceId) async {
    var isPresent =
        _loginInfoList.any((element) => element.deviceId == deviceId);

    if (isPresent == true) {
      var index =
          _loginInfoList.indexWhere((element) => element.deviceId == deviceId);
      _loginInfoList.removeAt(index);
      update();
    }

    try {
      final response =
          await _apiProvider.deleteLoginInfo(_auth.token, deviceId);

      if (response.isSuccessful) {
        final decodedData = response.data;
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.success,
          duration: 1,
        );
      } else {
        final decodedData = response.data;
        update();
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } catch (exc) {
      //_postList.insert(postIndex, post);
      update();
      AppUtility.showSnackBar('Error: ${exc.toString()}', StringValues.error);
    }
  }

  Future<void> _logoutAllOtherDevices(String deviceId) async {
    _loginInfoList.removeWhere((element) => element.deviceId != deviceId);
    update();

    try {
      final response =
          await _apiProvider.logoutOtherDevices(_auth.token, deviceId);

      if (response.isSuccessful) {
        final decodedData = response.data;
        await _getLoginHistory();
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.success,
          duration: 1,
        );
      } else {
        final decodedData = response.data;
        update();
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } catch (exc) {
      update();
      AppUtility.showSnackBar('Error: ${exc.toString()}', StringValues.error);
    }
  }

  Future<void> getLoginHisory() async => await _getLoginHistory();

  Future<void> logoutAllOtherDevices(String deviceId) async =>
      await _logoutAllOtherDevices(deviceId);

  Future<void> loadMore() async =>
      await _loadMore(page: _loginHistoryData.value.currentPage! + 1);

  Future<void> deleteLoginDeviceInfo(String deviceId) async =>
      await _deleteLoginDeviceInfo(deviceId);
}
