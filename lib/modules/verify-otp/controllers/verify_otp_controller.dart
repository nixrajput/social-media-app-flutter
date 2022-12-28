import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_app/apis/models/entities/country_code.dart';
import 'package:social_media_app/apis/providers/api_provider.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/routes/route_management.dart';
import 'package:social_media_app/utils/utility.dart';

class VerifyOtpController extends GetxController {
  static VerifyOtpController get find => Get.find();

  final _apiProvider = ApiProvider(http.Client());

  final FocusScopeNode focusNode = FocusScopeNode();

  final _isLoading = false.obs;
  final _isEmailVerification = true.obs;
  final _email = ''.obs;
  final _phone = ''.obs;
  final _otp = List.empty(growable: true)..length = 6;
  final _countryCode = const CountryCode(
    name: 'India',
    code: 'IN',
    dialCode: '+91',
  ).obs;

  Timer? resendTimer;
  int resendTimerSec = 0;
  int resendTimerMin = 0;

  VoidCallback? callback;

  /// Getters
  bool get isLoading => _isLoading.value;

  bool get isEmailVerification => _isEmailVerification.value;

  String get email => _email.value;

  CountryCode get countryCode => _countryCode.value;

  String get phone => _phone.value;

  String get otp => _otp.join();

  /// Setters
  set isLoading(bool value) => _isLoading.value = value;

  set isEmailVerification(bool value) => _isEmailVerification.value = value;

  set email(String value) => _email.value = value;

  set countryCode(CountryCode value) => _countryCode.value = value;

  set phone(String value) => _phone.value = value;

  void onEmailChanged(String value) {
    email = value;
    update();
  }

  void onCountryCodeChanged(CountryCode value) {
    countryCode = value;
    update();
    AppUtility.log('Country Code: $countryCode');
  }

  void onPhoneChanged(String value) {
    phone = value;
    update();
  }

  void onOtpChanged(String value, int index) {
    _otp[index] = value;
    update();
  }

  void _clearFields() {
    email = '';
    phone = '';
    _otp.clear();
    resetTimer();
    update();
  }

  void startTimer() {
    resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      resendTimerSec++;
      update();
      if (resendTimerSec > 59) {
        resendTimerSec = 0;
        resendTimerMin++;
        update();
      }
      if (timer.tick == 120) {
        resendTimerSec = 0;
        resendTimerMin = 0;
        timer.cancel();
        update();
      }
    });
  }

  void resetTimer() {
    resendTimerSec = 0;
    resendTimerMin = 0;
    resendTimer?.cancel();
  }

  @override
  onInit() {
    super.onInit();
    callback = Get.arguments['callback'];
  }

  Future<void> _sendOtpToEmail({required bool isResend}) async {
    if (_email.value.isEmpty) {
      AppUtility.showSnackBar(
        StringValues.enterEmail,
        StringValues.warning,
      );
      return;
    }

    final body = {'email': email};

    AppUtility.showLoadingDialog();
    isEmailVerification = true;
    _isLoading.value = true;
    update();

    try {
      final response = await _apiProvider.sendOtpToEmail(body);

      if (response.isSuccessful) {
        final decodedData = response.data;
        AppUtility.closeDialog();
        _isLoading.value = false;
        update();

        if (!isResend) {
          RouteManagement.goToBack();
          RouteManagement.goToVerifyOtpView();
        }

        startTimer();

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
      AppUtility.showSnackBar('Error: ${exc.toString()}', StringValues.error);
    }
  }

  Future<void> _verifyOtpFromEmail() async {
    if (_otp.isEmpty || _otp.length < 6) {
      AppUtility.showSnackBar(
        StringValues.enterOtp,
        StringValues.warning,
      );
      return;
    }

    final body = {
      'email': _email.value.trim(),
      'otp': _otp.join(),
    };

    AppUtility.showLoadingDialog();
    _isLoading.value = true;
    update();

    try {
      final response = await _apiProvider.verifyOtpFromEmail(body);

      if (response.isSuccessful) {
        final decodedData = response.data;
        _clearFields();
        AppUtility.closeDialog();
        _isLoading.value = false;
        update();

        RouteManagement.goToBack();

        if (callback != null) {
          callback!.call();
        }

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
      AppUtility.showSnackBar('Error: ${exc.toString()}', StringValues.error);
    }
  }

  Future<void> _sendOtpToPhone({required bool isResend}) async {
    if (_phone.value.isEmpty) {
      AppUtility.showSnackBar(
        StringValues.enterPhoneNo,
        StringValues.warning,
      );
      return;
    }

    final body = {
      'phone': _phone.value.trim(),
      'countryCode': _countryCode.value.dialCode,
    };

    AppUtility.showLoadingDialog();
    isEmailVerification = false;
    _isLoading.value = true;
    update();

    try {
      final response = await _apiProvider.sendOtpToPhone(body);

      if (response.isSuccessful) {
        final decodedData = response.data;
        AppUtility.closeDialog();
        _isLoading.value = false;
        update();

        if (!isResend) {
          RouteManagement.goToBack();
          RouteManagement.goToVerifyOtpView();
        }

        startTimer();

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
      AppUtility.showSnackBar('Error: ${exc.toString()}', StringValues.error);
    }
  }

  Future<void> _verifyOtpFromPhone() async {
    if (_otp.isEmpty || _otp.length < 6) {
      AppUtility.showSnackBar(
        StringValues.enterOtp,
        StringValues.warning,
      );
      return;
    }

    final body = {
      'phone': _phone.value.trim(),
      'otp': _otp.join(),
    };

    AppUtility.showLoadingDialog();
    _isLoading.value = true;
    update();

    try {
      final response = await _apiProvider.verifyOtpFromPhone(body);

      if (response.isSuccessful) {
        final decodedData = response.data;
        _clearFields();
        AppUtility.closeDialog();
        _isLoading.value = false;
        update();

        RouteManagement.goToBack();

        if (callback != null) {
          callback!.call();
        }

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
      AppUtility.showSnackBar('Error: ${exc.toString()}', StringValues.error);
    }
  }

  Future<void> sendOtpToEmail() async {
    AppUtility.closeFocus();
    await _sendOtpToEmail(isResend: false);
  }

  Future<void> resendOtpToEmail() async {
    AppUtility.closeFocus();
    await _sendOtpToEmail(isResend: true);
  }

  Future<void> verifyOtpFromEmail() async {
    AppUtility.closeFocus();
    await _verifyOtpFromEmail();
  }

  Future<void> sendOtpToPhone() async {
    AppUtility.closeFocus();
    await _sendOtpToPhone(isResend: false);
  }

  Future<void> resendOtpToPhone() async {
    AppUtility.closeFocus();
    await _sendOtpToPhone(isResend: true);
  }

  Future<void> verifyOtpFromPhone() async {
    AppUtility.closeFocus();
    await _verifyOtpFromPhone();
  }
}
