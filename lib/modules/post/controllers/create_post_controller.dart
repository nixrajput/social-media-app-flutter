import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cloudinary/cloudinary.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_cropper/image_cropper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:social_media_app/apis/models/entities/post.dart';
import 'package:social_media_app/apis/providers/api_provider.dart';
import 'package:social_media_app/apis/services/auth_service.dart';
import 'package:social_media_app/constants/secrets.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/extensions/file_extensions.dart';
import 'package:social_media_app/helpers/utils.dart';
import 'package:social_media_app/modules/home/controllers/post_controller.dart';
import 'package:social_media_app/routes/route_management.dart';
import 'package:video_compress/video_compress.dart';

class CreatePostController extends GetxController {
  static CreatePostController get find => Get.find();

  final _auth = AuthService.find;
  final _postController = PostController.find;
  final _apiProvider = ApiProvider(http.Client());

  final captionTextController = TextEditingController();

  final FocusScopeNode focusNode = FocusScopeNode();

  final _pickedFileList = RxList<File>();
  final _isLoading = false.obs;

  List<File>? get pickedFileList => _pickedFileList;

  bool get isLoading => _isLoading.value;

  var cloudName = const String.fromEnvironment('CLOUDINARY_CLOUD_NAME',
      defaultValue: AppSecrets.cloudinaryCloudName);
  var uploadPreset = const String.fromEnvironment('CLOUDINARY_UPLOAD_PRESET',
      defaultValue: AppSecrets.uploadPreset);

  Future<void> _createNewPost() async {
    final cloudinary = Cloudinary.unsignedConfig(cloudName: cloudName);
    var mediaFiles = <Object>[];

    for (var file in _pickedFileList) {
      var filePath = file.path;
      var sizeInKb = file.sizeToKb();
      if (AppUtils.isVideoFile(filePath)) {
        if (sizeInKb > 30 * 1024) {
          AppUtils.showSnackBar(
            'Video file size must be lower than 30 MB',
            StringValues.warning,
          );
          return;
        }
      } else {
        if (sizeInKb > 2048) {
          AppUtils.showSnackBar(
            'Image file size must be lower than 2 MB',
            StringValues.warning,
          );
          return;
        }
      }
    }

    AppUtils.showLoadingDialog();
    _isLoading.value = true;
    update();

    for (var file in _pickedFileList) {
      if (AppUtils.isVideoFile(file.path)) {
        var thumbnailFile = await VideoCompress.getFileThumbnail(
          file.path,
          quality: 60,
          position: 500,
        );

        var thumbnailUploadTask = await cloudinary.unsignedUpload(
          uploadPreset: uploadPreset,
          file: thumbnailFile.path,
          resourceType: CloudinaryResourceType.image,
          folder: 'social_media_api/posts/thumbnails',
          progressCallback: (count, total) {
            var progress = ((count / total) * 100).toStringAsFixed(2);
            AppUtils.printLog('Uploading Thumbnail : $progress %');
          },
        );

        if (!thumbnailUploadTask.isSuccessful) {
          AppUtils.showSnackBar(
            'Thumbnail upload failed',
            StringValues.error,
          );
          return;
        }

        await cloudinary
            .unsignedUpload(
          uploadPreset: uploadPreset,
          file: file.path,
          resourceType: CloudinaryResourceType.video,
          folder: "social_media_api/posts/videos",
          progressCallback: (count, total) {
            var progress = ((count / total) * 100).toStringAsFixed(2);
            AppUtils.printLog('Uploading Video : $progress %');
          },
        )
            .then((value) {
          mediaFiles.add({
            "public_id": value.publicId,
            "url": value.secureUrl,
            "thumbnail": {
              "public_id": thumbnailUploadTask.publicId,
              "url": thumbnailUploadTask.secureUrl,
            },
            "mediaType": "video"
          });
        }).catchError((err) {
          AppUtils.printLog(err);
          AppUtils.showSnackBar('Video upload failed.', StringValues.error);
          return;
        });
      } else {
        await cloudinary
            .unsignedUpload(
          uploadPreset: uploadPreset,
          file: file.path,
          resourceType: CloudinaryResourceType.image,
          folder: "social_media_api/posts/images",
          progressCallback: (count, total) {
            var progress = ((count / total) * 100).toStringAsFixed(2);
            AppUtils.printLog('Uploading : $progress %');
          },
        )
            .then((value) {
          mediaFiles.add({
            "public_id": value.publicId,
            "url": value.secureUrl,
            "mediaType": "image"
          });
        }).catchError((err) {
          AppUtils.printLog(err);
          AppUtils.showSnackBar('Image upload failed.', StringValues.error);
          return;
        });
      }
    }

    try {
      final body = {
        "caption": captionTextController.text,
        "mediaFiles": mediaFiles,
      };

      final response = await _apiProvider.createPost(_auth.token, body);

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 201) {
        captionTextController.clear();
        //await _postController.fetchPosts();
        _postController.postList.insert(0, Post.fromJson(decodedData['post']));
        _postController.update();
        _isLoading.value = false;
        update();
        AppUtils.closeDialog();
        RouteManagement.goToBack();
        RouteManagement.goToBack();
        AppUtils.showSnackBar(
          decodedData[StringValues.message],
          StringValues.success,
        );
      } else {
        AppUtils.closeDialog();
        _isLoading.value = false;
        update();
        AppUtils.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } on SocketException {
      AppUtils.closeDialog();
      _isLoading.value = false;
      update();
      AppUtils.printLog(StringValues.internetConnError);
      AppUtils.showSnackBar(StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      AppUtils.closeDialog();
      _isLoading.value = false;
      update();
      AppUtils.printLog(StringValues.connTimedOut);
      AppUtils.printLog(StringValues.connTimedOut);
      AppUtils.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      AppUtils.closeDialog();
      _isLoading.value = false;
      update();
      AppUtils.printLog(StringValues.formatExcError);
      AppUtils.printLog(e);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      AppUtils.closeDialog();
      _isLoading.value = false;
      update();
      AppUtils.printLog(StringValues.errorOccurred);
      AppUtils.printLog(exc);
      AppUtils.showSnackBar(StringValues.errorOccurred, StringValues.error);
    }
  }

  Future<void> selectMultipleFiles() async {
    final filePicker = FilePicker.platform;
    final imageCropper = ImageCropper();
    var fileList = <PlatformFile>[];
    const maxImageBytes = 1048576;
    const maxVideoBytes = 10485760;

    /// Pick Files
    final pickedFiles = await filePicker.pickFiles(
      allowMultiple: true,
      withReadStream: true,
      allowCompression: false,
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg', 'jpeg', 'mp4', 'mkv'],
    );

    if (pickedFiles != null) {
      fileList = pickedFiles.files;
      for (var file in fileList) {
        var fileExt = file.extension;
        if (['png', 'jpg', 'jpeg'].contains(fileExt)) {
          var croppedFile = await imageCropper.cropImage(
            maxWidth: 1920,
            maxHeight: 1920,
            sourcePath: file.path!,
            compressFormat: ImageCompressFormat.jpg,
            aspectRatio: const CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
            uiSettings: [
              AndroidUiSettings(
                toolbarColor: Theme.of(Get.context!).scaffoldBackgroundColor,
                toolbarTitle: StringValues.cropImage,
                toolbarWidgetColor: Theme.of(Get.context!).colorScheme.primary,
                backgroundColor: Theme.of(Get.context!).scaffoldBackgroundColor,
              ),
              IOSUiSettings(
                title: StringValues.cropImage,
                minimumAspectRatio: 1.0,
              ),
            ],
            compressQuality: 100,
          );

          var croppedImage = File(croppedFile!.path);
          File? resultFile = croppedImage;
          var size = croppedImage.lengthSync();
          AppUtils.printLog('Original file size: ${resultFile.sizeToKb()} KB');

          if (size > (5 * maxImageBytes)) {
            AppUtils.showSnackBar(
              'Image size must be less than 5mb',
              '',
            );
          } else if (size < (maxImageBytes / 2)) {
            AppUtils.printLog('Result $resultFile');
            AppUtils.printLog('Result file size: ${resultFile.sizeToKb()} KB');
            _pickedFileList.add(resultFile);
            update();
          } else {
            var tempDir = await getTemporaryDirectory();

            /// --------- Compressing Image ------------------------------------

            AppUtils.showLoadingDialog(message: 'Compressing...');
            var timestamp = DateTime.now().millisecondsSinceEpoch;
            AppUtils.printLog('Compressing...');
            resultFile = await FlutterImageCompress.compressAndGetFile(
              resultFile.path,
              '${tempDir.absolute.path}/temp$timestamp.jpg',
              quality: 60,
              format: CompressFormat.jpeg,
            );
            size = resultFile!.lengthSync();
            AppUtils.closeDialog();

            /// ----------------------------------------------------------------
            AppUtils.printLog('Result $resultFile');
            AppUtils.printLog('Result file size: ${resultFile.sizeToKb()} KB');
            _pickedFileList.add(resultFile);
            update();
          }
        }

        /// If File is Video ---------------------------------------------------
        /// --------------------------------------------------------------------
        else {
          var videoFile = File(file.path!);
          var videoSize = file.size;
          AppUtils.printLog('Original video size: ${videoFile.sizeToMb()} MB');

          if (videoSize > (2 * maxVideoBytes)) {
            AppUtils.showSnackBar(
              'Video size must be less than 20mb',
              '',
            );
          } else if (videoSize < maxVideoBytes) {
            AppUtils.printLog('Result $videoFile');
            AppUtils.printLog('Result video size: ${videoFile.sizeToMb()} MB');

            _pickedFileList.add(videoFile);
            update();
          } else {
            /// ----------- Compress Video ---------------------------------------
            //
            // AppUtils.showLoadingDialog(message: 'Compressing...');
            // var info = await VideoCompress.compressVideo(
            //   videoFile.path,
            //   deleteOrigin: false,
            //   includeAudio: true,
            //   frameRate: 60,
            //   quality: VideoQuality.DefaultQuality,
            // );
            // AppUtils.closeDialog();
            // AppUtils.printLog('Result $info');
            // AppUtils.printLog('Result ${info!.toJson()}');
            // videoFile = info.file!;
            // videoSize = info.filesize!;

            /// ------------------------------------------------------------------

            AppUtils.printLog('Result $videoFile');
            AppUtils.printLog('Result video size: ${videoFile.sizeToMb()} MB');

            _pickedFileList.add(videoFile);
            update();
          }
        }
      }
    }
  }

  Future<void> selectPostImages() async {
    await selectMultipleFiles();
    RouteManagement.goToCreatePostView();
  }

  void goToCaptionView() {
    if (_pickedFileList.length > 10) {
      AppUtils.showSnackBar(
        'Post can\'t have more than 10 images or videos',
        '',
      );
      return;
    }
    RouteManagement.goToAddCaptionView();
  }

  Future<void> removePostImage(int index) async {
    if (_pickedFileList.isNotEmpty) {
      _pickedFileList.removeAt(index);
      update();
    }
  }

  Future<void> createNewPost() async {
    if (_pickedFileList.isNotEmpty) {
      await _createNewPost();
    } else {
      _pickedFileList.value = await AppUtils.selectMultipleFiles();
      update();
    }
  }
}
