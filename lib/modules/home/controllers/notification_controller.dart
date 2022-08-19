import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_app/apis/models/responses/notification_response.dart';
import 'package:social_media_app/apis/providers/api_provider.dart';
import 'package:social_media_app/apis/services/auth_service.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/helpers/utils.dart';

class NotificationController extends GetxController {
  static NotificationController get find => Get.find();

  final _auth = AuthService.find;
  final _apiProvider = ApiProvider(http.Client());

  final _isLoading = false.obs;
  final _notifications = const NotificationResponse().obs;

  bool get isLoading => _isLoading.value;

  NotificationResponse? get notifications => _notifications.value;

  set setNotificationData(NotificationResponse value) =>
      _notifications.value = value;

  Future<void> _fetchNotifications() async {
    AppUtils.printLog("Fetching Notifications Request...");
    _isLoading.value = true;
    update();

    try {
      final response = await _apiProvider.getNotifications(_auth.token);

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        setNotificationData = NotificationResponse.fromJson(decodedData);
        _isLoading.value = false;
        update();
      } else {
        _isLoading.value = false;
        update();
        AppUtils.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } on SocketException {
      _isLoading.value = false;
      update();
      AppUtils.printLog(StringValues.internetConnError);
      AppUtils.showSnackBar(StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      _isLoading.value = false;
      update();
      AppUtils.printLog(StringValues.connTimedOut);
      AppUtils.printLog(StringValues.connTimedOut);
      AppUtils.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      _isLoading.value = false;
      update();
      AppUtils.printLog(StringValues.formatExcError);
      AppUtils.printLog(e);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      _isLoading.value = false;
      update();
      AppUtils.printLog(StringValues.errorOccurred);
      AppUtils.printLog(exc);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    }
  }

  Future<void> getNotifications() async => await _fetchNotifications();

  @override
  void onInit() {
    _fetchNotifications();
    super.onInit();
  }
}
