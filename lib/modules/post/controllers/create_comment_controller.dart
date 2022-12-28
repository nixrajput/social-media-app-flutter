import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_app/apis/models/entities/comment.dart';
import 'package:social_media_app/apis/providers/api_provider.dart';
import 'package:social_media_app/app_services/auth_service.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/modules/post/controllers/comment_controller.dart';
import 'package:social_media_app/utils/utility.dart';

class CreateCommentController extends GetxController {
  static CreateCommentController get find => Get.find();

  final _auth = AuthService.find;
  final _apiProvider = ApiProvider(http.Client());
  final _commentController = CommentController.find;

  final commentTextController = TextEditingController();

  final FocusScopeNode focusNode = FocusScopeNode();

  final _isLoading = false.obs;
  final _comment = ''.obs;

  String get comment => _comment.value;

  void onChangedText(value) {
    _comment.value = value;
    update();
  }

  bool get isLoading => _isLoading.value;

  Future<void> _createNewComment(String comment, String postId) async {
    commentTextController.clear();
    _comment.value = '';
    _isLoading.value = true;
    update();

    try {
      final response =
          await _apiProvider.addComment(_auth.token, postId, comment);

      if (response.isSuccessful) {
        final decodedData = response.data;
        _commentController.commentList
            .insert(0, Comment.fromJson(decodedData['comment']));
        _commentController.update();
        _isLoading.value = false;
        update();
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.success,
          duration: 2,
        );
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
      AppUtility.printLog("Add Comment Error");
      _isLoading.value = false;
      update();
      AppUtility.log('Error: ${exc.toString()}', tag: 'error');
      AppUtility.showSnackBar('Error: ${exc.toString()}', StringValues.error);
    }
  }

  Future<void> createNewComment() async {
    AppUtility.closeFocus();
    if (commentTextController.text.isEmpty) return;

    var postId = Get.arguments;

    if (postId == '' || postId == null) return;

    await _createNewComment(
      commentTextController.text,
      postId,
    );
  }
}
