import 'dart:async';
import 'dart:convert';
import 'dart:math' show Random;

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_app/apis/models/responses/auth_response.dart';
import 'package:social_media_app/apis/providers/api_provider.dart';
import 'package:social_media_app/apis/providers/socket_api_provider.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/modules/chat/controllers/chat_controller.dart';
import 'package:social_media_app/routes/route_management.dart';
import 'package:social_media_app/services/hive_service.dart';
import 'package:social_media_app/services/storage_service.dart';
import 'package:social_media_app/utils/utility.dart';

class AuthService extends GetxService {
  static AuthService get find => Get.find();

  final _apiProvider = ApiProvider(http.Client());

  String _token = '';
  int _expiresAt = 0;
  int _deviceId = 0;
  bool _isLoggedIn = false;
  AuthResponse _loginData = AuthResponse();

  /// Getters
  String get token => _token;

  int? get deviceId => _deviceId;

  int get expiresAt => _expiresAt;

  bool get isLoggedIn => _isLoggedIn;

  AuthResponse get loginData => _loginData;

  /// Setters
  set setLoginData(AuthResponse value) => _loginData = value;

  set setToken(String value) => _token = value;

  set setExpiresAt(int value) => _expiresAt = value;

  set setDeviceId(int value) => _deviceId = value;

  @override
  void onInit() {
    AppUtility.log("AuthService Initializing");
    super.onInit();
    getDeviceId();
    AppUtility.log("AuthService Initialized");
  }

  Future<String> getToken() async {
    var authToken = '';
    final decodedData = await readLoginDataFromLocalStorage();
    if (decodedData != null) {
      setExpiresAt = decodedData[StringValues.expiresAt];
      setToken = decodedData[StringValues.token];
      authToken = decodedData[StringValues.token];
      _isLoggedIn = true;
    }
    return authToken;
  }

  Future<String?> _checkServerHealth() async {
    try {
      final response = await _apiProvider.checkServerHealth();

      if (response.isSuccessful) {
        return response.data['server'];
      } else {
        return response.data['server'];
      }
    } catch (exc) {
      AppUtility.log('Error: $exc', tag: 'error');
    }

    return null;
  }

  Future<bool?> _validateToken(String token) async {
    try {
      final response = await _apiProvider.validateToken(token);

      if (response.isSuccessful) {
        var data = response.data;
        AppUtility.log(data[StringValues.message]);
        return true;
      } else {
        var data = response.data;
        AppUtility.log(data[StringValues.message], tag: 'error');
        return false;
      }
    } catch (exc) {
      AppUtility.log('Error: ${exc.toString()}', tag: 'error');
      return null;
    }
  }

  Future<void> _validateDeviceSession() async {
    try {
      final response = await _apiProvider.verifyLoginInfo(
        token,
        deviceId.toString(),
      );

      if (response.isSuccessful) {
        var data = response.data;
        AppUtility.log(data[StringValues.message]);
      } else {
        var data = response.data;
        AppUtility.log(data[StringValues.message]);
        if (data['isValid'] == false) {
          await _logout();
          RouteManagement.goToWelcomeView();
        }
      }
    } catch (exc) {
      AppUtility.log('Error: ${exc.toString()}', tag: 'error');
    }
  }

  Future<void> deleteAllLocalDataAndCache() async {
    await StorageService.remove('loginData');
    await StorageService.remove('profileData');
    await StorageService.remove("fcmToken");
    await HiveService.deleteAllBoxes();
    AppUtility.log('Local Data Removed');
  }

  Future<void> _logout() async {
    final _socket = SocketApiProvider();
    final _chatController = ChatController.find;
    AppUtility.log("Logout Request");
    setToken = '';
    setExpiresAt = 0;

    if (_socket.isConnected) {
      _socket.dispose();
      await _chatController.close();
    }
    await FirebaseMessaging.instance.deleteToken();
    await deleteAllLocalDataAndCache();
    _isLoggedIn = false;
    AppUtility.log("Logout Success");
    AppUtility.showSnackBar(
      'Logout Successfully',
      '',
    );
  }

  Future<Map<String, dynamic>?> readLoginDataFromLocalStorage() async {
    var hasData = await StorageService.hasData('loginData');

    if (hasData) {
      AppUtility.log('Login Data Found');
      var data = StorageService.read('loginData') as Map<String, dynamic>;
      return data;
    } else {
      AppUtility.log('No Login Data Found', tag: 'error');
      return null;
    }
  }

  Future<void> saveLoginDataToLocalStorage(String token, int expiresAt) async {
    if (token.isEmpty && expiresAt <= 0) {
      AppUtility.log('Token or ExpiresAt is empty', tag: 'error');
      return;
    }

    final data = {
      StringValues.token: token,
      StringValues.expiresAt: expiresAt,
    };

    await StorageService.write('loginData', data);
    AppUtility.log('Login Data Saved to Local Storage');
  }

  Future<void> saveFcmTokenToLocalStorage(String fcmToken) async {
    if (fcmToken.isEmpty) {
      AppUtility.log('Fcm Token is empty', tag: 'error');
      return;
    }

    await StorageService.write('fcmToken', base64Encode(fcmToken.codeUnits));
    AppUtility.log('Fcm Token Saved to Local Storage');
  }

  Future<String> readFcmTokenFromLocalStorage() async {
    var hasData = await StorageService.hasData('fcmToken');

    if (hasData) {
      AppUtility.log('Fcm Token Found');
      var data = StorageService.read('fcmToken');
      return String.fromCharCodes(base64Decode(data));
    } else {
      AppUtility.log('No Fcm Token Found', tag: 'error');
      return '';
    }
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
  }

  Future<void> savePreKeyBundle(Map<String, dynamic> preKeyBundle) async {
    var body = {'preKeyBundle': preKeyBundle};
    try {
      final response = await _apiProvider.savePreKeyBundle(_token, body);

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

  Future<void> saveFcmToken(String fcmToken) async {
    try {
      final response = await _apiProvider.saveFcmToken(_token, fcmToken);

      if (response.isSuccessful) {
        final decodedData = response.data;
        AppUtility.log(decodedData[StringValues.message]);
      } else {
        final decodedData = response.data;
        AppUtility.log("${decodedData[StringValues.message]}", tag: 'error');
      }
    } catch (exc) {
      AppUtility.log('Error: $exc', tag: 'error');
    }
  }

  Future<dynamic> _getDeviceInfo() async {
    var deviceInfoPlugin = DeviceInfoPlugin();
    Map<String, dynamic> deviceInfo;
    if (GetPlatform.isIOS) {
      var iosInfo = await deviceInfoPlugin.iosInfo;

      deviceInfo = <String, dynamic>{
        "deviceName": iosInfo.utsname.machine,
        "deviceModel": iosInfo.utsname.machine,
        "deviceBrand": "Apple",
        "deviceManufacturer": "Apple",
        "deviceOs": iosInfo.utsname.sysname,
        "deviceOsVersion": iosInfo.utsname.version,
        "deviceType": "ios",
        "deviceUniqueId": iosInfo.identifierForVendor,
      };
    } else {
      var androidInfo = await deviceInfoPlugin.androidInfo;

      deviceInfo = <String, dynamic>{
        "deviceName": androidInfo.device,
        "deviceModel": androidInfo.model,
        "deviceBrand": androidInfo.brand,
        "deviceManufacturer": androidInfo.manufacturer,
        "deviceOs": androidInfo.version.release,
        "deviceOsVersion": androidInfo.version.sdkInt.toString(),
        "deviceType": "android",
        "deviceUniqueId": androidInfo.id,
      };
    }

    return deviceInfo;
  }

  Future<void> saveLoginInfo() async {
    var deviceInfo = await _getDeviceInfo();
    await getDeviceId();

    final body = {
      'deviceId': _deviceId.toString(),
      'deviceInfo': deviceInfo,
    };

    try {
      final response = await _apiProvider.saveLoginInfo(_token, body);

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

  Future<bool> validateLocalAuthToken() async {
    AppUtility.log('Validating Local Auth Token');
    var currentTimestamp =
        (DateTime.now().millisecondsSinceEpoch / 1000).round();

    if (_expiresAt > currentTimestamp) {
      return true;
    }

    return false;
  }

  Future<void> logout() async => await _logout();

  Future<bool?> validateToken(String token) async =>
      await _validateToken(token);

  Future<String?> checkServerHealth() async => await _checkServerHealth();

  Future<void> validateDeviceSession() async => await _validateDeviceSession();
}
