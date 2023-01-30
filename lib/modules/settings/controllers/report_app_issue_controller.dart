import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/extensions/file_extensions.dart';
import 'package:social_media_app/modules/home/controllers/profile_controller.dart';
import 'package:social_media_app/utils/utility.dart';

class ReportAppIssueController extends GetxController {
  static ReportAppIssueController get find => Get.find();

  final profile = ProfileController.find;

  final messageTextController = TextEditingController();
  final FocusScopeNode focusNode = FocusScopeNode();
  final _pickedFileList = RxList<File>();

  /// Getters
  List<File>? get pickedFileList => _pickedFileList;

  Future<void> _sendIssueReportEmail(String message) async {
    if (message.isEmpty) {
      AppUtility.showSnackBar(
        StringValues.enterIssue,
        StringValues.warning,
      );
      return;
    }

    var filePaths = <String>[];

    if (_pickedFileList.isNotEmpty) {
      for (var file in _pickedFileList) {
        filePaths.add(file.path);
      }
    }

    // final email = Email(
    //   body: message,
    //   subject: 'Report Issue - Rippl!',
    //   recipients: ['nixlab.in@gmail.com'],
    //   attachmentPaths: [...filePaths],
    //   isHTML: false,
    // );

    // await FlutterEmailSender.send(email);
  }

  void selectMultipleFiles() async {
    final filePicker = FilePicker.platform;
    var fileList = <PlatformFile>[];
    const maxImageBytes = 1048576;

    /// Pick Files
    final pickedFiles = await filePicker.pickFiles(
      allowMultiple: true,
      withReadStream: true,
      allowCompression: false,
      type: FileType.image,
    );

    if (pickedFiles != null) {
      fileList = pickedFiles.files;
      for (var file in fileList) {
        var croppedImage = File(file.path!);
        File? resultFile = croppedImage;
        var size = croppedImage.lengthSync();
        AppUtility.printLog('Original file size: ${resultFile.sizeToKb()} KB');
        if (size > (5 * maxImageBytes)) {
          AppUtility.showSnackBar(
            'Image size must be less than 5mb',
            '',
          );
        } else {
          _pickedFileList.add(resultFile);
          update();
        }
      }
    }
  }

  void removeImage(File img) {
    _pickedFileList.remove(img);
    update();
  }

  Future<void> sendIssueReportOtp() async {
    AppUtility.closeFocus();
    await _sendIssueReportEmail(messageTextController.text.trim());
  }
}
