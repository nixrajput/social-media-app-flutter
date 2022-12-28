import 'dart:async';
import 'dart:io';

import 'package:cloudinary/cloudinary.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_app/apis/providers/api_provider.dart';
import 'package:social_media_app/app_services/auth_service.dart';
import 'package:social_media_app/constants/secrets.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/routes/route_management.dart';
import 'package:social_media_app/utils/file_utility.dart';
import 'package:social_media_app/utils/utility.dart';

class VerificationController extends GetxController {
  static VerificationController get find => Get.find();

  final _auth = AuthService.find;

  final _apiProvider = ApiProvider(http.Client());

  final FocusScopeNode focusNode = FocusScopeNode();

  var cloudName = const String.fromEnvironment('CLOUDINARY_CLOUD_NAME',
      defaultValue: AppSecrets.cloudinaryCloudName);
  var uploadPreset = const String.fromEnvironment('CLOUDINARY_UPLOAD_PRESET',
      defaultValue: AppSecrets.cloudinaryUploadPreset);

  final _isLoading = false.obs;
  final _legalName = ''.obs;
  final _email = ''.obs;
  final _phone = ''.obs;
  final _category = ''.obs;
  final _document = Rxn<File>();
  final _isVerifiedOnOtherPlatform = false.obs;
  final _otherPlatformLinks = ''.obs;
  final _hasWikipediaPage = false.obs;
  final _wikipediaPageLink = ''.obs;
  final _featuredInNewsArticles = false.obs;
  final _newsArticlesLinks = ''.obs;
  final _otherLinks = ''.obs;

  bool get isLoading => _isLoading.value;
  String get legalName => _legalName.value;
  String get email => _email.value;
  String get phone => _phone.value;
  String get category => _category.value;
  File? get document => _document.value;
  bool get isVerifiedOnOtherPlatform => _isVerifiedOnOtherPlatform.value;
  String get otherPlatformLinks => _otherPlatformLinks.value;
  bool get hasWikipediaPage => _hasWikipediaPage.value;
  String get wikipediaPageLink => _wikipediaPageLink.value;
  bool get featuredInNewsArticles => _featuredInNewsArticles.value;
  String get newsArticlesLinks => _newsArticlesLinks.value;
  String get otherLinks => _otherLinks.value;

  set isLoading(bool value) => _isLoading.value = value;
  set legalName(String value) => _legalName.value = value;
  set email(String value) => _email.value = value;
  set phone(String value) => _phone.value = value;
  set category(String value) => _category.value = value;
  set setDocument(File value) => _document.value = value;
  set isVerifiedOnOtherPlatform(bool value) =>
      _isVerifiedOnOtherPlatform.value = value;
  set otherPlatformLinks(String value) => _otherPlatformLinks.value = value;
  set hasWikipediaPage(bool value) => _hasWikipediaPage.value = value;
  set wikipediaPageLink(String value) => _wikipediaPageLink.value = value;
  set featuredInNewsArticles(bool value) =>
      _featuredInNewsArticles.value = value;
  set newsArticlesLinks(String value) => _newsArticlesLinks.value = value;
  set otherLinks(String value) => _otherLinks.value = value;

  void onLegalNameChanged(String value) {
    legalName = value;
    update();
  }

  void onEmailChanged(String value) {
    email = value;
    update();
  }

  void onPhoneChanged(String value) {
    phone = value;
    update();
  }

  void onCategoryChanged(String value) {
    category = value;
    update();
  }

  void onDocumentChanged(File value) {
    setDocument = value;
    update();
  }

  void onIsVerifiedOnOtherPlatformChanged(bool value) {
    isVerifiedOnOtherPlatform = value;
    update();
  }

  void onOtherPlatformLinksChanged(String value) {
    otherPlatformLinks = value;
    update();
  }

  void onHasWikipediaPageChanged(bool value) {
    hasWikipediaPage = value;
    update();
  }

  void onWikipediaPageLinkChanged(String value) {
    wikipediaPageLink = value;
    update();
  }

  void onFeaturedInNewsArticlesChanged(bool value) {
    featuredInNewsArticles = value;
    update();
  }

  void onNewsArticlesLinksChanged(String value) {
    newsArticlesLinks = value;
    update();
  }

  void onOtherLinksChanged(String value) {
    otherLinks = value;
    update();
  }

  Future<void> selectDocument() async {
    var file = await FileUtility.selectDocument();

    if (file == null) {
      AppUtility.log('Document is null', tag: 'error');
      return;
    }

    setDocument = file;
    update();
  }

  Future<Map<String, dynamic>?> _uploadDocument(File file) async {
    final cloudinary = Cloudinary.unsignedConfig(cloudName: cloudName);

    try {
      var res = await cloudinary.unsignedUpload(
        uploadPreset: uploadPreset,
        file: file.path,
        resourceType: CloudinaryResourceType.auto,
        folder: "social_media_api/verification/documents",
        progressCallback: (count, total) {
          var progress = ((count / total) * 100).toStringAsFixed(2);
          AppUtility.log('Uploading Document : $progress %');
        },
      );
      return {
        "public_id": res.publicId,
        "url": res.secureUrl,
      };
    } catch (err) {
      AppUtility.log('Document upload failed. Error: $err', tag: 'error');
      AppUtility.showSnackBar('Document upload failed.', StringValues.error);
      return null;
    }
  }

  Future<void> _sendVerificationRequest() async {
    if (legalName.isEmpty) {
      AppUtility.showSnackBar(
        StringValues.enterLegalName,
        StringValues.warning,
      );
      return;
    }

    if (email.isEmpty) {
      AppUtility.showSnackBar(
        StringValues.enterEmail,
        StringValues.warning,
      );
      return;
    }

    if (phone.isEmpty) {
      AppUtility.showSnackBar(
        StringValues.enterPhone,
        StringValues.warning,
      );
      return;
    }

    if (category.isEmpty) {
      AppUtility.showSnackBar(
        StringValues.selectCategory,
        StringValues.warning,
      );
      return;
    }

    if (document == null) {
      AppUtility.showSnackBar(
        StringValues.selectDocument,
        StringValues.warning,
      );
      return;
    }

    AppUtility.showLoadingDialog();
    isLoading = true;
    update();

    var urlResult = await _uploadDocument(document!);

    if (urlResult == null) {
      return;
    }

    final body = {
      'legalName': legalName.trim(),
      'email': email.trim(),
      'phone': phone.trim(),
      'category': category.trim(),
      'document': urlResult,
      'isVerifiedOnOtherPlatform': isVerifiedOnOtherPlatform ? 'yes' : 'no',
      'otherPlatformLinks': otherPlatformLinks.trim(),
      'hasWikipediaPage': hasWikipediaPage ? 'yes' : 'no',
      'wikipediaPageLink': wikipediaPageLink.trim(),
      'featuredInArticles': featuredInNewsArticles ? 'yes' : 'no',
      'articleLinks': newsArticlesLinks.trim(),
      'otherLinks': otherLinks.trim(),
    };

    try {
      final response =
          await _apiProvider.requestVerification(_auth.token, body);

      if (response.isSuccessful) {
        final decodedData = response.data;
        AppUtility.closeDialog();
        isLoading = false;
        update();
        RouteManagement.goToBack();
        AppUtility.showSnackBar(
          decodedData['message'],
          StringValues.success,
        );
      } else {
        final decodedData = response.data;
        AppUtility.closeDialog();
        isLoading = false;
        update();
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } catch (exc) {
      AppUtility.closeDialog();
      isLoading = false;
      update();
      AppUtility.showSnackBar('Error: $exc', StringValues.error);
    }
  }

  Future<void> changePassword() async {
    AppUtility.closeFocus();
    await _sendVerificationRequest();
  }
}
