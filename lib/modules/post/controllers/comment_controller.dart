import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_app/apis/models/entities/comment.dart';
import 'package:social_media_app/apis/models/responses/comments_response.dart';
import 'package:social_media_app/apis/providers/api_provider.dart';
import 'package:social_media_app/apis/services/auth_service.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/global_widgets/primary_text_btn.dart';
import 'package:social_media_app/helpers/utils.dart';

class CommentController extends GetxController {
  static CommentController get find => Get.find();

  final _auth = AuthService.find;
  final _apiProvider = ApiProvider(http.Client());

  final _isLoading = false.obs;
  final _isMoreLoading = false.obs;
  final _commentsData = const CommentsResponse().obs;
  final List<Comment> _commentList = [];

  bool get isLoading => _isLoading.value;

  bool get isMoreLoading => _isMoreLoading.value;

  CommentsResponse get commentsData => _commentsData.value;

  List<Comment> get commentList => _commentList;

  set setCommentData(CommentsResponse response) {
    _commentsData.value = response;
  }

  Future<void> _fetchComments() async {
    AppUtils.printLog("Fetch Comment Request");

    var postId = Get.arguments;

    if (postId == '' || postId == null) return;

    _isLoading.value = true;
    update();

    try {
      final response = await _apiProvider.getComments(_auth.token, postId);

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        setCommentData = CommentsResponse.fromJson(decodedData);
        _commentList.clear();
        _commentList.addAll(_commentsData.value.results!);
        _isLoading.value = false;
        update();
        AppUtils.printLog("Fetch Comment Success");
      } else {
        _isLoading.value = false;
        update();
        AppUtils.printLog("Fetch Comment Error");
        AppUtils.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } on SocketException {
      _isLoading.value = false;
      update();
      AppUtils.printLog("Fetch Comment Error");
      AppUtils.printLog(StringValues.internetConnError);
      AppUtils.showSnackBar(StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      _isLoading.value = false;
      update();
      AppUtils.printLog("Fetch Comment Error");
      AppUtils.printLog(StringValues.connTimedOut);
      AppUtils.printLog(StringValues.connTimedOut);
      AppUtils.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      _isLoading.value = false;
      update();
      AppUtils.printLog("Fetch Comment Error");
      AppUtils.printLog(StringValues.formatExcError);
      AppUtils.printLog(e);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      _isLoading.value = false;
      update();
      AppUtils.printLog("Fetch Comment Error");
      AppUtils.printLog(StringValues.errorOccurred);
      AppUtils.printLog(exc);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    }
  }

  Future<void> _loadMore({int? page}) async {
    AppUtils.printLog("Fetch More Comment Request");

    var postId = Get.arguments;

    if (postId == '' || postId == null) return;

    _isMoreLoading.value = true;
    update();

    try {
      final response = await _apiProvider.getComments(
        _auth.token,
        postId,
        page: page,
      );

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        setCommentData = CommentsResponse.fromJson(decodedData);
        _commentList.addAll(_commentsData.value.results!);
        _isMoreLoading.value = false;
        update();
        AppUtils.printLog("Fetch More Comment Success");
      } else {
        _isMoreLoading.value = false;
        update();
        AppUtils.printLog("Fetch More Comment Error");
        AppUtils.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } on SocketException {
      _isMoreLoading.value = false;
      update();
      AppUtils.printLog("Fetch More Comment Error");
      AppUtils.printLog(StringValues.internetConnError);
      AppUtils.showSnackBar(StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      _isMoreLoading.value = false;
      update();
      AppUtils.printLog("Fetch More Comment Error");
      AppUtils.printLog(StringValues.connTimedOut);
      AppUtils.printLog(StringValues.connTimedOut);
      AppUtils.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      _isMoreLoading.value = false;
      update();
      AppUtils.printLog("Fetch More Comment Error");
      AppUtils.printLog(StringValues.formatExcError);
      AppUtils.printLog(e);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      _isMoreLoading.value = false;
      update();
      AppUtils.printLog("Fetch More Comment Error");
      AppUtils.printLog(StringValues.errorOccurred);
      AppUtils.printLog(exc);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    }
  }

  Future<void> _deleteComment(String commentId) async {
    AppUtils.printLog("Delete Comment Request");

    if (commentId.isEmpty) return;

    try {
      final response = await _apiProvider.deleteComment(_auth.token, commentId);

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        await _fetchComments();
        AppUtils.printLog("Delete Comment Success");
        AppUtils.showSnackBar(
          StringValues.commentDeleteSuccess,
          StringValues.success,
        );
      } else {
        AppUtils.printLog("Delete Comment Error");
        AppUtils.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } on SocketException {
      AppUtils.printLog("Delete Comment Error");
      AppUtils.printLog(StringValues.internetConnError);
      AppUtils.showSnackBar(StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      AppUtils.printLog("Delete Comment Error");
      AppUtils.printLog(StringValues.connTimedOut);
      AppUtils.printLog(StringValues.connTimedOut);
      AppUtils.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      AppUtils.printLog("Delete Comment Error");
      AppUtils.printLog(StringValues.formatExcError);
      AppUtils.printLog(e);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      AppUtils.printLog("Delete Comment Error");
      AppUtils.printLog(StringValues.errorOccurred);
      AppUtils.printLog(exc);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    }
  }

  Future<void> fetchComments() async => await _fetchComments();

  Future<void> loadMore() async =>
      await _loadMore(page: _commentsData.value.currentPage! + 1);

  Future<void> showDeleteCommentOptions(String commentId) async {
    AppUtils.showSimpleDialog(
      Padding(
        padding: Dimens.edgeInsets16,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              StringValues.deleteConfirmationText,
              style: AppStyles.style14Normal,
            ),
            Dimens.boxHeight24,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                NxTextButton(
                  label: StringValues.no,
                  labelStyle: AppStyles.style16Bold.copyWith(
                    color: ColorValues.errorColor,
                  ),
                  onTap: AppUtils.closeDialog,
                  padding: Dimens.edgeInsets8,
                ),
                Dimens.boxWidth16,
                NxTextButton(
                  label: StringValues.yes,
                  labelStyle: AppStyles.style16Bold.copyWith(
                    color: ColorValues.successColor,
                  ),
                  onTap: () async {
                    AppUtils.closeDialog();
                    await _deleteComment(commentId);
                  },
                  padding: Dimens.edgeInsets8,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Future<void> deleteComment(String commentId) async {
  //   AppUtils.showBottomSheet(
  //     [
  //       Text(
  //         StringValues.deleteConfirmationText,
  //         style: AppStyles.style20Bold,
  //       ),
  //       Dimens.boxHeight16,
  //       ListTile(
  //         onTap: () async {
  //           AppUtils.closeBottomSheet();
  //           await _deleteComment(commentId);
  //         },
  //         title: Text(
  //           StringValues.yes,
  //           style: AppStyles.style16Bold.copyWith(
  //             color: ColorValues.successColor,
  //           ),
  //         ),
  //       ),
  //       ListTile(
  //         onTap: AppUtils.closeBottomSheet,
  //         title: Text(
  //           StringValues.no,
  //           style: AppStyles.style16Bold.copyWith(
  //             color: ColorValues.errorColor,
  //           ),
  //         ),
  //         padding: Dimens.edgeInsets8,
  //       ),
  //     ],
  //   );
  // }

  @override
  void onInit() {
    super.onInit();
    _fetchComments();
  }
}
