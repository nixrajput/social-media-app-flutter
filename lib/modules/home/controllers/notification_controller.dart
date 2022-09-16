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
import 'package:social_media_app/modules/follow_request/follow_request_controller.dart';
import 'package:social_media_app/modules/home/controllers/post_controller.dart';
import 'package:social_media_app/modules/home/controllers/profile_controller.dart';
import 'package:social_media_app/routes/route_management.dart';
import 'package:social_media_app/utils/utility.dart';

class NotificationController extends GetxController {
  static NotificationController get find => Get.find();

  final _auth = AuthService.find;
  final profile = ProfileController.find;
  final _apiProvider = ApiProvider(http.Client());

  final _isLoadingNotification = false.obs;
  final _isMoreLoadingNotification = false.obs;
  final _notificationData = const NotificationResponse().obs;
  final List<ApiNotification> _notificationList = [];

  /// Getters
  bool get isLoading => _isLoadingNotification.value;

  bool get isMoreLoading => _isMoreLoadingNotification.value;

  NotificationResponse? get notificationData => _notificationData.value;

  List<ApiNotification> get notificationList => _notificationList;

  /// Setters
  set setNotificationData(NotificationResponse value) =>
      _notificationData.value = value;

  @override
  void onInit() {
    super.onInit();
    _getData();
  }

  void _getData() async {
    await Future.delayed(const Duration(seconds: 1), () async {
      await _fetchNotifications();
      await FollowRequestController.find.fetchFollowRequests();
    });
  }

  Future<void> _fetchNotifications() async {
    AppUtility.printLog("Fetching Notifications Request");
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
        AppUtility.printLog("Fetching Notifications Success");
      } else {
        _isLoadingNotification.value = false;
        update();
        AppUtility.printLog("Fetching Notifications Error");
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } on SocketException {
      _isLoadingNotification.value = false;
      update();
      AppUtility.printLog("Fetching Notifications Error");
      AppUtility.printLog(StringValues.internetConnError);
      AppUtility.showSnackBar(
          StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      _isLoadingNotification.value = false;
      update();
      AppUtility.printLog("Fetching Notifications Error");
      AppUtility.printLog(StringValues.connTimedOut);
      AppUtility.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      _isLoadingNotification.value = false;
      update();
      AppUtility.printLog("Fetching Notifications Error");
      AppUtility.printLog(StringValues.formatExcError);
      AppUtility.printLog(e);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      _isLoadingNotification.value = false;
      update();
      AppUtility.printLog("Fetching Notifications Error");
      AppUtility.printLog(StringValues.errorOccurred);
      AppUtility.printLog(exc);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    }
  }

  Future<void> _loadMore({int? page}) async {
    AppUtility.printLog("Fetching More Notifications Request");
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
        AppUtility.printLog("Fetching More Notifications Success");
      } else {
        _isMoreLoadingNotification.value = false;
        update();
        AppUtility.printLog("Fetching More Notifications Error");
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } on SocketException {
      _isMoreLoadingNotification.value = false;
      update();
      AppUtility.printLog("Fetching More Notifications Error");
      AppUtility.printLog(StringValues.internetConnError);
      AppUtility.showSnackBar(
          StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      _isMoreLoadingNotification.value = false;
      update();
      AppUtility.printLog("Fetching More Notifications Error");
      AppUtility.printLog(StringValues.connTimedOut);
      AppUtility.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      _isMoreLoadingNotification.value = false;
      update();
      AppUtility.printLog("Fetching More Notifications Error");
      AppUtility.printLog(StringValues.formatExcError);
      AppUtility.printLog(e);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      _isMoreLoadingNotification.value = false;
      update();
      AppUtility.printLog("Fetching More Notifications Error");
      AppUtility.printLog(StringValues.errorOccurred);
      AppUtility.printLog(exc);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    }
  }

  Future<void> _markNotificationRead(String id) async {
    AppUtility.printLog("Mark Notification Request");

    var isPresent = _notificationList.any((element) => element.id == id);

    if (isPresent == true) {
      _notificationList.firstWhere((element) => element.id == id).isRead = true;
      update();
    }

    try {
      final response = await _apiProvider.markNotificationRead(_auth.token, id);

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        AppUtility.printLog(decodedData);
        AppUtility.printLog("Mark Notification Success");
      } else {
        AppUtility.printLog("Mark Notification Error");
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } on SocketException {
      AppUtility.printLog("Mark Notification Error");
      AppUtility.printLog(StringValues.internetConnError);
      AppUtility.showSnackBar(
          StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      AppUtility.printLog("Mark Notification Error");
      AppUtility.printLog(StringValues.connTimedOut);
      AppUtility.printLog(StringValues.connTimedOut);
      AppUtility.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      AppUtility.printLog("Mark Notification Error");
      AppUtility.printLog(StringValues.formatExcError);
      AppUtility.printLog(e);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      AppUtility.printLog("Mark Notification Error");
      AppUtility.printLog(StringValues.errorOccurred);
      AppUtility.printLog(exc);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    }
  }

  void goToPost(String postId) async {
    var postFound =
        PostController.find.postList.any((element) => element.id == postId);

    if (postFound) {
      var post = PostController.find.postList
          .firstWhere((element) => element.id == postId);
      RouteManagement.goToPostDetailsView(postId, post);
    } else {
      RouteManagement.goToPostDetailsView(postId, null);
    }
  }

  Future<void> getNotifications() async => await _fetchNotifications();

  Future<void> markNotificationRead(String id) async =>
      await _markNotificationRead(id);

  Future<void> loadMore() async =>
      await _loadMore(page: _notificationData.value.currentPage! + 1);
}
