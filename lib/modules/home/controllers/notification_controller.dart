import 'dart:async';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_app/apis/models/entities/notification.dart';
import 'package:social_media_app/apis/models/responses/notification_response.dart';
import 'package:social_media_app/apis/providers/api_provider.dart';
import 'package:social_media_app/app_services/auth_service.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/modules/follow_request/follow_request_controller.dart';
import 'package:social_media_app/modules/home/controllers/post_controller.dart';
import 'package:social_media_app/modules/home/controllers/profile_controller.dart';
import 'package:social_media_app/routes/route_management.dart';
import 'package:social_media_app/services/hive_service.dart';
import 'package:social_media_app/utils/utility.dart';

class NotificationController extends GetxController {
  static NotificationController get find => Get.find();

  final _auth = AuthService.find;
  final profile = ProfileController.find;
  final _apiProvider = ApiProvider(http.Client());
  final followRequestController = FollowRequestController.find;

  final _isLoading = false.obs;
  final _isMoreLoading = false.obs;
  final _notificationData = const NotificationResponse().obs;
  final List<NotificationModel> _notificationList = [];

  /// Getters
  bool get isLoading => _isLoading.value;

  bool get isMoreLoading => _isMoreLoading.value;

  NotificationResponse? get notificationData => _notificationData.value;

  List<NotificationModel> get notificationList => _notificationList;

  /// Setters
  set setNotificationData(NotificationResponse value) =>
      _notificationData.value = value;

  Future<void> _loadLocalNotification() async {
    var isExists =
        await HiveService.hasLength<NotificationModel>('notifications');

    if (isExists) {
      var data = await HiveService.getAll<NotificationModel>('notifications');
      data.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      _notificationList.clear();
      _notificationList.addAll(data.toList());
    }
  }

  Future<void> _getData() async {
    await Future.wait([
      _fetchNotifications(),
      followRequestController.fetchFollowRequests(),
    ]);
  }

  Future<void> _fetchNotifications() async {
    _isLoading.value = true;
    update();

    try {
      final response = await _apiProvider.getNotifications(_auth.token);

      if (response.isSuccessful) {
        final decodedData = response.data;
        setNotificationData = NotificationResponse.fromJson(decodedData);
        _notificationList.clear();
        _notificationList.addAll(_notificationData.value.results!);
        for (var item in _notificationData.value.results!) {
          await HiveService.put<NotificationModel>(
            'notifications',
            item.id,
            item,
          );
        }
        await followRequestController.fetchFollowRequests();
        _isLoading.value = false;
        update();
      } else {
        final decodedData = response.data;
        _isLoading.value = false;
        update();
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } catch (exc) {
      _isLoading.value = false;
      update();
      AppUtility.showSnackBar('Error: ${exc.toString()}', StringValues.error);
    }
  }

  Future<void> _loadMore({int? page}) async {
    _isMoreLoading.value = true;
    update();

    try {
      final response =
          await _apiProvider.getNotifications(_auth.token, page: page);

      if (response.isSuccessful) {
        final decodedData = response.data;
        setNotificationData = NotificationResponse.fromJson(decodedData);
        _notificationList.addAll(_notificationData.value.results!);
        for (var item in _notificationData.value.results!) {
          await HiveService.put<NotificationModel>(
            'notifications',
            item.id,
            item,
          );
        }
        _isMoreLoading.value = false;
        update();
      } else {
        final decodedData = response.data;
        _isMoreLoading.value = false;
        update();
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } catch (exc) {
      _isMoreLoading.value = false;
      update();
      AppUtility.showSnackBar('Error: ${exc.toString()}', StringValues.error);
    }
  }

  Future<void> _markNotificationRead(String id) async {
    var isPresent = _notificationList.any((element) => element.id == id);

    if (isPresent == true) {
      _notificationList.firstWhere((element) => element.id == id).isRead = true;
      update();
    }

    try {
      final response = await _apiProvider.markNotificationRead(_auth.token, id);

      if (response.isSuccessful) {
        final decodedData = response.data;
        AppUtility.log(decodedData);
      } else {
        final decodedData = response.data;
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } catch (exc) {
      update();
      AppUtility.showSnackBar('Error: ${exc.toString()}', StringValues.error);
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

  Future<void> _deleteNotification(String id) async {
    var isPresent = _notificationList.any((element) => element.id == id);

    if (isPresent == true) {
      _notificationList.removeWhere((element) => element.id == id);
      update();
    }

    try {
      final response = await _apiProvider.deleteNotification(_auth.token, id);

      if (response.isSuccessful) {
        final decodedData = response.data;
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.success,
          duration: 2,
        );
      } else {
        final decodedData = response.data;
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } catch (exc) {
      update();
      AppUtility.showSnackBar('Error: ${exc.toString()}', StringValues.error);
    }
  }

  Future<void> loadLocalNotification() async => await _loadLocalNotification();

  Future<void> getNotifications() async => await _fetchNotifications();

  Future<void> markNotificationRead(String id) async =>
      await _markNotificationRead(id);

  Future<void> deleteNotification(String id) async =>
      await _deleteNotification(id);

  Future<void> loadMore() async =>
      await _loadMore(page: _notificationData.value.currentPage! + 1);

  Future<void> getData() async => await _getData();
}
