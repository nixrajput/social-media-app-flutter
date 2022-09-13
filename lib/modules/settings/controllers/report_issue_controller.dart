import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_app/apis/providers/api_provider.dart';
import 'package:social_media_app/apis/services/auth_service.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/helpers/utils.dart';
import 'package:social_media_app/modules/home/controllers/profile_controller.dart';

class ReportIssueController extends GetxController {
  static ReportIssueController get find => Get.find();

  final _auth = AuthService.find;
  final profile = ProfileController.find;

  final _apiProvider = ApiProvider(http.Client());

  final _isLoading = false.obs;
  final _otpSent = false.obs;
  final messageTextController = TextEditingController();
  final otpTextController = TextEditingController();

  final FocusScopeNode focusNode = FocusScopeNode();

  /// Getters
  bool get isLoading => _isLoading.value;

  bool get otpSent => _otpSent.value;

  Future<void> _sendIssueReportEmail(String message) async {
    if (message.isEmpty) {
      AppUtils.showSnackBar(
        StringValues.enterMessage,
        StringValues.warning,
      );
      return;
    }

    final email = Email(
      body: message,
      subject: 'Issue Report - Rippl!',
      recipients: ['nixlab.in@gmail.com'],
      attachmentPaths: [],
      isHTML: false,
    );

    await FlutterEmailSender.send(email);
  }

  Future<void> sendChangeEmailOtp() async {
    AppUtils.closeFocus();
    await _sendIssueReportEmail(messageTextController.text.trim());
  }
}
