import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/modules/home/controllers/profile_controller.dart';
import 'package:social_media_app/utils/utility.dart';

class SendSuggestionsController extends GetxController {
  static SendSuggestionsController get find => Get.find();

  final profile = ProfileController.find;

  final messageTextController = TextEditingController();

  final FocusScopeNode focusNode = FocusScopeNode();

  Future<void> _sendSuggestionsEmail(String message) async {
    if (message.isEmpty) {
      AppUtility.showSnackBar(
        StringValues.enterSuggestions,
        StringValues.warning,
      );
      return;
    }

    final email = Email(
      body: message,
      subject: 'Suggestion - Rippl!',
      recipients: ['nixlab.in@gmail.com'],
      isHTML: false,
    );

    await FlutterEmailSender.send(email);
  }

  Future<void> sendSuggestionsEmail() async {
    AppUtility.closeFocus();
    await _sendSuggestionsEmail(messageTextController.text.trim());
  }
}
