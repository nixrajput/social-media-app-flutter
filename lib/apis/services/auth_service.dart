import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_app/apis/models/responses/login_response.dart';
import 'package:social_media_app/apis/providers/api_provider.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/helpers/permissions.dart';
import 'package:social_media_app/helpers/utils.dart';

class AuthService extends GetxService {
  static AuthService get find => Get.find();

  final _apiProvider = ApiProvider(http.Client());

  StreamSubscription<dynamic>? _streamSubscription;

  String _token = '';
  int _expiresAt = 0;
  String _deviceId = '';
  LoginResponse _loginData = const LoginResponse();

  String get token => _token;

  String get deviceId => _deviceId;

  int get expiresAt => _expiresAt;

  LoginResponse get loginData => _loginData;

  set setLoginData(LoginResponse value) => _loginData = value;

  set setToken(String value) => _token = value;

  set setExpiresAt(int value) => _expiresAt = value;

  Future<String> getToken() async {
    var token = '';
    final decodedData = await AppUtils.readLoginDataFromLocalStorage();
    if (decodedData != null) {
      _expiresAt = decodedData[StringValues.expiresAt];
      setToken = decodedData[StringValues.token];
      token = decodedData[StringValues.token];
    }
    return token;
  }

  Future<void> _logout() async {
    setToken = '';
    setExpiresAt = 0;
    await AppUtils.clearLoginDataFromLocalStorage();
    AppUtils.printLog(StringValues.logoutSuccessful);
  }

  Future<dynamic> getCurrentLocation() async {
    var hasPerm = await AppPermissions.checkLocationPermission();
    if (!hasPerm) {
      return;
    }
    var position = await Geolocator.getCurrentPosition();
    var loc =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    var locationInfo = <String, dynamic>{
      "street": loc.first.street,
      "locality": loc.first.locality,
      "city": loc.first.subAdministrativeArea,
      "state": loc.first.administrativeArea,
      "country": loc.first.country,
      "countryCode": loc.first.isoCountryCode,
      "pincode": loc.first.postalCode
    };
    AppUtils.printLog("Location Info: $locationInfo");
    return locationInfo;
  }

  Future<dynamic> getDeviceInfo() async {
    var deviceInfoPlugin = DeviceInfoPlugin();
    Map<String, dynamic> deviceInfo;
    if (GetPlatform.isIOS) {
      var iosInfo = await deviceInfoPlugin.iosInfo;
      var deviceBrand = iosInfo.utsname.machine;
      var deviceModel = iosInfo.model;
      var deviceSystemVersion = iosInfo.utsname.release;
      var deviceId = iosInfo.identifierForVendor;

      deviceInfo = <String, dynamic>{
        "deviceId": deviceId,
        "model": deviceModel,
        "brand": deviceBrand,
        "osVersion": deviceSystemVersion
      };
    } else {
      var androidInfo = await deviceInfoPlugin.androidInfo;
      var deviceBrand = androidInfo.brand;
      var deviceModel = androidInfo.model;
      var deviceSystemVersion = androidInfo.version.release;

      deviceInfo = <String, dynamic>{
        "deviceId": deviceId,
        "model": deviceModel,
        "brand": deviceBrand,
        "osVersion": deviceSystemVersion
      };
    }

    return deviceInfo;
  }

  Future<void> saveLoginInfo() async {
    var deviceInfo = await getDeviceInfo();
    _deviceId = deviceInfo['deviceId'];
    var locationInfo = await getCurrentLocation();

    final body = {
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
