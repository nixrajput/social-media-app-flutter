import 'dart:async';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_app/apis/models/entities/comment.dart';
import 'package:social_media_app/apis/models/responses/comments_response.dart';
import 'package:social_media_app/apis/providers/api_provider.dart';
import 'package:social_media_app/app_services/auth_service.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/utils/utility.dart';

class CommentController extends GetxController {
  static CommentController get find => Get.find();

  CommentController({this.postId});

  final _auth = AuthService.find;
  final _apiProvider = ApiProvider(http.Client());

  final _isLoading = false.obs;
  final _isMoreLoading = false.obs;
  final _commentsData = const CommentsResponse().obs;
  final List<Comment> _commentList = [];
  String? postId = '';

  bool get isLoading => _isLoading.value;

  bool get isMoreLoading => _isMoreLoading.value;

  CommentsResponse? get commentsData => _commentsData.value;

  List<Comment> get commentList => _commentList;

  set setCommentData(CommentsResponse response) {
    _commentsData.value = response;
  }

  Future<void> _fetchComments({String? id}) async {
    var tempId = id ?? postId;

    if (tempId == null || tempId.isEmpty) return;

    _isLoading.value = true;
    update();

    try {
      final response = await _apiProvider.getComments(_auth.token, tempId);

      if (response.isSuccessful) {
        final decodedData = response.data;
        setCommentData = CommentsResponse.fromJson(decodedData);
        _commentList.clear();
        _commentList.addAll(_commentsData.value.results!);
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
      AppUtility.log('Error: ${exc.toString()}', tag: 'error');
      AppUtility.showSnackBar('Error: ${exc.toString()}', StringValues.error);
    }
  }

  Future<void> _loadMore({String? id, int? page}) async {
    var tempId = id ?? postId;

    if (tempId == null || tempId.isEmpty) return;

    _isMoreLoading.value = true;
    update();

    try {
      final response = await _apiProvider.getComments(
        _auth.token,
        tempId,
        page: page,
      );

      if (response.isSuccessful) {
        final decodedData = response.data;
        setCommentData = CommentsResponse.fromJson(decodedData);
        _commentList.addAll(_commentsData.value.results!);
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
      AppUtility.log('Error: ${exc.toString()}', tag: 'error');
      AppUtility.showSnackBar('Error: ${exc.toString()}', StringValues.error);
    }
  }

  Future<void> _deleteComment(String commentId) async {
    if (commentId.isEmpty) return;

    var index = _commentList.indexWhere((element) => element.id == commentId);
    var comment = _commentList[index];

    if (index == -1) return;

    _commentList.removeAt(index);
    update();

    try {
      final response = await _apiProvider.deleteComment(_auth.token, commentId);

      if (response.isSuccessful) {
        final decodedData = response.data;
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.success,
          duration: 2,
        );
      } else {
        final decodedData = response.data;
        _commentList.insert(index, comment);
        update();
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } catch (exc) {
      _commentList.insert(index, comment);
      update();
      AppUtility.log('Error: ${exc.toString()}', tag: 'error');
      AppUtility.showSnackBar('Error: ${exc.toString()}', StringValues.error);
    }
  }

  Future<void> fetchComments({String? postId}) async =>
      await _fetchComments(id: postId);

  Future<void> deleteComment(String commentId) async =>
      await _deleteComment(commentId);

  Future<void> loadMore({String? postId}) async =>
      await _loadMore(page: _commentsData.value.currentPage! + 1, id: postId);

  @override
  void onInit() {
    super.onInit();
    postId = Get.arguments[0];
    if (postId != null && postId!.isNotEmpty) {
      _fetchComments();
    }
  }
}
