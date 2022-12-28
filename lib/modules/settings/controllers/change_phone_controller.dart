import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_app/apis/models/entities/country_code.dart';
import 'package:social_media_app/apis/providers/api_provider.dart';
import 'package:social_media_app/app_services/auth_service.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/modules/home/controllers/profile_controller.dart';
import 'package:social_media_app/routes/route_management.dart';
import 'package:social_media_app/utils/utility.dart';

class ChangePhoneController extends GetxController {
  static ChangePhoneController get find => Get.find();

  final _auth = AuthService.find;
  final profile = ProfileController.find;

  final _apiProvider = ApiProvider(http.Client());

  final _isLoading = false.obs;
  final _otpSent = false.obs;
  final _phone = ''.obs;
  final _otp = ''.obs;
  final FocusScopeNode focusNode = FocusScopeNode();
  CountryCode code = const CountryCode(
    name: 'India',
    code: 'IN',
    dialCode: '+91',
  );

  /// Getters
  bool get isLoading => _isLoading.value;

  bool get otpSent => _otpSent.value;

  String get phone => _phone.value;

  String get otp => _otp.value;

  /// Setters
  set phone(String val) => _phone.value = val;

  set otp(String val) => _otp.value = val;

  void onChangeCountryCode(CountryCode code) {
    code = code;
    update();
  }

  void onChangePhone(String value) {
    phone = value;
    update();
  }

  void onChangeOtp(String value) {
    otp = value;
    update();
  }

  Future<void> _sendAddChangePhoneOtp() async {
    if (_phone.value.isEmpty) {
      AppUtility.showSnackBar(
        StringValues.enterPhoneNo,
        StringValues.warning,
      );
      return;
    }

    if (profile.profileDetails!.user!.phone == phone) {
      AppUtility.showSnackBar(
        StringValues.enterDifferentPhoneNo,
        StringValues.warning,
      );
      return;
    }

    final body = {
      "phone": _phone.value,
      "countryCode": code.dialCode,
    };

    AppUtility.showLoadingDialog();
    _isLoading.value = true;
    update();

    try {
      final response =
          await _apiProvider.sendAddChangePhoneOtp(_auth.token, body);

      if (response.isSuccessful) {
        final decodedData = response.data;
        AppUtility.closeDialog();
        _isLoading.value = false;
        _otpSent.value = true;
        update();
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.success,
        );
      } else {
        final decodedData = response.data;
        AppUtility.closeDialog();
        _isLoading.value = false;
        update();
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } catch (exc) {
      AppUtility.closeDialog();
      _isLoading.value = false;
      update();
      AppUtility.log('Error: $exc', tag: 'error');
      AppUtility.showSnackBar('Error: $exc', StringValues.error);
    }
  }

  Future<void> _addChangePhone() async {
    if (_otp.value.isEmpty) {
      AppUtility.showSnackBar(
        StringValues.enterOtp,
        StringValues.warning,
      );
      return;
    }

    if (_phone.value.isEmpty) {
      AppUtility.showSnackBar(
        StringValues.enterPhoneNo,
        StringValues.warning,
      );
      return;
    }

    final body = {
      'otp': _otp.value,
      "phone": _phone.value,
      "countryCode": code.dialCode,
    };

    AppUtility.showLoadingDialog();
    _isLoading.value = true;
    update();

    try {
      final response = await _apiProvider.addChangePhone(_auth.token, body);

      if (response.isSuccessful) {
        final decodedData = response.data;
        await profile.fetchProfileDetails(fetchPost: false);
        AppUtility.closeDialog();
        _isLoading.value = false;
        update();
        RouteManagement.goToBack();
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.success,
        );
      } else {
        final decodedData = response.data;
        AppUtility.closeDialog();
        _isLoading.value = false;
        update();
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } catch (exc) {
      AppUtility.closeDialog();
      _isLoading.value = false;
      update();
      AppUtility.log('Error: $exc', tag: 'error');
      AppUtility.showSnackBar('Error: $exc', StringValues.error);
    }
  }

  Future<void> addChangePhone() async {
    AppUtility.closeFocus();
    await _addChangePhone();
  }

  Future<void> sendAddChangePhoneOtp() async {
    AppUtility.closeFocus();
    await _sendAddChangePhoneOtp();
  }
}
