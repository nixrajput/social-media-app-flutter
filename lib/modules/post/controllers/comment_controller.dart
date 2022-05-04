import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_app/apis/models/responses/comments_response.dart';
import 'package:social_media_app/apis/providers/api_provider.dart';
import 'package:social_media_app/apis/services/auth_controller.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/helpers/utils.dart';

class CommentController extends GetxController {
  static CommentController get find => Get.find();

  final _auth = AuthController.find;
  final _apiProvider = ApiProvider(http.Client());

  final _isLoading = false.obs;
  final _commentsData = CommentsResponse().obs;

  bool get isLoading => _isLoading.value;

  CommentsResponse get commentsData => _commentsData.value;

  set setComments(CommentsResponse response) {
    _commentsData.value = response;
  }

  Future<void> _fetchComments() async {
    AppUtils.printLog("Fetch Comment Request...");

    var postId = Get.arguments[0];

    if (postId == '' || postId == null) return;

    _isLoading.value = true;
    update();

    try {
      final response = await _apiProvider.fetchComments(_auth.token, postId);

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        setComments = CommentsResponse.fromJson(decodedData);
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

  Future<void> _deleteComment(String commentId) async {
    AppUtils.printLog("Delete Comment Request...");

    if (commentId.isEmpty) return;

    try {
      final response = await _apiProvider.deleteComment(_auth.token, commentId);

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        await _fetchComments();
        AppUtils.showSnackBar(
          StringValues.commentDeleteSuccess,
          StringValues.success,
        );
      } else {
        AppUtils.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } on SocketException {
      AppUtils.printLog(StringValues.internetConnError);
      AppUtils.showSnackBar(StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      AppUtils.printLog(StringValues.connTimedOut);
      AppUtils.printLog(StringValues.connTimedOut);
      AppUtils.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      AppUtils.printLog(StringValues.formatExcError);
      AppUtils.printLog(e);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      AppUtils.printLog(StringValues.errorOccurred);
      AppUtils.printLog(exc);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    }
  }

  Future<void> fetchComments() async => await _fetchComments();

  Future<void> deleteComment(String commentId) async {
    AppUtils.showBottomSheet(
      [
        Text(
          StringValues.deleteConfirmationText,
          style: AppStyles.style20Bold,
        ),
        Dimens.boxHeight16,
        ListTile(
          onTap: () async {
            AppUtils.closeBottomSheet();
            await _deleteComment(commentId);
          },
          title: Text(
            StringValues.yes,
            style: AppStyles.style16Bold.copyWith(
              color: ColorValues.successColor,
            ),
          ),
        ),
        ListTile(
          onTap: AppUtils.closeBottomSheet,
          title: Text(
            StringValues.no,
            style: AppStyles.style16Bold.copyWith(
              color: ColorValues.errorColor,
            ),
          ),
        ),
      ],
    );
  }

  @override
  void onInit() {
    super.onInit();
    _fetchComments();
  }
}
