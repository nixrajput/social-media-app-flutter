import 'dart:async';
import 'dart:convert';
import 'dart:io';

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
    AppUtility.printLog("Fetching FollowRequest Request");
    _isLoadingFollowRequest.value = true;
    update();

    try {
      final response = await _apiProvider.getFollowRequests(_auth.token);

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        setFollowRequestData = FollowRequestResponse.fromJson(decodedData);
        _followRequestList.clear();
        _followRequestList.addAll(_followRequestData.value.results!);
        _isLoadingFollowRequest.value = false;
        update();
        AppUtility.printLog("Fetching FollowRequest Success");
      } else {
        _isLoadingFollowRequest.value = false;
        update();
        AppUtility.printLog("Fetching FollowRequest Error");
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } on SocketException {
      _isLoadingFollowRequest.value = false;
      update();
      AppUtility.printLog("Fetching FollowRequest Error");
      AppUtility.printLog(StringValues.internetConnError);
      AppUtility.showSnackBar(
          StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      _isLoadingFollowRequest.value = false;
      update();
      AppUtility.printLog("Fetching FollowRequest Error");
      AppUtility.printLog(StringValues.connTimedOut);
      AppUtility.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      _isLoadingFollowRequest.value = false;
      update();
      AppUtility.printLog("Fetching FollowRequest Error");
      AppUtility.printLog(StringValues.formatExcError);
      AppUtility.printLog(e);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      _isLoadingFollowRequest.value = false;
      update();
      AppUtility.printLog("Fetching FollowRequest Error");
      AppUtility.printLog(StringValues.errorOccurred);
      AppUtility.printLog(exc);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    }
  }

  Future<void> _loadMoreFollowRequests({int? page}) async {
    AppUtility.printLog("Fetching More FollowRequest Request");
    _isMoreLoadingFollowRequest.value = true;
    update();

    try {
      final response =
          await _apiProvider.getFollowRequests(_auth.token, page: page);

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        setFollowRequestData = FollowRequestResponse.fromJson(decodedData);
        _followRequestList.addAll(_followRequestData.value.results!);
        _isMoreLoadingFollowRequest.value = false;
        update();
        AppUtility.printLog("Fetching More FollowRequest Success");
      } else {
        _isMoreLoadingFollowRequest.value = false;
        update();
        AppUtility.printLog("Fetching More FollowRequest Error");
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } on SocketException {
      _isMoreLoadingFollowRequest.value = false;
      update();
      AppUtility.printLog("Fetching More FollowRequest Error");
      AppUtility.printLog(StringValues.internetConnError);
      AppUtility.showSnackBar(
          StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      _isMoreLoadingFollowRequest.value = false;
      update();
      AppUtility.printLog("Fetching More FollowRequest Error");
      AppUtility.printLog(StringValues.connTimedOut);
      AppUtility.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      _isMoreLoadingFollowRequest.value = false;
      update();
      AppUtility.printLog("Fetching More FollowRequest Error");
      AppUtility.printLog(StringValues.formatExcError);
      AppUtility.printLog(e);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      _isMoreLoadingFollowRequest.value = false;
      update();
      AppUtility.printLog("Fetching More FollowRequest Error");
      AppUtility.printLog(StringValues.errorOccurred);
      AppUtility.printLog(exc);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    }
  }

  Future<void> _acceptFollowRequest(String followRequestId) async {
    AppUtility.printLog("Accept FollowRequest Request");

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

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.success,
        );
        await profile.fetchProfileDetails(fetchPost: false);
        AppUtility.printLog("Accept FollowRequest Success");
      } else {
        AppUtility.printLog("Accept FollowRequest Error");
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } on SocketException {
      AppUtility.printLog("Accept FollowRequest Error");
      AppUtility.printLog(StringValues.internetConnError);
      AppUtility.showSnackBar(
          StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      AppUtility.printLog("Accept FollowRequest Error");
      AppUtility.printLog(StringValues.connTimedOut);
      AppUtility.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      AppUtility.printLog("Accept FollowRequest Error");
      AppUtility.printLog(StringValues.formatExcError);
      AppUtility.printLog(e);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      AppUtility.printLog("Accept FollowRequest Error");
      AppUtility.printLog(StringValues.errorOccurred);
      AppUtility.printLog(exc);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    }
  }

  Future<void> _removeFollowRequest(String followRequestId) async {
    AppUtility.printLog("Accept FollowRequest Request");

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

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        AppUtility.printLog(decodedData);
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.success,
        );
        AppUtility.printLog("Accept FollowRequest Success");
      } else {
        AppUtility.printLog("Accept FollowRequest Error");
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } on SocketException {
      AppUtility.printLog("Accept FollowRequest Error");
      AppUtility.printLog(StringValues.internetConnError);
      AppUtility.showSnackBar(
          StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      AppUtility.printLog("Accept FollowRequest Error");
      AppUtility.printLog(StringValues.connTimedOut);
      AppUtility.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      AppUtility.printLog("Accept FollowRequest Error");
      AppUtility.printLog(StringValues.formatExcError);
      AppUtility.printLog(e);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      AppUtility.printLog("Accept FollowRequest Error");
      AppUtility.printLog(StringValues.errorOccurred);
      AppUtility.printLog(exc);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
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
