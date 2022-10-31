import 'dart:async';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_app/apis/models/entities/follow_request.dart';
import 'package:social_media_app/apis/models/responses/follow_request_response.dart';
import 'package:social_media_app/apis/providers/api_provider.dart';
import 'package:social_media_app/apis/services/auth_service.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/modules/home/controllers/profile_controller.dart';
import 'package:social_media_app/utils/utility.dart';

class FollowRequestController extends GetxController {
  static FollowRequestController get find => Get.find();

  final _auth = AuthService.find;
  final profile = ProfileController.find;
  final _apiProvider = ApiProvider(http.Client());

  final _isLoadingFollowRequest = false.obs;
  final _isMoreLoadingFollowRequest = false.obs;
  final _followRequestData = const FollowRequestResponse().obs;
  final List<FollowRequest> _followRequestList = [];

  /// Getters

  bool get isLoadingFollowRequest => _isLoadingFollowRequest.value;

  bool get isMoreLoadingFollowRequest => _isMoreLoadingFollowRequest.value;

  FollowRequestResponse? get followRequestData => _followRequestData.value;

  List<FollowRequest> get followRequestList => _followRequestList;

  /// Setters
  set setFollowRequestData(FollowRequestResponse value) =>
      _followRequestData.value = value;

  Future<void> _fetchFollowRequests() async {
    _isLoadingFollowRequest.value = true;
    update();

    try {
      final response = await _apiProvider.getFollowRequests(_auth.token);

      if (response.isSuccessful) {
        final decodedData = response.data;
        setFollowRequestData = FollowRequestResponse.fromJson(decodedData);
        _followRequestList.clear();
        _followRequestList.addAll(_followRequestData.value.results!);
        _isLoadingFollowRequest.value = false;
        update();
      } else {
        final decodedData = response.data;
        _isLoadingFollowRequest.value = false;
        update();
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } catch (exc) {
      _isLoadingFollowRequest.value = false;
      update();
      AppUtility.showSnackBar('Error: ${exc.toString()}', StringValues.error);
    }
  }

  Future<void> _loadMoreFollowRequests({int? page}) async {
    _isMoreLoadingFollowRequest.value = true;
    update();

    try {
      final response =
          await _apiProvider.getFollowRequests(_auth.token, page: page);

      if (response.isSuccessful) {
        final decodedData = response.data;
        setFollowRequestData = FollowRequestResponse.fromJson(decodedData);
        _followRequestList.addAll(_followRequestData.value.results!);
        _isMoreLoadingFollowRequest.value = false;
        update();
      } else {
        final decodedData = response.data;
        _isMoreLoadingFollowRequest.value = false;
        update();
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } catch (exc) {
      _isMoreLoadingFollowRequest.value = false;
      update();
      AppUtility.showSnackBar('Error: ${exc.toString()}', StringValues.error);
    }
  }

  Future<void> _acceptFollowRequest(String followRequestId) async {
    var isPresent =
        _followRequestList.any((element) => element.id == followRequestId);

    if (isPresent == true) {
      var item = _followRequestList
          .firstWhere((element) => element.id == followRequestId);
      _followRequestList.remove(item);
      update();
    }

    try {
      final response = await _apiProvider.acceptFollowRequest(
        _auth.token,
        followRequestId,
      );

      if (response.isSuccessful) {
        final decodedData = response.data;
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.success,
        );
        await profile.fetchProfileDetails(fetchPost: false);
      } else {
        final decodedData = response.data;
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } catch (exc) {
      AppUtility.showSnackBar('Error: ${exc.toString()}', StringValues.error);
    }
  }

  Future<void> _removeFollowRequest(String followRequestId) async {
    var isPresent =
        _followRequestList.any((element) => element.id == followRequestId);

    if (isPresent == true) {
      var item = _followRequestList
          .firstWhere((element) => element.id == followRequestId);
      _followRequestList.remove(item);
      update();
    }

    try {
      final response = await _apiProvider.acceptFollowRequest(
        _auth.token,
        followRequestId,
      );

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
      AppUtility.showSnackBar('Error: ${exc.toString()}', StringValues.error);
    }
  }

  Future<void> fetchFollowRequests() async => await _fetchFollowRequests();

  Future<void> loadMoreFollowRequests() async => await _loadMoreFollowRequests(
      page: _followRequestData.value.currentPage! + 1);

  Future<void> acceptFollowRequest(String notificationId) async =>
      await _acceptFollowRequest(notificationId);

  Future<void> removeFollowRequest(String notificationId) async =>
      await _removeFollowRequest(notificationId);
}
