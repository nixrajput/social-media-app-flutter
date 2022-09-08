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
import 'package:social_media_app/helpers/utils.dart';
import 'package:social_media_app/modules/home/controllers/profile_controller.dart';
import 'package:social_media_app/routes/route_management.dart';

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
      AppUtils.showSnackBar(
        StringValues.enterPhoneNo,
        StringValues.warning,
      );
      return;
    }

    if (profile.profileDetails.user!.phone == phone) {
      AppUtils.showSnackBar(
        StringValues.enterDifferentPhoneNo,
        StringValues.warning,
      );
      return;
    }

    final body = {
      "phone": _phone.value,
      "countryCode": code.dialCode,
    };

    AppUtils.printLog("Send Change Phone OTP Request");
    AppUtils.showLoadingDialog();
    _isLoading.value = true;
    update();

    try {
      final response =
          await _apiProvider.sendAddChangePhoneOtp(_auth.token, body);

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        AppUtils.printLog("Send Change Phone OTP Success");
        AppUtils.closeDialog();
        _isLoading.value = false;
        _otpSent.value = true;
        update();
        AppUtils.showSnackBar(
          decodedData[StringValues.message],
          StringValues.success,
        );
      } else {
        AppUtils.closeDialog();
        _isLoading.value = false;
        update();
        AppUtils.printLog("Send Change Phone OTP Error");
        AppUtils.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } on SocketException {
      AppUtils.closeDialog();
      _isLoading.value = false;
      update();
      AppUtils.printLog("Send Change Phone OTP Error");
      AppUtils.printLog(StringValues.internetConnError);
      AppUtils.showSnackBar(StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      AppUtils.closeDialog();
      _isLoading.value = false;
      update();
      AppUtils.printLog("Send Change Phone OTP Error");
      AppUtils.printLog(StringValues.connTimedOut);
      AppUtils.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      AppUtils.closeDialog();
      _isLoading.value = false;
      update();
      AppUtils.printLog("Send Change Phone OTP Error");
      AppUtils.printLog(StringValues.formatExcError);
      AppUtils.printLog(e);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      AppUtils.closeDialog();
      _isLoading.value = false;
      update();
      AppUtils.printLog("Send Change Phone OTP Error");
      AppUtils.printLog(StringValues.errorOccurred);
      AppUtils.printLog(exc);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    }
  }

  Future<void> _addChangePhone() async {
    if (_otp.value.isEmpty) {
      AppUtils.showSnackBar(
        StringValues.enterOtp,
        StringValues.warning,
      );
      return;
    }

    if (_phone.value.isEmpty) {
      AppUtils.showSnackBar(
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

    AppUtils.printLog("Change Phone Request");
    AppUtils.showLoadingDialog();
    _isLoading.value = true;
    update();

    try {
      final response = await _apiProvider.addChangePhone(_auth.token, body);

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        AppUtils.printLog("Change Phone Success");
        await profile.fetchProfileDetails(fetchPost: false);
        AppUtils.closeDialog();
        _isLoading.value = false;
        update();
        RouteManagement.goToBack();
        AppUtils.showSnackBar(
          decodedData[StringValues.message],
          StringValues.success,
        );
      } else {
        AppUtils.closeDialog();
        _isLoading.value = false;
        update();
        AppUtils.printLog("Change Phone Error");
        AppUtils.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } on SocketException {
      AppUtils.closeDialog();
      _isLoading.value = false;
      update();
      AppUtils.printLog("Change Phone Error");
      AppUtils.printLog(StringValues.internetConnError);
      AppUtils.showSnackBar(StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      AppUtils.closeDialog();
      _isLoading.value = false;
      update();
      AppUtils.printLog("Change Phone Error");
      AppUtils.printLog(StringValues.connTimedOut);
      AppUtils.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      AppUtils.closeDialog();
      _isLoading.value = false;
      update();
      AppUtils.printLog("Change Phone Error");
      AppUtils.printLog(StringValues.formatExcError);
      AppUtils.printLog(e);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      AppUtils.closeDialog();
      _isLoading.value = false;
      update();
      AppUtils.printLog("Change Phone Error");
      AppUtils.printLog(StringValues.errorOccurred);
      AppUtils.printLog(exc);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
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
    AppUtils.closeFocus();
    await _addChangePhone();
  }

  Future<void> sendAddChangePhoneOtp() async {
    AppUtils.closeFocus();
    await _sendAddChangePhoneOtp();
  }
}
