import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_app/common/overlay.dart';
import 'package:social_media_app/constants/secrets.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/urls.dart';
import 'package:social_media_app/helpers/utils.dart';
import 'package:social_media_app/models/login_model.dart';
import 'package:social_media_app/models/user_model.dart';
import 'package:social_media_app/routes/route_management.dart';

class AuthController extends GetxController {
  static AuthController get find => Get.find();

  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  final fNameTextController = TextEditingController();
  final lNameTextController = TextEditingController();
  final unameTextController = TextEditingController();
  final confirmPasswordTextController = TextEditingController();

  final otpTextController = TextEditingController();

  final FocusScopeNode focusNode = FocusScopeNode();

  final _token = ''.obs;
  final _isLoading = false.obs;
  final Rx<LoginModel> _loginModel = LoginModel().obs;
  final Rx<String> _expiresAt = ''.obs;
  final Rx<UserModel> _userModel = UserModel().obs;

  bool get isLoading => _isLoading.value;

  LoginModel get loginModel => _loginModel.value;

  UserModel get userModel => _userModel.value;

  String get token => _token.value;

  Stream<String> get tokenStream => _validateToken();

  @override
  onReady() {
    ever(_token, _autoLogin);
    _token.bindStream(tokenStream);
    super.onReady();
  }

  @override
  void onClose() {
    _clearLoginTextControllers();
    _clearRegisterTextControllers();
    _clearForgotPasswordTextControllers();
    _clearResetPasswordTextControllers();
    super.onClose();
  }

  void _clearLoginTextControllers() {
    emailTextController.clear();
    passwordTextController.clear();
  }

  void _clearRegisterTextControllers() {
    fNameTextController.clear();
    lNameTextController.clear();
    emailTextController.clear();
    unameTextController.clear();
    passwordTextController.clear();
    confirmPasswordTextController.clear();
  }

  void _clearForgotPasswordTextControllers() {
    emailTextController.clear();
  }

  void _clearResetPasswordTextControllers() {
    otpTextController.clear();
    passwordTextController.clear();
    confirmPasswordTextController.clear();
  }

  Stream<String> _validateToken() async* {
    String _token = '';
    final decodedData = await _readLoginDataFromLocalStorage();
    if (decodedData != null) {
      _expiresAt.value = decodedData[StringValues.expiresAt];
      _token = decodedData[StringValues.token];
    }
    _autoLogout();
    yield _token;
  }

  void _autoLogin(_token) async {
    if (_token.isEmpty) {
      RouteManagement.goToLoginView();
    } else {
      await _getProfileDetails();
      RouteManagement.goToHomeView();
    }
  }

  Future<void> _saveLoginDataToLocalStorage() async {
    var _token = _loginModel.value.token;
    var _expiresAt = _loginModel.value.expiresAt;

    if (_token!.isNotEmpty && _expiresAt!.isNotEmpty) {
      final loginData = GetStorage();
      final data = jsonEncode({
        StringValues.token: _token,
        StringValues.expiresAt: _expiresAt,
      });

      loginData.write(StringValues.loginData, data);
      this._token.value = _token;
      this._expiresAt.value = _expiresAt;
    }
  }

  Future<dynamic> _readLoginDataFromLocalStorage() async {
    final loginData = GetStorage();

    if (loginData.hasData(StringValues.loginData)) {
      final data = await loginData.read(StringValues.loginData);
      var decodedData = jsonDecode(data) as Map<String, dynamic>;
      return decodedData;
    }
    return null;
  }

  Future<void> clearLoginDataFromLocalStorage() async {
    final loginData = GetStorage();
    loginData.remove(StringValues.loginData);
  }

  Future<void> _logout() async {
    _isLoading.value = true;
    update();
    _token.value = '';
    _expiresAt.value = '';
    _userModel.value = UserModel();
    await clearLoginDataFromLocalStorage();
    AppUtils.showSnackBar(
      StringValues.logoutSuccessful,
      StringValues.success,
    );
    _isLoading.value = false;
    update();
  }

  void _autoLogout() async {
    if (_expiresAt.isNotEmpty) {
      var _currentTimestamp =
          (DateTime.now().millisecondsSinceEpoch / 1000).round();
      if (int.parse(_expiresAt.value) < _currentTimestamp) {
        await _logout();
      }
    }
  }

  Future<void> _login(String email, String password) async {
    if (email.isEmpty) {
      AppUtils.showSnackBar(
        StringValues.enterEmail,
        StringValues.warning,
      );
      return;
    }
    if (password.isEmpty) {
      AppUtils.showSnackBar(
        StringValues.enterPassword,
        StringValues.warning,
      );
      return;
    }

    _isLoading.value = true;
    AppOverlay.showLoadingIndicator();
    update();

    try {
      final response = await http.post(
        Uri.parse(AppUrls.baseUrl + AppUrls.loginEndpoint),
        headers: {
          'content-type': 'application/json',
          'x-rapidapi-host': SecretValues.rapidApiHost,
          'x-rapidapi-key': SecretValues.rapidApiKey,
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        _loginModel.value = LoginModel.fromJson(data);
        await _saveLoginDataToLocalStorage();
        _autoLogout();
        await _getProfileDetails();
        _clearLoginTextControllers();
        AppOverlay.hideLoadingIndicator();
        _isLoading.value = false;
        update();
        AppUtils.showSnackBar(
          StringValues.loginSuccessful,
          StringValues.success,
        );
        RouteManagement.goToHomeView();
      } else {
        AppOverlay.hideLoadingIndicator();
        _isLoading.value = false;
        update();
        AppUtils.showSnackBar(
          data[StringValues.message],
          StringValues.error,
        );
      }
    } catch (err) {
      AppOverlay.hideLoadingIndicator();
      _isLoading.value = false;
      update();
      debugPrint(err.toString());
      AppUtils.showSnackBar(
        '${StringValues.errorOccurred}: ${err.toString()}',
        StringValues.error,
      );
    }
  }

  Future<void> _getProfileDetails() async {
    _isLoading.value = true;
    update();

    try {
      final response = await http.get(
        Uri.parse(AppUrls.baseUrl + AppUrls.profileDetailsEndpoint),
        headers: {
          'content-type': 'application/json',
          'x-rapidapi-host': SecretValues.rapidApiHost,
          'x-rapidapi-key': SecretValues.rapidApiKey,
          'authorization': 'Bearer ${_token.value}',
        },
      );

      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        _userModel.value = UserModel.fromJson(data);
        _isLoading.value = false;
        // AppUtils.showSnackBar(
        //   'User data fetched',
        //   StringValues.success,
        // );
        update();
      } else {
        _isLoading.value = false;
        update();
        AppUtils.showSnackBar(
          data[StringValues.message],
          StringValues.error,
        );
      }
    } catch (err) {
      _isLoading.value = false;
      update();
      debugPrint(err.toString());
      AppUtils.showSnackBar(
        '${StringValues.errorOccurred}: ${err.toString()}',
        StringValues.error,
      );
    }
  }

  Future<void> _register(
    String fName,
    String lName,
    String email,
    String uname,
    String password,
    String confPassword,
  ) async {
    if (fName.isEmpty) {
      AppUtils.showSnackBar(
        StringValues.enterFirstName,
        StringValues.warning,
      );
      return;
    }
    if (lName.isEmpty) {
      AppUtils.showSnackBar(
        StringValues.enterLastName,
        StringValues.warning,
      );
      return;
    }
    if (email.isEmpty) {
      AppUtils.showSnackBar(
        StringValues.enterEmail,
        StringValues.warning,
      );
      return;
    }
    if (uname.isEmpty) {
      AppUtils.showSnackBar(
        StringValues.enterUsername,
        StringValues.warning,
      );
      return;
    }
    if (password.isEmpty) {
      AppUtils.showSnackBar(
        StringValues.enterPassword,
        StringValues.warning,
      );
      return;
    }
    if (confPassword.isEmpty) {
      AppUtils.showSnackBar(
        StringValues.enterConfirmPassword,
        StringValues.warning,
      );
      return;
    }

    AppOverlay.showLoadingIndicator();
    _isLoading.value = true;
    update();

    try {
      final response = await http.post(
        Uri.parse(AppUrls.baseUrl + AppUrls.registerEndpoint),
        headers: {
          'content-type': 'application/json',
          'x-rapidapi-host': SecretValues.rapidApiHost,
          'x-rapidapi-key': SecretValues.rapidApiKey,
        },
        body: jsonEncode({
          'fname': fName,
          'lname': lName,
          'email': email,
          'uname': uname,
          'password': password,
          'confirmPassword': confPassword,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 201) {
        _clearRegisterTextControllers();
        AppOverlay.hideLoadingIndicator();
        _isLoading.value = false;
        update();
        AppUtils.showSnackBar(
          StringValues.registrationSuccessful,
          StringValues.success,
        );
        RouteManagement.goToLoginView();
      } else {
        AppOverlay.hideLoadingIndicator();
        _isLoading.value = false;
        update();
        AppUtils.showSnackBar(
          data[StringValues.message],
          StringValues.error,
        );
      }
    } catch (err) {
      AppOverlay.hideLoadingIndicator();
      _isLoading.value = false;
      update();
      debugPrint(err.toString());
      AppUtils.showSnackBar(
        '${StringValues.errorOccurred}: ${err.toString()}',
        StringValues.error,
      );
    }
  }

  Future<void> _sendForgotPasswordOTP(String email) async {
    if (email.isEmpty) {
      AppUtils.showSnackBar(
        StringValues.enterEmail,
        StringValues.warning,
      );
      return;
    }

    AppOverlay.showLoadingIndicator();
    _isLoading.value = true;
    update();

    try {
      final response = await http.post(
        Uri.parse(AppUrls.baseUrl + AppUrls.forgotPasswordEndpoint),
        headers: {
          'content-type': 'application/json',
          'x-rapidapi-host': SecretValues.rapidApiHost,
          'x-rapidapi-key': SecretValues.rapidApiKey,
        },
        body: jsonEncode({
          'email': email,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        _clearForgotPasswordTextControllers();
        AppOverlay.hideLoadingIndicator();
        _isLoading.value = false;
        update();
        AppUtils.showSnackBar(
          StringValues.otpSendSuccessful,
          StringValues.success,
        );
        RouteManagement.goToResetPasswordView();
      } else {
        AppOverlay.hideLoadingIndicator();
        _isLoading.value = false;
        update();
        AppUtils.showSnackBar(
          data[StringValues.message],
          StringValues.error,
        );
      }
    } catch (err) {
      AppOverlay.hideLoadingIndicator();
      _isLoading.value = false;
      update();
      debugPrint(err.toString());
      AppUtils.showSnackBar(
        '${StringValues.errorOccurred}: ${err.toString()}',
        StringValues.error,
      );
    }
  }

  Future<void> _resetPassword(
    String otp,
    String newPassword,
    String confPassword,
  ) async {
    if (otp.isEmpty) {
      AppUtils.showSnackBar(
        StringValues.enterOtp,
        StringValues.warning,
      );
      return;
    }

    if (newPassword.isEmpty) {
      AppUtils.showSnackBar(
        StringValues.enterPassword,
        StringValues.warning,
      );
      return;
    }
    if (confPassword.isEmpty) {
      AppUtils.showSnackBar(
        StringValues.enterConfirmPassword,
        StringValues.warning,
      );
      return;
    }

    AppOverlay.showLoadingIndicator();
    _isLoading.value = true;
    update();

    try {
      final response = await http.put(
        Uri.parse(AppUrls.baseUrl + AppUrls.resetPasswordEndpoint),
        headers: {
          'content-type': 'application/json',
          'x-rapidapi-host': SecretValues.rapidApiHost,
          'x-rapidapi-key': SecretValues.rapidApiKey,
        },
        body: jsonEncode({
          'otp': otp,
          'newPassword': newPassword,
          'confirmPassword': confPassword,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        _clearResetPasswordTextControllers();
        AppOverlay.hideLoadingIndicator();
        _isLoading.value = false;
        update();
        AppUtils.showSnackBar(
          StringValues.passwordChangeSuccessful,
          StringValues.success,
        );
        RouteManagement.goToLoginView();
      } else {
        AppOverlay.hideLoadingIndicator();
        _isLoading.value = false;
        update();
        AppUtils.showSnackBar(
          data[StringValues.message],
          StringValues.error,
        );
      }
    } catch (err) {
      AppOverlay.hideLoadingIndicator();
      _isLoading.value = false;
      update();
      debugPrint(err.toString());
      AppUtils.showSnackBar(
        '${StringValues.errorOccurred}: ${err.toString()}',
        StringValues.error,
      );
    }
  }

  Future<void> login() async {
    _login(
      emailTextController.text.trim(),
      passwordTextController.text.trim(),
    );
  }

  Future<void> register() async {
    _register(
      fNameTextController.text.trim(),
      lNameTextController.text.trim(),
      emailTextController.text.trim(),
      unameTextController.text.trim(),
      passwordTextController.text.trim(),
      confirmPasswordTextController.text.trim(),
    );
  }

  Future<void> logout() async => await _logout();

  Future<void> getProfileDetails() async => await _getProfileDetails();

  Future<void> sendResetPasswordOTP() async {
    await _sendForgotPasswordOTP(emailTextController.text.trim());
  }

  Future<void> resetPassword() async {
    await _resetPassword(
      otpTextController.text.trim(),
      passwordTextController.text.trim(),
      confirmPasswordTextController.text.trim(),
    );
  }
}
