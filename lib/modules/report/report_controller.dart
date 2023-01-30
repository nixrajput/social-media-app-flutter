import 'dart:async';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_app/apis/providers/api_provider.dart';
import 'package:social_media_app/app_services/auth_service.dart';
import 'package:social_media_app/constants/enums.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/routes/route_management.dart';
import 'package:social_media_app/utils/utility.dart';

class ReportController extends GetxController {
  late String id;

  final _apiProvider = ApiProvider(http.Client());
  final _auth = AuthService.find;
  final _isLoading = false.obs;
  final _reason = ''.obs;
  final _reportType = ReportType.user.obs;

  @override
  void onInit() {
    super.onInit();

    if (Get.arguments != null) {
      id = Get.arguments['id'];
      _reportType.value = Get.arguments['reportType'];
    }
  }

  static ReportController get find => Get.find();

  bool get isLoading => _isLoading.value;

  String get reason => _reason.value;

  ReportType get reportType => _reportType.value;

  set reason(String value) {
    _reason.value = value;
  }

  void updateReason(String value) {
    reason = value;
    update();
  }

  Future<void> submitReport() async {
    AppUtility.closeFocus();
    await _submitReport();
  }

  Future<void> _submitReport() async {
    if (_reason.value.isEmpty) {
      AppUtility.showSnackBar(
        StringValues.pleaseSelectReason,
        StringValues.warning,
      );
      return;
    }

    AppUtility.showLoadingDialog();
    _isLoading.value = true;
    update();

    final body = {
      'reason': _reason.value,
    };

    if (reportType == ReportType.user) {
      body['userId'] = id;
    } else if (reportType == ReportType.post) {
      body['postId'] = id;
    } else if (reportType == ReportType.comment) {
      body['commentId'] = id;
    }

    try {
      ResponseData? response;

      if (reportType == ReportType.user) {
        response = await _apiProvider.reportUser(
          _auth.token,
          body,
        );
      } else if (reportType == ReportType.post) {
        response = await _apiProvider.reportPost(
          _auth.token,
          body,
        );
      } else if (reportType == ReportType.comment) {
        response = await _apiProvider.reportComment(
          _auth.token,
          body,
        );
      }

      if (response == null) {
        AppUtility.closeDialog();
        _isLoading.value = false;
        update();
        AppUtility.showSnackBar(
          StringValues.somethingWentWrong,
          StringValues.error,
        );
        return;
      }

      if (response.isSuccessful) {
        final decodedData = response.data;
        AppUtility.log('decodedData: $decodedData');
        AppUtility.closeDialog();
        _isLoading.value = false;
        update();
        RouteManagement.goToBack();
        AppUtility.showSnackBar(
          StringValues.thanksForReporting,
          StringValues.success,
        );
      } else {
        final decodedData = response.data;
        AppUtility.closeDialog();
        _isLoading.value = false;
        update();
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } catch (exc) {
      AppUtility.closeDialog();
      _isLoading.value = false;
      update();
      AppUtility.showSnackBar('Error: $exc', StringValues.error);
    }
  }
}
