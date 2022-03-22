import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';

import '../../../constants/strings.dart';

abstract class HelperFunction {
  static Future<void> saveLoginDataToLocalStorage(_token, _expiresAt) async {
    if (_token!.isNotEmpty && _expiresAt!.isNotEmpty) {
      final loginData = GetStorage();
      final data = jsonEncode({
        StringValues.token: _token,
        StringValues.expiresAt: _expiresAt,
      });

      loginData.write(StringValues.loginData, data);
      debugPrint('Auth details saved.');
    } else {
      debugPrint('Auth details could not saved.');
    }
  }

  static Future<dynamic> readLoginDataFromLocalStorage() async {
    final loginData = GetStorage();

    if (loginData.hasData(StringValues.loginData)) {
      final data = await loginData.read(StringValues.loginData);
      var decodedData = jsonDecode(data) as Map<String, dynamic>;
      debugPrint('Auth details found.');
      return decodedData;
    }
    return null;
  }

  static Future<void> clearLoginDataFromLocalStorage() async {
    final loginData = GetStorage();
    loginData.remove(StringValues.loginData);
    debugPrint('Auth details removed.');
  }
}
