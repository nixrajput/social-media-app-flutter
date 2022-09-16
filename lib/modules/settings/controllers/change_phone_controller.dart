import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_app/apis/providers/api_provider.dart';
import 'package:social_media_app/apis/services/auth_service.dart';
import 'package:social_media_app/constants/dimens.dart';
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

    if (profile.profileDetails.user!.phone == phone) {
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

    AppUtility.printLog("Send Change Phone OTP Request");
    AppUtility.showLoadingDialog();
    _isLoading.value = true;
    update();

    try {
      final response =
          await _apiProvider.sendAddChangePhoneOtp(_auth.token, body);

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        AppUtility.printLog("Send Change Phone OTP Success");
        AppUtility.closeDialog();
        _isLoading.value = false;
        _otpSent.value = true;
        update();
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.success,
        );
      } else {
        AppUtility.closeDialog();
        _isLoading.value = false;
        update();
        AppUtility.printLog("Send Change Phone OTP Error");
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } on SocketException {
      AppUtility.closeDialog();
      _isLoading.value = false;
      update();
      AppUtility.printLog("Send Change Phone OTP Error");
      AppUtility.printLog(StringValues.internetConnError);
      AppUtility.showSnackBar(
          StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      AppUtility.closeDialog();
      _isLoading.value = false;
      update();
      AppUtility.printLog("Send Change Phone OTP Error");
      AppUtility.printLog(StringValues.connTimedOut);
      AppUtility.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      AppUtility.closeDialog();
      _isLoading.value = false;
      update();
      AppUtility.printLog("Send Change Phone OTP Error");
      AppUtility.printLog(StringValues.formatExcError);
      AppUtility.printLog(e);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      AppUtility.closeDialog();
      _isLoading.value = false;
      update();
      AppUtility.printLog("Send Change Phone OTP Error");
      AppUtility.printLog(StringValues.errorOccurred);
      AppUtility.printLog(exc);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
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

    AppUtility.printLog("Change Phone Request");
    AppUtility.showLoadingDialog();
    _isLoading.value = true;
    update();

    try {
      final response = await _apiProvider.addChangePhone(_auth.token, body);

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        AppUtility.printLog("Change Phone Success");
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
        AppUtility.closeDialog();
        _isLoading.value = false;
        update();
        AppUtility.printLog("Change Phone Error");
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } on SocketException {
      AppUtility.closeDialog();
      _isLoading.value = false;
      update();
      AppUtility.printLog("Change Phone Error");
      AppUtility.printLog(StringValues.internetConnError);
      AppUtility.showSnackBar(
          StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      AppUtility.closeDialog();
      _isLoading.value = false;
      update();
      AppUtility.printLog("Change Phone Error");
      AppUtility.printLog(StringValues.connTimedOut);
      AppUtility.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      AppUtility.closeDialog();
      _isLoading.value = false;
      update();
      AppUtility.printLog("Change Phone Error");
      AppUtility.printLog(StringValues.formatExcError);
      AppUtility.printLog(e);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      AppUtility.closeDialog();
      _isLoading.value = false;
      update();
      AppUtility.printLog("Change Phone Error");
      AppUtility.printLog(StringValues.errorOccurred);
      AppUtility.printLog(exc);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    }
  }

  void showCountryCodePicker() async {
    const countryPicker = FlCountryCodePicker();
    final code = await countryPicker.showPicker(
      context: Get.context!,
      fullScreen: false,
      pickerMinHeight: Dimens.screenHeight * 0.5,
      pickerMaxHeight: Dimens.screenHeight * 0.75,
      initialSelectedLocale: 'IN',
    );
    if (code != null) {
      onChangeCountryCode(code);
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
