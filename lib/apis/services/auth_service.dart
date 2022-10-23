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
import 'package:social_media_app/apis/providers/socket_api_provider.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/modules/chat/controllers/chat_controller.dart';
import 'package:social_media_app/modules/settings/controllers/login_device_info_controller.dart';
import 'package:social_media_app/utils/utility.dart';

class AuthService extends GetxService {
  static AuthService get find => Get.find();

  final _apiProvider = ApiProvider(http.Client());

  StreamSubscription<dynamic>? _streamSubscription;

  String _token = '';
  int _expiresAt = 0;
  int _deviceId = 0;
  bool _isLogin = false;
  AuthResponse _loginData = const AuthResponse();

  String get token => _token;

  int? get deviceId => _deviceId;

  int get expiresAt => _expiresAt;

  bool get isLogin => _isLogin;

  AuthResponse get loginData => _loginData;

  set setLoginData(AuthResponse value) => _loginData = value;

  set setToken(String value) => _token = value;

  set setExpiresAt(int value) => _expiresAt = value;

  set setDeviceId(int value) => _deviceId = value;

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

  @override
  void onInit() {
    AppUtility.log("AuthService Initializing");
    super.onInit();
    _checkForInternetConnectivity();
    getDeviceId();
    AppUtility.log("AuthService Initialized");
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
      _isLogin = true;
    }
    return token;
  }

  Future<String> _checkServerHealth() async {
    AppUtility.log('Check Server Health Request');
    var serverHealth = 'offline';
    try {
      final response = await _apiProvider.checkServerHealth();

      if (response.isSuccessful) {
        serverHealth = response.data['server'];
      } else {
        serverHealth = response.data['server'];
      }
    } catch (exc) {
      AppUtility.log('Error: $exc', tag: 'error');
    }

    return serverHealth;
  }

  Future<bool> _validateToken(String token) async {
    var isValid = false;
    try {
      final response = await _apiProvider.validateToken(token);

      if (response.isSuccessful) {
        var data = response.data;
        isValid = true;
        AppUtility.log(data[StringValues.message]);
      } else {
        var data = response.data;
        AppUtility.log(data[StringValues.message], tag: 'error');
      }
    } catch (exc) {
      AppUtility.log('Error: ${exc.toString()}', tag: 'error');
    }

    return isValid;
  }

  Future<void> _logout() async {
    AppUtility.log("Logout Request");
    await LoginDeviceInfoController.find
        .deleteLoginDeviceInfo(_deviceId.toString());
    setToken = '';
    setExpiresAt = 0;
    _isLogin = false;
    SocketApiProvider().close();
    await ChatController.find.close();
    await AppUtility.clearLoginDataFromLocalStorage();
    await AppUtility.deleteFcmTokenFromLocalStorage();
    await AppUtility.deletePostDataFromLocalStorage();
    await AppUtility.deleteProfilePostDataFromLocalStorage();
    AppUtility.log("Logout Success");
    AppUtility.showSnackBar(
      'Logout Successfully',
      '',
    );
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

    AppUtility.log("deviceId: $_deviceId");
  }

  Future<void> saveDeviceIdToServer(String deviceId) async {
    AppUtility.log("Save DeviceId Request");

    try {
      final response = await _apiProvider.saveDeviceId(
        token,
        {'deviceId': deviceId},
      );

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        AppUtility.log("Save DeviceId Success");
        AppUtility.log(decodedData[StringValues.message], tag: 'info');
      } else {
        AppUtility.log("Save DeviceId Error");
        AppUtility.log(decodedData[StringValues.message], tag: 'error');
      }
    } on SocketException {
      AppUtility.log("Save DeviceId Error");
      AppUtility.log(StringValues.internetConnError, tag: 'error');
    } on TimeoutException {
      AppUtility.log("Save DeviceId Error");
      AppUtility.log(StringValues.connTimedOut, tag: 'error');
    } on FormatException catch (e) {
      AppUtility.log("Save DeviceId Error");
      AppUtility.log('Format Exception: $e', tag: 'error');
    } catch (exc) {
      AppUtility.printLog("Save DeviceId Error");
      AppUtility.log('Error: $exc', tag: 'error');
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
      AppUtility.log("Save DeviceId Error");
      AppUtility.log('Format Exception: $e', tag: 'error');
    } catch (exc) {
      AppUtility.printLog("Save DeviceId Error");
      AppUtility.log('Error: $exc', tag: 'error');
    }
  }

  Future<void> saveFcmToken(String fcmToken) async {
    AppUtility.log("Save FcmToken Request");

    try {
      final response = await _apiProvider.saveFcmToken(
        _token,
        fcmToken,
      );

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        AppUtility.log(decodedData[StringValues.message]);
        AppUtility.printLog("Save FcmToken Success");
      } else {
        AppUtility.log(
            "Save FcmToken Error: ${decodedData[StringValues.message]}",
            tag: 'error');
      }
    } on SocketException {
      AppUtility.log("Save FcmToken Error");
      AppUtility.log(StringValues.internetConnError);
    } on TimeoutException {
      AppUtility.log("Save FcmToken Error");
      AppUtility.log(StringValues.connTimedOut);
    } on FormatException catch (e) {
      AppUtility.log("Save DeviceId Error");
      AppUtility.log('Format Exception: $e', tag: 'error');
    } catch (exc) {
      AppUtility.printLog("Save DeviceId Error");
      AppUtility.log('Error: $exc', tag: 'error');
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

      if (response.isSuccessful) {
        final decodedData = response.data;
        locationInfo = LocationInfo.fromJson(decodedData);
      } else {
        final decodedData = response.data;
        AppUtility.printLog(decodedData[StringValues.message]);
      }
    } catch (exc) {
      AppUtility.log('Error: $exc', tag: 'error');
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

    try {
      final response = await _apiProvider.saveDeviceInfo(_token, body);

      if (response.isSuccessful) {
        final decodedData = response.data;
        AppUtility.log(decodedData[StringValues.message]);
      } else {
        final decodedData = response.data;
        AppUtility.log(decodedData[StringValues.message], tag: 'error');
      }
    } catch (exc) {
      AppUtility.log('Error: $exc', tag: 'error');
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

  Future<void> logout() async => await _logout();

  Future<bool> validateToken(String token) async => await _validateToken(token);

  Future<String> checkServerHealth() async => await _checkServerHealth();
}
