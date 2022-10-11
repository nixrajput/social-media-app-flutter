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
import 'package:social_media_app/modules/settings/controllers/login_device_info_controller.dart';
import 'package:social_media_app/utils/utility.dart';

class AuthService extends GetxService {
  static AuthService get find => Get.find();

  final _apiProvider = ApiProvider(http.Client());

  StreamSubscription<dynamic>? _streamSubscription;

  String _token = '';
  int _expiresAt = 0;
  int _deviceId = 0;
  AuthResponse _loginData = const AuthResponse();

  String get token => _token;

  int? get deviceId => _deviceId;

  int get expiresAt => _expiresAt;

  AuthResponse get loginData => _loginData;

  set setLoginData(AuthResponse value) => _loginData = value;

  set setToken(String value) => _token = value;

  set setExpiresAt(int value) => _expiresAt = value;

  set setDeviceId(int value) => _deviceId = value;

  @override
  void onInit() {
    _checkForInternetConnectivity();
    getDeviceId();
    super.onInit();
  }

  @override
  onClose() {
    _streamSubscription?.cancel();
    super.onClose();
  }

  Future<String> getToken() async {
    var token = '';
    final decodedData = await AppUtility.readLoginDataFromLocalStorage();
    if (decodedData != null) {
      _expiresAt = decodedData[StringValues.expiresAt];
      setToken = decodedData[StringValues.token];
      token = decodedData[StringValues.token];
    }
    return token;
  }

  Future<String> _checkServerHealth() async {
    AppUtility.printLog('Check Server Health Request');
    var serverHealth = 'offline';
    try {
      final response = await _apiProvider.checkServerHealth();

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));
      AppUtility.printLog(decodedData);
      if (response.statusCode == 200) {
        AppUtility.printLog('Check Server Health Success');
        serverHealth = decodedData['server'];
      } else {
        AppUtility.printLog('Check Server Health Error');
        serverHealth = decodedData['server'];
      }
    } catch (exc) {
      AppUtility.printLog('Check Server Health Error');
      AppUtility.printLog(StringValues.errorOccurred);
      AppUtility.printLog(exc);
    }

    return serverHealth;
  }

  Future<bool> _validateToken(String token) async {
    var isValid = false;
    try {
      final response = await _apiProvider.validateToken(token);

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));
      AppUtility.printLog(decodedData);
      if (response.statusCode == 200) {
        isValid = true;
        AppUtility.printLog(decodedData[StringValues.message]);
      } else {
        AppUtility.printLog(decodedData[StringValues.message]);
      }
    } catch (exc) {
      AppUtility.printLog(StringValues.errorOccurred);
      AppUtility.printLog(exc);
    }

    return isValid;
  }

  Future<void> _logout(bool showLoading) async {
    AppUtility.printLog("Logout Request");
    if (showLoading) AppUtility.showLoadingDialog();
    await LoginDeviceInfoController.find
        .deleteLoginDeviceInfo(_deviceId.toString());
    setToken = '';
    setExpiresAt = 0;
    await AppUtility.clearLoginDataFromLocalStorage();
    if (showLoading) AppUtility.closeDialog();
    AppUtility.printLog("Logout Success");
  }

  String generateDeviceId() {
    const chars = '1234567890';
    var rnd = Random();

    var devId = String.fromCharCodes(
      Iterable.generate(
        16,
        (_) => chars.codeUnitAt(rnd.nextInt(chars.length)),
      ),
    );

    return devId;
  }

  Future<void> getDeviceId() async {
    final devData = GetStorage();

    var savedDevId = devData.read('deviceId');

    try {
      setDeviceId = int.parse(savedDevId);
    } catch (err) {
      var devId = generateDeviceId();
      await devData.write('deviceId', devId);
      var savedDevId = devData.read('deviceId');
      setDeviceId = int.parse(savedDevId);
    }

    AppUtility.printLog("deviceId: $_deviceId");
  }

  Future<void> saveDeviceIdToServer(String deviceId) async {
    AppUtility.printLog("Save DeviceId Request");

    try {
      final response = await _apiProvider.saveDeviceId(
        token,
        {'deviceId': deviceId},
      );

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        AppUtility.printLog(decodedData[StringValues.message]);
        AppUtility.printLog("Save DeviceId Success");
      } else {
        AppUtility.printLog(decodedData[StringValues.message]);
        AppUtility.printLog("Save DeviceId Error");
      }
    } on SocketException {
      AppUtility.printLog("Save DeviceId Error");
      AppUtility.printLog(StringValues.internetConnError);
    } on TimeoutException {
      AppUtility.printLog("Save DeviceId Error");
      AppUtility.printLog(StringValues.connTimedOut);
    } on FormatException catch (e) {
      AppUtility.printLog("Save DeviceId Error");
      AppUtility.printLog(StringValues.formatExcError);
      AppUtility.printLog(e);
    } catch (exc) {
      AppUtility.printLog("Save DeviceId Error");
      AppUtility.printLog(StringValues.errorOccurred);
      AppUtility.printLog(exc);
    }
  }

  Future<void> savePreKeyBundle(Map<String, dynamic> preKeyBundle) async {
    AppUtility.printLog("Save PreKeyBundle Request");

    try {
      final response = await _apiProvider.savePreKeyBundle(
        _token,
        {'preKeyBundle': preKeyBundle},
      );

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        AppUtility.printLog(decodedData[StringValues.message]);
        AppUtility.printLog("Save PreKeyBundle Success");
      } else {
        AppUtility.printLog(decodedData[StringValues.message]);
        AppUtility.printLog("Save PreKeyBundle Error");
      }
    } on SocketException {
      AppUtility.printLog("Save PreKeyBundle Error");
      AppUtility.printLog(StringValues.internetConnError);
    } on TimeoutException {
      AppUtility.printLog("Save PreKeyBundle Error");
      AppUtility.printLog(StringValues.connTimedOut);
    } on FormatException catch (e) {
      AppUtility.printLog("Save PreKeyBundle Error");
      AppUtility.printLog(StringValues.formatExcError);
      AppUtility.printLog(e);
    } catch (exc) {
      AppUtility.printLog("Save PreKeyBundle Error");
      AppUtility.printLog(StringValues.errorOccurred);
      AppUtility.printLog(exc);
    }
  }

  Future<void> saveFcmToken(String fcmToken) async {
    AppUtility.printLog("Save FcmToken Request");

    try {
      final response = await _apiProvider.saveFcmToken(
        _token,
        fcmToken,
      );

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        AppUtility.printLog(decodedData[StringValues.message]);
        AppUtility.printLog("Save FcmToken Success");
      } else {
        AppUtility.printLog(decodedData[StringValues.message]);
        AppUtility.printLog("Save FcmToken Error");
      }
    } on SocketException {
      AppUtility.printLog("Save FcmToken Error");
      AppUtility.printLog(StringValues.internetConnError);
    } on TimeoutException {
      AppUtility.printLog("Save FcmToken Error");
      AppUtility.printLog(StringValues.connTimedOut);
    } on FormatException catch (e) {
      AppUtility.printLog("Save FcmToken Error");
      AppUtility.printLog(StringValues.formatExcError);
      AppUtility.printLog(e);
    } catch (exc) {
      AppUtility.printLog("Save FcmToken Error");
      AppUtility.printLog(StringValues.errorOccurred);
      AppUtility.printLog(exc);
    }
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
        AppUtility.printLog(decodedData[StringValues.message]);
      }
    } on SocketException {
      AppUtility.printLog(StringValues.internetConnError);
      AppUtility.showSnackBar(
          StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      AppUtility.printLog(StringValues.connTimedOut);
      AppUtility.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      AppUtility.printLog(StringValues.formatExcError);
      AppUtility.printLog(e);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      AppUtility.printLog(StringValues.errorOccurred);
      AppUtility.printLog(exc);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
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

    AppUtility.printLog("Save LoginInfo Request");

    try {
      final response = await _apiProvider.saveDeviceInfo(_token, body);

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        AppUtility.printLog(decodedData[StringValues.message]);
        AppUtility.printLog("Save LoginInfo Success");
      } else {
        AppUtility.printLog(decodedData[StringValues.message]);
        AppUtility.printLog("Save LoginInfo Error");
      }
    } on SocketException {
      AppUtility.printLog("Save LoginInfo Error");
      AppUtility.printLog(StringValues.internetConnError);
      AppUtility.showSnackBar(
          StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      AppUtility.printLog("Save LoginInfo Error");
      AppUtility.printLog(StringValues.connTimedOut);
      AppUtility.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      AppUtility.printLog("Save LoginInfo Error");
      AppUtility.printLog(StringValues.formatExcError);
      AppUtility.printLog(e);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      AppUtility.printLog("Save LoginInfo Error");
      AppUtility.printLog(StringValues.errorOccurred);
      AppUtility.printLog(exc);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    }
  }

  void autoLogout() async {
    if (_expiresAt > 0) {
      var currentTimestamp =
          (DateTime.now().millisecondsSinceEpoch / 1000).round();
      if (_expiresAt < currentTimestamp) {
        setToken = '';
        setExpiresAt = 0;
        await AppUtility.clearLoginDataFromLocalStorage();
      }
    }
  }

  void _checkForInternetConnectivity() {
    _streamSubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      if (result != ConnectivityResult.none) {
        AppUtility.closeDialog();
      } else {
        AppUtility.showNoInternetDialog();
      }
    });
  }

  Future<void> logout({showLoading = false}) async =>
      await _logout(showLoading);

  Future<bool> validateToken(String token) async => await _validateToken(token);

  Future<String> checkServerHealth() async => await _checkServerHealth();
}
