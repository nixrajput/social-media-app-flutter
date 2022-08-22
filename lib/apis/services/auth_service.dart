import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math' show Random;

import 'package:connectivity/connectivity.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_app/apis/models/entities/location_info.dart';
import 'package:social_media_app/apis/models/responses/auth_response.dart';
import 'package:social_media_app/apis/providers/api_provider.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/helpers/utils.dart';

class AuthService extends GetxService {
  static AuthService get find => Get.find();

  final _apiProvider = ApiProvider(http.Client());

  StreamSubscription<dynamic>? _streamSubscription;

  String _token = '';
  int _expiresAt = 0;
  String _deviceId = '';
  AuthResponse _loginData = const AuthResponse();

  String get token => _token;

  String get deviceId => _deviceId;

  int get expiresAt => _expiresAt;

  AuthResponse get loginData => _loginData;

  set setLoginData(AuthResponse value) => _loginData = value;

  set setToken(String value) => _token = value;

  set setExpiresAt(int value) => _expiresAt = value;

  Future<String> getToken() async {
    var token = '';
    final decodedData = await AppUtils.readLoginDataFromLocalStorage();
    if (decodedData != null) {
      _expiresAt = decodedData[StringValues.expiresAt];
      setToken = decodedData[StringValues.token];
      token = decodedData[StringValues.token];
      await getDeviceId();
    }
    return token;
  }

  Future<void> _logout() async {
    setToken = '';
    setExpiresAt = 0;
    await AppUtils.clearLoginDataFromLocalStorage();
    AppUtils.printLog(StringValues.logoutSuccessful);
  }

  Future<void> getDeviceId() async {
    final devData = GetStorage();

    const chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    var rnd = Random();

    var devId = String.fromCharCodes(
      Iterable.generate(
        16,
        (_) => chars.codeUnitAt(rnd.nextInt(chars.length)),
      ),
    );

    await devData.writeIfNull('deviceId', devId);

    _deviceId = devData.read('deviceId');

    AppUtils.printLog("deviceId: $_deviceId");
  }

  Future<dynamic> getDeviceInfo() async {
    var deviceInfoPlugin = DeviceInfoPlugin();
    Map<String, dynamic> deviceInfo;
    if (GetPlatform.isIOS) {
      var iosInfo = await deviceInfoPlugin.iosInfo;
      var deviceModel = iosInfo.utsname.machine;
      var deviceSystemVersion = iosInfo.utsname.release;

      deviceInfo = <String, dynamic>{
        "model": deviceModel,
        "osVersion": deviceSystemVersion
      };
    } else {
      var androidInfo = await deviceInfoPlugin.androidInfo;
      var deviceModel = androidInfo.model;
      var deviceSystemVersion = androidInfo.version.release;

      deviceInfo = <String, dynamic>{
        "model": deviceModel,
        "osVersion": deviceSystemVersion
      };
    }

    return deviceInfo;
  }

  Future<LocationInfo> getLocationInfo() async {
    var locationInfo = const LocationInfo();
    try {
      final response = await _apiProvider.getLocationInfo();

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        locationInfo = LocationInfo.fromJson(decodedData);
      } else {
        AppUtils.printLog(StringValues.message);
      }
    } on SocketException {
      AppUtils.printLog(StringValues.internetConnError);
      AppUtils.showSnackBar(StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      AppUtils.printLog(StringValues.connTimedOut);
      AppUtils.printLog(StringValues.connTimedOut);
      AppUtils.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      AppUtils.printLog(StringValues.formatExcError);
      AppUtils.printLog(e);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      AppUtils.printLog(StringValues.errorOccurred);
      AppUtils.printLog(exc);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    }

    return locationInfo;
  }

  Future<void> saveLoginInfo() async {
    var deviceInfo = await getDeviceInfo();
    await getDeviceId();
    var locationInfo = await getLocationInfo();

    final body = {
      "deviceId": _deviceId,
      'deviceInfo': deviceInfo,
      'locationInfo': locationInfo,
      'lastActive': DateTime.now().toIso8601String(),
    };

    AppUtils.printLog("Save LoginInfo Request...");

    try {
      final response = await _apiProvider.saveDeviceInfo(_token, body);

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        AppUtils.printLog(decodedData[StringValues.message]);
      } else {
        AppUtils.printLog(decodedData[StringValues.message]);
      }
    } on SocketException {
      AppUtils.printLog(StringValues.internetConnError);
      AppUtils.showSnackBar(StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      AppUtils.printLog(StringValues.connTimedOut);
      AppUtils.printLog(StringValues.connTimedOut);
      AppUtils.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      AppUtils.printLog(StringValues.formatExcError);
      AppUtils.printLog(e);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      AppUtils.printLog(StringValues.errorOccurred);
      AppUtils.printLog(exc);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    }
  }

  void autoLogout() async {
    if (_expiresAt > 0) {
      var currentTimestamp =
          (DateTime.now().millisecondsSinceEpoch / 1000).round();
      if (_expiresAt < currentTimestamp) {
        setToken = '';
        setExpiresAt = 0;
        await AppUtils.clearLoginDataFromLocalStorage();
      }
    }
  }

  void _checkForInternetConnectivity() {
    _streamSubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      if (result != ConnectivityResult.none) {
        AppUtils.closeDialog();
      } else {
        AppUtils.showNoInternetDialog();
      }
    });
  }

  Future<void> logout() async => await _logout();

  @override
  void onInit() {
    _checkForInternetConnectivity();
    super.onInit();
  }

  @override
  onClose() {
    _streamSubscription?.cancel();
    super.onClose();
  }
}
