import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_app/apis/models/responses/common_response.dart';
import 'package:social_media_app/apis/models/responses/post_response.dart';
import 'package:social_media_app/apis/providers/api_provider.dart';
import 'package:social_media_app/apis/services/auth_service.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/helpers/utils.dart';

class PostController extends GetxController {
  static PostController get find => Get.find();

  final _auth = AuthService.find;
  final _apiProvider = ApiProvider(http.Client());

  final _isLoading = false.obs;
  final _postData = PostResponse().obs;

  bool get isLoading => _isLoading.value;

  PostResponse? get postData => _postData.value;

  set setPostData(PostResponse value) => _postData.value = value;

  @override
  void onInit() {
    super.onInit();
    _fetchAllPosts();
  }

  Future<void> _fetchAllPosts() async {
    AppUtils.printLog("Fetching Posts Request...");
    _isLoading.value = true;
    update();

    try {
      final response = await _apiProvider.fetchAllPosts(_auth.token);

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        setPostData = PostResponse.fromJson(decodedData);
        _postData.refresh();
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

  Future<void> _deletePost(String postId) async {
    AppUtils.printLog("Post Delete Request...");

    var postIndex =
        _postData.value.posts!.indexWhere((element) => element.id == postId);
    var post = _postData.value.posts!.elementAt(postIndex);

    if (postIndex > -1) {
      _postData.value.posts!.remove(post);
      _postData.refresh();
      update();
    }

    try {
      final response = await _apiProvider.deletePost(_auth.token, postId);

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));
      final apiResponse = CommonResponse.fromJson(decodedData);

      if (response.statusCode == 200) {
        AppUtils.showSnackBar(
          apiResponse.message!,
          StringValues.success,
        );
      } else {
        _postData.value.posts!.insert(postIndex, post);
        _postData.refresh();
        update();
        AppUtils.showSnackBar(
          apiResponse.message!,
          StringValues.error,
        );
      }
    } on SocketException {
      _postData.value.posts!.insert(postIndex, post);
      _postData.refresh();
      update();
      AppUtils.printLog(StringValues.internetConnError);
      AppUtils.showSnackBar(StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      _postData.value.posts!.insert(postIndex, post);
      _postData.refresh();
      update();
      AppUtils.printLog(StringValues.connTimedOut);
      AppUtils.printLog(StringValues.connTimedOut);
      AppUtils.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      _postData.value.posts!.insert(postIndex, post);
      _postData.refresh();
      update();
      AppUtils.printLog(StringValues.formatExcError);
      AppUtils.printLog(e);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      _postData.value.posts!.insert(postIndex, post);
      _postData.refresh();
      update();
      AppUtils.printLog(StringValues.errorOccurred);
      AppUtils.printLog(exc);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    }
  }

  Future<void> fetchAllPosts() async => await _fetchAllPosts();

  Future<void> deletePost(String postId) async => await _deletePost(postId);
}
