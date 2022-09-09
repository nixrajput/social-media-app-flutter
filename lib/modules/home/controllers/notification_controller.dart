import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_app/apis/models/entities/notification.dart';
import 'package:social_media_app/apis/models/responses/notification_response.dart';
import 'package:social_media_app/apis/providers/api_provider.dart';
import 'package:social_media_app/apis/services/auth_service.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/helpers/utils.dart';
import 'package:social_media_app/modules/home/controllers/profile_controller.dart';

class NotificationController extends GetxController {
  static NotificationController get find => Get.find();

  final _auth = AuthService.find;
  final profile = ProfileController.find;
  final _apiProvider = ApiProvider(http.Client());

  final _isLoadingNotification = false.obs;
  final _isMoreLoadingNotification = false.obs;
  final _isLoadingFollowRequest = false.obs;
  final _isMoreLoadingFollowRequest = false.obs;
  final _notificationData = const NotificationResponse().obs;
  final _followRequestData = const NotificationResponse().obs;
  final List<ApiNotification> _notificationList = [];
  final List<ApiNotification> _followRequestList = [];

  /// Getters
  bool get isLoading => _isLoadingNotification.value;

  bool get isMoreLoading => _isMoreLoadingNotification.value;

  bool get isLoadingFollowRequest => _isLoadingFollowRequest.value;

  bool get isMoreLoadingFollowRequest => _isMoreLoadingFollowRequest.value;

  NotificationResponse? get notificationData => _notificationData.value;

  List<ApiNotification> get notificationList => _notificationList;

  List<ApiNotification> get followRequestList => _followRequestList;

  /// Setters
  set setNotificationData(NotificationResponse value) =>
      _notificationData.value = value;

  set setFollowRequestData(NotificationResponse value) =>
      _followRequestData.value = value;

  Future<void> _fetchNotifications() async {
    AppUtils.printLog("Fetching Notifications Request");
    _isLoadingNotification.value = true;
    update();

    try {
      final response = await _apiProvider.getNotifications(_auth.token);

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        setNotificationData = NotificationResponse.fromJson(decodedData);
        _notificationList.clear();
        _notificationList.addAll(_notificationData.value.results!);
        _isLoadingNotification.value = false;
        update();
        AppUtils.printLog("Fetching Notifications Success");
      } else {
        _isLoadingNotification.value = false;
        update();
        AppUtils.printLog("Fetching Notifications Error");
        AppUtils.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } on SocketException {
      _isLoadingNotification.value = false;
      update();
      AppUtils.printLog("Fetching Notifications Error");
      AppUtils.printLog(StringValues.internetConnError);
      AppUtils.showSnackBar(StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      _isLoadingNotification.value = false;
      update();
      AppUtils.printLog("Fetching Notifications Error");
      AppUtils.printLog(StringValues.connTimedOut);
      AppUtils.printLog(StringValues.connTimedOut);
      AppUtils.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      _isLoadingNotification.value = false;
      update();
      AppUtils.printLog("Fetching Notifications Error");
      AppUtils.printLog(StringValues.formatExcError);
      AppUtils.printLog(e);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      _isLoadingNotification.value = false;
      update();
      AppUtils.printLog("Fetching Notifications Error");
      AppUtils.printLog(StringValues.errorOccurred);
      AppUtils.printLog(exc);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    }
  }

  Future<void> _loadMore({int? page}) async {
    AppUtils.printLog("Fetching More Notifications Request");
    _isMoreLoadingNotification.value = true;
    update();

    try {
      final response =
          await _apiProvider.getNotifications(_auth.token, page: page);

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        setNotificationData = NotificationResponse.fromJson(decodedData);
        _notificationList.addAll(_notificationData.value.results!);
        _isMoreLoadingNotification.value = false;
        update();
        AppUtils.printLog("Fetching More Notifications Success");
      } else {
        _isMoreLoadingNotification.value = false;
        update();
        AppUtils.printLog("Fetching More Notifications Error");
        AppUtils.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } on SocketException {
      _isMoreLoadingNotification.value = false;
      update();
      AppUtils.printLog("Fetching More Notifications Error");
      AppUtils.printLog(StringValues.internetConnError);
      AppUtils.showSnackBar(StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      _isMoreLoadingNotification.value = false;
      update();
      AppUtils.printLog("Fetching More Notifications Error");
      AppUtils.printLog(StringValues.connTimedOut);
      AppUtils.printLog(StringValues.connTimedOut);
      AppUtils.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      _isMoreLoadingNotification.value = false;
      update();
      AppUtils.printLog("Fetching More Notifications Error");
      AppUtils.printLog(StringValues.formatExcError);
      AppUtils.printLog(e);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      _isMoreLoadingNotification.value = false;
      update();
      AppUtils.printLog("Fetching More Notifications Error");
      AppUtils.printLog(StringValues.errorOccurred);
      AppUtils.printLog(exc);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    }
  }

  Future<void> _fetchFollowRequests() async {
    AppUtils.printLog("Fetching FollowRequest Request");
    _isLoadingFollowRequest.value = true;
    update();

    try {
      final response = await _apiProvider.getNotifications(_auth.token);

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        setFollowRequestData = NotificationResponse.fromJson(decodedData);
        _followRequestList.clear();
        _followRequestList.addAll(_followRequestData.value.results!);
        _isLoadingFollowRequest.value = false;
        update();
        AppUtils.printLog("Fetching FollowRequest Success");
      } else {
        _isLoadingFollowRequest.value = false;
        update();
        AppUtils.printLog("Fetching FollowRequest Error");
        AppUtils.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } on SocketException {
      _isLoadingFollowRequest.value = false;
      update();
      AppUtils.printLog("Fetching FollowRequest Error");
      AppUtils.printLog(StringValues.internetConnError);
      AppUtils.showSnackBar(StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      _isLoadingFollowRequest.value = false;
      update();
      AppUtils.printLog("Fetching FollowRequest Error");
      AppUtils.printLog(StringValues.connTimedOut);
      AppUtils.printLog(StringValues.connTimedOut);
      AppUtils.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      _isLoadingFollowRequest.value = false;
      update();
      AppUtils.printLog("Fetching FollowRequest Error");
      AppUtils.printLog(StringValues.formatExcError);
      AppUtils.printLog(e);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      _isLoadingFollowRequest.value = false;
      update();
      AppUtils.printLog("Fetching FollowRequest Error");
      AppUtils.printLog(StringValues.errorOccurred);
      AppUtils.printLog(exc);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    }
  }

  Future<void> _loadMoreFollowRequests({int? page}) async {
    AppUtils.printLog("Fetching More FollowRequest Request");
    _isMoreLoadingFollowRequest.value = true;
    update();

    try {
      final response =
          await _apiProvider.getFollowRequests(_auth.token, page: page);

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        setFollowRequestData = NotificationResponse.fromJson(decodedData);
        _followRequestList.addAll(_followRequestData.value.results!);
        _isMoreLoadingFollowRequest.value = false;
        update();
        AppUtils.printLog("Fetching More FollowRequest Success");
      } else {
        _isMoreLoadingFollowRequest.value = false;
        update();
        AppUtils.printLog("Fetching More FollowRequest Error");
        AppUtils.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } on SocketException {
      _isMoreLoadingFollowRequest.value = false;
      update();
      AppUtils.printLog("Fetching More FollowRequest Error");
      AppUtils.printLog(StringValues.internetConnError);
      AppUtils.showSnackBar(StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      _isMoreLoadingFollowRequest.value = false;
      update();
      AppUtils.printLog("Fetching More FollowRequest Error");
      AppUtils.printLog(StringValues.connTimedOut);
      AppUtils.printLog(StringValues.connTimedOut);
      AppUtils.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      _isMoreLoadingFollowRequest.value = false;
      update();
      AppUtils.printLog("Fetching More FollowRequest Error");
      AppUtils.printLog(StringValues.formatExcError);
      AppUtils.printLog(e);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      _isMoreLoadingFollowRequest.value = false;
      update();
      AppUtils.printLog("Fetching More FollowRequest Error");
      AppUtils.printLog(StringValues.errorOccurred);
      AppUtils.printLog(exc);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    }
  }

  Future<void> _markNotificationRead(String id) async {
    AppUtils.printLog("Mark Notification Request");

    var isPresent = _notificationList.any((element) => element.id == id);

    if (isPresent == true) {
      _notificationList.firstWhere((element) => element.id == id).isRead = true;
      update();
    }

    try {
      final response = await _apiProvider.markNotificationRead(_auth.token, id);

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        AppUtils.printLog(decodedData);
        AppUtils.printLog("Mark Notification Success");
      } else {
        AppUtils.printLog("Mark Notification Error");
        AppUtils.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } on SocketException {
      AppUtils.printLog("Mark Notification Error");
      AppUtils.printLog(StringValues.internetConnError);
      AppUtils.showSnackBar(StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      AppUtils.printLog("Mark Notification Error");
      AppUtils.printLog(StringValues.connTimedOut);
      AppUtils.printLog(StringValues.connTimedOut);
      AppUtils.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      AppUtils.printLog("Mark Notification Error");
      AppUtils.printLog(StringValues.formatExcError);
      AppUtils.printLog(e);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      AppUtils.printLog("Mark Notification Error");
      AppUtils.printLog(StringValues.errorOccurred);
      AppUtils.printLog(exc);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    }
  }

  Future<void> _acceptFollowRequest(String notificationId) async {
    AppUtils.printLog("Accept FollowRequest Request");

    var isPresent = _notificationList.any((element) =>
        element.id == notificationId && element.type == 'followRequest');

    if (isPresent == true) {
      _notificationList.firstWhere((element) => element.id == notificationId)
        ..body = 'started following you'
        ..isRead = true
        ..type = 'followRequestAccepted';
      update();
    }

    try {
      final response = await _apiProvider.acceptFollowRequest(
        _auth.token,
        notificationId,
      );

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        await profile.fetchProfileDetails(fetchPost: false);
        AppUtils.printLog("Accept FollowRequest Success");
      } else {
        AppUtils.printLog("Accept FollowRequest Error");
        AppUtils.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } on SocketException {
      AppUtils.printLog("Accept FollowRequest Error");
      AppUtils.printLog(StringValues.internetConnError);
      AppUtils.showSnackBar(StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      AppUtils.printLog("Accept FollowRequest Error");
      AppUtils.printLog(StringValues.connTimedOut);
      AppUtils.printLog(StringValues.connTimedOut);
      AppUtils.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      AppUtils.printLog("Accept FollowRequest Error");
      AppUtils.printLog(StringValues.formatExcError);
      AppUtils.printLog(e);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      AppUtils.printLog("Accept FollowRequest Error");
      AppUtils.printLog(StringValues.errorOccurred);
      AppUtils.printLog(exc);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    }
  }

  Future<void> _removeFollowRequest(String notificationId) async {
    AppUtils.printLog("Accept FollowRequest Request");

    var isPresent = _notificationList.any((element) =>
        element.id == notificationId && element.type == 'followRequest');

    if (isPresent == true) {
      _notificationList.removeWhere((element) => element.id == notificationId);
      update();
    }

    try {
      final response = await _apiProvider.acceptFollowRequest(
        _auth.token,
        notificationId,
      );

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        AppUtils.printLog(decodedData);
        AppUtils.printLog("Accept FollowRequest Success");
      } else {
        AppUtils.printLog("Accept FollowRequest Error");
        AppUtils.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } on SocketException {
      AppUtils.printLog("Accept FollowRequest Error");
      AppUtils.printLog(StringValues.internetConnError);
      AppUtils.showSnackBar(StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      AppUtils.printLog("Accept FollowRequest Error");
      AppUtils.printLog(StringValues.connTimedOut);
      AppUtils.printLog(StringValues.connTimedOut);
      AppUtils.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      AppUtils.printLog("Accept FollowRequest Error");
      AppUtils.printLog(StringValues.formatExcError);
      AppUtils.printLog(e);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      AppUtils.printLog("Accept FollowRequest Error");
      AppUtils.printLog(StringValues.errorOccurred);
      AppUtils.printLog(exc);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    }
  }

  Future<void> getNotifications() async => await _fetchNotifications();

  Future<void> markNotificationRead(String id) async =>
      await _markNotificationRead(id);

  Future<void> loadMore() async =>
      await _loadMore(page: _notificationData.value.currentPage! + 1);

  Future<void> fetchFollowRequests() async => await _fetchFollowRequests();

  Future<void> loadMoreFollowRequests() async => await _loadMoreFollowRequests(
      page: _followRequestData.value.currentPage! + 1);

  Future<void> acceptFollowRequest(String notificationId) async =>
      await _acceptFollowRequest(notificationId);

  Future<void> removeFollowRequest(String notificationId) async =>
      await _removeFollowRequest(notificationId);

  @override
  void onInit() {
    _fetchNotifications();
    _fetchFollowRequests();
    super.onInit();
  }
}
