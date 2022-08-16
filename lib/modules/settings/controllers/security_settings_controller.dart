import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_app/apis/models/responses/login_info_response.dart';
import 'package:social_media_app/apis/providers/api_provider.dart';
import 'package:social_media_app/apis/services/auth_service.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/helpers/utils.dart';

class SecuritySettingsController extends GetxController {
  static SecuritySettingsController get find => Get.find();

  final _auth = AuthService.find;

  final _apiProvider = ApiProvider(http.Client());

  final _loginInfo = LoginInfoResponse().obs;
  final _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  LoginInfoResponse? get loginInfo => _loginInfo.value;

  set setLoginInfoData(LoginInfoResponse value) {
    _loginInfo.value = value;
  }

  Future<void> _getLoginInfo() async {
    AppUtils.printLog("Get LoginInfo Request...");
    _isLoading.value = true;
    update();

    try {
      final response = await _apiProvider.getDeviceInfo(_auth.token);

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        setLoginInfoData = LoginInfoResponse.fromJson(decodedData);
        _isLoading.value = false;
        update();
      } else {
        _isLoading.value = false;
        update();
        AppUtils.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } on SocketException {
      _isLoading.value = false;
      update();
      AppUtils.printLog(StringValues.internetConnError);
      AppUtils.showSnackBar(StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      _isLoading.value = false;
      update();
      AppUtils.printLog(StringValues.connTimedOut);
      AppUtils.printLog(StringValues.connTimedOut);
      AppUtils.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      _isLoading.value = false;
      update();
      AppUtils.printLog(StringValues.formatExcError);
      AppUtils.printLog(e);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      _isLoading.value = false;
      update();
      AppUtils.printLog(StringValues.errorOccurred);
      AppUtils.printLog(exc);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    }
  }

  Future<void> getLoginInfo() async {
    await _getLoginInfo();
  }

  @override
  void onInit() async {
    await _getLoginInfo();
    super.onInit();
  }
}
