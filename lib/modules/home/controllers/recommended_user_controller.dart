import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_app/apis/models/entities/user.dart';
import 'package:social_media_app/apis/models/responses/user_list_response.dart';
import 'package:social_media_app/apis/providers/api_provider.dart';
import 'package:social_media_app/apis/services/auth_service.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/utils/utility.dart';

class RecommendedUsersController extends GetxController {
  static RecommendedUsersController get find => Get.find();

  final _auth = AuthService.find;

  final _apiProvider = ApiProvider(http.Client());

  final _recommendedUsersData = const UserListResponse().obs;
  final _isLoading = false.obs;
  final _isMoreLoading = false.obs;
  final List<User> _recommendedUsersList = [];

  /// Getters
  bool get isLoading => _isLoading.value;

  bool get isMoreLoading => _isMoreLoading.value;

  UserListResponse? get recommendedUsersData => _recommendedUsersData.value;

  List<User> get recommendedUsersList => _recommendedUsersList;

  /// Setters
  set setRecommendedUsersData(UserListResponse value) =>
      _recommendedUsersData.value = value;

  Future<void> _getUsers() async {
    AppUtility.printLog("Get Recommended Users Request");
    _isLoading.value = true;
    update();

    try {
      final response = await _apiProvider.getRecommendedUsers(_auth.token);

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        setRecommendedUsersData = UserListResponse.fromJson(decodedData);
        _recommendedUsersList.clear();
        _recommendedUsersList.addAll(_recommendedUsersData.value.results!);
        _isLoading.value = false;
        update();
        AppUtility.printLog("Get Recommended Users Success");
      } else {
        _isLoading.value = false;
        update();
        AppUtility.printLog("Get Recommended Users Error");
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } on SocketException {
      _isLoading.value = false;
      update();
      AppUtility.printLog("Get Recommended Users Error");
      AppUtility.printLog(StringValues.internetConnError);
      AppUtility.showSnackBar(
          StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      _isLoading.value = false;
      update();
      AppUtility.printLog("Get Recommended Users Error");
      AppUtility.printLog(StringValues.connTimedOut);
      AppUtility.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      _isLoading.value = false;
      update();
      AppUtility.printLog("Get Recommended Users Error");
      AppUtility.printLog(StringValues.formatExcError);
      AppUtility.printLog(e);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      _isLoading.value = false;
      update();
      AppUtility.printLog("Get Recommended Users Error");
      AppUtility.printLog(StringValues.errorOccurred);
      AppUtility.printLog(exc);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    }
  }

  Future<void> _loadMore({int? page}) async {
    AppUtility.printLog("Fetching More Recommended Users Request");
    _isMoreLoading.value = true;
    update();

    try {
      final response =
          await _apiProvider.getRecommendedUsers(_auth.token, page: page);
      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        setRecommendedUsersData = UserListResponse.fromJson(decodedData);
        _recommendedUsersList.addAll(_recommendedUsersData.value.results!);
        _isMoreLoading.value = false;
        update();
        AppUtility.printLog("Fetching More Recommended Users Success");
      } else {
        _isMoreLoading.value = false;
        update();
        AppUtility.printLog("Fetching More Recommended Users Error");
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } on SocketException {
      _isMoreLoading.value = false;
      update();
      AppUtility.printLog("Fetching More Recommended Users Error");
      AppUtility.printLog(StringValues.internetConnError);
      AppUtility.showSnackBar(
          StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      _isMoreLoading.value = false;
      update();
      AppUtility.printLog("Fetching More Recommended Users Error");
      AppUtility.printLog(StringValues.connTimedOut);
      AppUtility.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      _isMoreLoading.value = false;
      update();
      AppUtility.printLog("Fetching More Recommended Users Error");
      AppUtility.printLog(StringValues.formatExcError);
      AppUtility.printLog(e);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      _isMoreLoading.value = false;
      update();
      AppUtility.printLog("Fetching More Recommended Users Error");
      AppUtility.printLog(StringValues.errorOccurred);
      AppUtility.printLog(exc);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    }
  }

  Future<void> getUsers() async {
    await _getUsers();
  }

  Future<void> loadMore() async =>
      await _loadMore(page: _recommendedUsersData.value.currentPage! + 1);

  @override
  void onInit() async {
    await _getUsers();
    super.onInit();
  }
}
