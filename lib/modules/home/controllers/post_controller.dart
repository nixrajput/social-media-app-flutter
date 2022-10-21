import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_app/apis/models/entities/post.dart';
import 'package:social_media_app/apis/models/responses/common_response.dart';
import 'package:social_media_app/apis/models/responses/post_response.dart';
import 'package:social_media_app/apis/providers/api_provider.dart';
import 'package:social_media_app/apis/providers/socket_api_provider.dart';
import 'package:social_media_app/apis/services/auth_service.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/modules/chat/controllers/chat_controller.dart';
import 'package:social_media_app/modules/settings/controllers/login_device_info_controller.dart';
import 'package:social_media_app/services/hive_service.dart';
import 'package:social_media_app/utils/utility.dart';

class PostController extends GetxController {
  static PostController get find => Get.find();

  final _auth = AuthService.find;
  final _apiProvider = ApiProvider(http.Client());
  final _hiveService = HiveService();

  final _isLoading = false.obs;
  final _isMoreLoading = false.obs;
  final _postData = PostResponse().obs;

  final List<Post> _postList = [];

  bool get isLoading => _isLoading.value;

  bool get isMoreLoading => _isMoreLoading.value;

  PostResponse? get postData => _postData.value;

  List<Post> get postList => _postList;

  set setPostData(PostResponse value) => _postData.value = value;

  @override
  void onInit() {
    super.onInit();
    _getData();
  }

  _getData() async {
    await SocketApiProvider().init(_auth.token);
    await ChatController.find.initialize();
    var isExists = await _hiveService.isExists(boxName: 'posts');
    if (isExists) {
      var data = await _hiveService.getBox('posts');
      var cachedData = jsonDecode(data);
      setPostData = PostResponse.fromJson(cachedData);
      _postList.clear();
      _postList.addAll(_postData.value.results!);
    }
    update();
    await _fetchPosts();
    await Future.delayed(const Duration(seconds: 5), () async {
      await LoginDeviceInfoController.find.getLoginDeviceInfo();
    });
  }

  Future<void> _fetchPosts({int? page}) async {
    AppUtility.log("Fetching Posts Request");
    _isLoading.value = true;
    update();

    try {
      final response = await _apiProvider.getPosts(_auth.token, page: page);
      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        AppUtility.log("Fetching Posts Success");
        setPostData = PostResponse.fromJson(decodedData);
        _postList.clear();
        _postList.addAll(_postData.value.results!);
        await _hiveService.addBox('posts', jsonEncode(decodedData));
        _isLoading.value = false;
        update();
      } else {
        AppUtility.log("Fetching Posts Error: ${decodedData['message']}",
            tag: 'error');
        _isLoading.value = false;
        update();
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } on SocketException {
      _isLoading.value = false;
      update();
      AppUtility.log("Fetching Posts Error");
      AppUtility.log(StringValues.internetConnError, tag: 'error');
      AppUtility.showSnackBar(
          StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      _isLoading.value = false;
      update();
      AppUtility.log("Fetching Posts Error");
      AppUtility.log(StringValues.connTimedOut, tag: 'error');
      AppUtility.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      _isLoading.value = false;
      update();
      AppUtility.log("Fetching Posts Error");
      AppUtility.log(StringValues.formatExcError, tag: 'error');
      AppUtility.log(e);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      _isLoading.value = false;
      update();
      AppUtility.log("Fetching Posts Error $exc", tag: 'error');
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    }
  }

  Future<void> _loadMore({int? page}) async {
    AppUtility.log("Fetching More Posts Request");
    _isMoreLoading.value = true;
    update();

    try {
      final response = await _apiProvider.getPosts(_auth.token, page: page);
      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        AppUtility.log("Fetching More Posts Success");
        setPostData = PostResponse.fromJson(decodedData);
        _postList.addAll(_postData.value.results!);
        _isMoreLoading.value = false;
        update();
      } else {
        AppUtility.log("Fetching More Posts Error: ${decodedData['message']}",
            tag: 'error');

        _isMoreLoading.value = false;
        update();

        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } on SocketException {
      _isMoreLoading.value = false;
      update();
      AppUtility.log("Fetching More Posts Error");
      AppUtility.log(StringValues.internetConnError, tag: 'error');
      AppUtility.showSnackBar(
          StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      _isMoreLoading.value = false;
      update();
      AppUtility.log("Fetching More Posts Error");
      AppUtility.log(StringValues.connTimedOut, tag: 'error');
      AppUtility.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      _isMoreLoading.value = false;
      update();
      AppUtility.log("Fetching More Posts Error");
      AppUtility.log('Format Exception Error: $e', tag: 'error');
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      _isMoreLoading.value = false;
      update();
      AppUtility.log("Fetching More Posts Error");
      AppUtility.log('Error: $exc', tag: 'error');
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    }
  }

  Future<void> _deletePost(String postId) async {
    AppUtility.log("Post Delete Request");

    if (postId.isEmpty) return;

    var postIndex = _postList.indexWhere((element) => element.id == postId);
    var post = _postList[postIndex];
    if (postIndex == -1) return;

    _postList.removeAt(postIndex);
    update();

    try {
      final response = await _apiProvider.deletePost(_auth.token, postId);

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));
      final apiResponse = CommonResponse.fromJson(decodedData);

      if (response.statusCode == 200) {
        AppUtility.showSnackBar(
          apiResponse.message!,
          StringValues.success,
        );
        AppUtility.log("Post Delete Success");
      } else {
        _postList.insert(postIndex, post);
        update();
        AppUtility.log("Post Delete Error");
        AppUtility.showSnackBar(
          apiResponse.message!,
          StringValues.error,
        );
      }
    } on SocketException {
      _postList.insert(postIndex, post);
      update();
      AppUtility.log("Post Delete Error");
      AppUtility.log(StringValues.internetConnError, tag: 'error');
      AppUtility.showSnackBar(
          StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      _postList.insert(postIndex, post);
      update();
      AppUtility.log("Post Delete Error");
      AppUtility.log(StringValues.connTimedOut, tag: 'error');
      AppUtility.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      _postList.insert(postIndex, post);
      update();
      AppUtility.log("Post Delete Error");
      AppUtility.log('Format Exception Error: $e', tag: 'error');
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      _postList.insert(postIndex, post);
      update();
      AppUtility.log("Post Delete Error");
      AppUtility.log('Error: $exc', tag: 'error');
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    }
  }

  void _toggleLike(Post post) {
    if (post.isLiked) {
      post.isLiked = false;
      post.likesCount--;
      update();
      return;
    } else {
      post.isLiked = true;
      post.likesCount++;
      update();
      return;
    }
  }

  Future<void> _toggleLikePost(Post post) async {
    AppUtility.log("Like/Unlike Post Request");

    _toggleLike(post);

    try {
      final response = await _apiProvider.likeUnlikePost(_auth.token, post.id!);

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));
      final apiResponse = CommonResponse.fromJson(decodedData);

      if (response.statusCode == 200) {
        AppUtility.log(apiResponse.message!);
      } else {
        _toggleLike(post);
        AppUtility.showSnackBar(
          apiResponse.message!,
          StringValues.error,
        );
      }
    } on SocketException {
      _toggleLike(post);
      AppUtility.log(StringValues.internetConnError, tag: 'error');
      AppUtility.showSnackBar(
          StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      _toggleLike(post);
      AppUtility.log(StringValues.connTimedOut, tag: 'error');
      AppUtility.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      _toggleLike(post);
      AppUtility.log('Format Exception Error: $e', tag: 'error');
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      _toggleLike(post);
      AppUtility.log('Error: $exc', tag: 'error');
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    }
  }

  Future<void> fetchPosts() async => await _fetchPosts();

  Future<void> loadMore() async =>
      await _loadMore(page: _postData.value.currentPage! + 1);

  Future<void> deletePost(String postId) async => await _deletePost(postId);

  Future<void> toggleLikePost(Post post) async => await _toggleLikePost(post);
}
