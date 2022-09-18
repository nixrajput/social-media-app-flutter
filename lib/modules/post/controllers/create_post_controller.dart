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
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:social_media_app/apis/models/entities/hashtag.dart';
import 'package:social_media_app/apis/models/entities/post.dart';
import 'package:social_media_app/apis/models/responses/hashtag_response.dart';
import 'package:social_media_app/apis/providers/api_provider.dart';
import 'package:social_media_app/apis/services/auth_service.dart';
import 'package:social_media_app/constants/secrets.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/extensions/file_extensions.dart';
import 'package:social_media_app/modules/home/controllers/post_controller.dart';
import 'package:social_media_app/routes/route_management.dart';
import 'package:social_media_app/utils/utility.dart';
import 'package:video_compress_ds/video_compress_ds.dart';

class CreatePostController extends GetxController {
  static CreatePostController get find => Get.find();

  final _auth = AuthService.find;
  final _postController = PostController.find;
  final _apiProvider = ApiProvider(http.Client());

  final _caption = ''.obs;
  final _hashtagData = const HashTagResponse().obs;

  final FocusScopeNode focusNode = FocusScopeNode();

  final _pickedFileList = RxList<File>();
  final _isLoading = false.obs;
  final List<HashTag> _hashtagList = [];

  HashTagResponse get hashtagData => _hashtagData.value;

  List<HashTag> get postList => _hashtagList;

  List<File>? get pickedFileList => _pickedFileList;

  String get caption => _caption.value;

  bool get isLoading => _isLoading.value;

  final captionTextController = TextEditingController();

  Worker? _hashtagWorker;

  /// Setters
  set setCaption(String value) => _caption.value = value;

  set setHashtagData(HashTagResponse value) => _hashtagData.value = value;

  void onChangeCaption(String value) {
    setCaption = value;
    update();
  }

  var cloudName = const String.fromEnvironment('CLOUDINARY_CLOUD_NAME',
      defaultValue: AppSecrets.cloudinaryCloudName);
  var uploadPreset = const String.fromEnvironment('CLOUDINARY_UPLOAD_PRESET',
      defaultValue: AppSecrets.uploadPreset);

  // @override
  // onInit() {
  //   //_hashtagWorker = ever(_caption, _checkHashtag);
  //   super.onInit();
  // }

  @override
  onClose() {
    _hashtagWorker?.dispose();
    super.onClose();
  }

  // void _checkHashtag(String text) async {
  //   // final hashRegExp = RegExp(r'\#(\w+)');
  //   // var start = 0;
  //   // var totalHashtag = 0;
  //   // var currentHashtag = '';
  //   //
  //   // Iterable<Match> matches = hashRegExp.allMatches(text);
  //   //
  //   // totalHashtag = matches.length;
  //   //
  //   // var cursorPos = captionTextController.selection.base.offset;
  //   //
  //   // currentHashtag = text.substring(start, cursorPos);
  //   //
  //   // AppUtility.printLog(totalHashtag);
  //   // AppUtility.printLog(currentHashtag);
  // }

  // Future<void> _searchAndGetTags(String tag) async {
  //   AppUtility.printLog("Search and Get Tags Request");
  //
  //   try {
  //     final response = await _apiProvider.searchTag(_auth.token, tag);
  //
  //     final decodedData = jsonDecode(utf8.decode(response.bodyBytes));
  //
  //     if (response.statusCode == 200) {
  //       AppUtility.printLog(decodedData);
  //       setHashtagData = HashTagResponse.fromJson(decodedData);
  //       _hashtagList.clear();
  //       _hashtagList.addAll(_hashtagData.value.results!);
  //       update();
  //       if (_hashtagList.isNotEmpty) {
  //         await _showHashtagsDialog();
  //       } else {
  //         AppUtility.closeDialog();
  //       }
  //       AppUtility.printLog("Search and Get Tags Success");
  //     } else {
  //       AppUtility.printLog(decodedData);
  //       update();
  //       AppUtility.printLog("Search and Get Tags Error");
  //     }
  //   } on SocketException {
  //     AppUtility.printLog("Search and Get Tags Error");
  //     AppUtility.printLog(StringValues.internetConnError);
  //     AppUtility.showSnackBar(
  //         StringValues.internetConnError, StringValues.error);
  //   } on TimeoutException {
  //     AppUtility.printLog("Search and Get Tags Error");
  //     AppUtility.printLog(StringValues.connTimedOut);
  //     AppUtility.showSnackBar(StringValues.connTimedOut, StringValues.error);
  //   } on FormatException catch (e) {
  //     AppUtility.printLog("Search and Get Tags Error");
  //     AppUtility.printLog(StringValues.formatExcError);
  //     AppUtility.printLog(e);
  //     AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
  //   } catch (exc) {
  //     AppUtility.printLog("Search and Get Tags Error");
  //     AppUtility.printLog(StringValues.errorOccurred);
  //     AppUtility.printLog(exc);
  //     AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
  //   }
  // }

  Future<void> _createNewPost() async {
    final cloudinary = Cloudinary.unsignedConfig(cloudName: cloudName);
    var mediaFiles = <Object>[];

    // for (var file in _pickedFileList) {
    //   var filePath = file.path;
    //   var sizeInKb = file.sizeToKb();
    //   if (AppUtility.isVideoFile(filePath)) {
    //     if (sizeInKb > 30 * 1024) {
    //       AppUtility.showSnackBar(
    //         'Video file size must be lower than 30 MB',
    //         StringValues.warning,
    //       );
    //       return;
    //     }
    //   } else {
    //     if (sizeInKb > 2048) {
    //       AppUtility.showSnackBar(
    //         'Image file size must be lower than 2 MB',
    //         StringValues.warning,
    //       );
    //       return;
    //     }
    //   }
    // }

    AppUtility.showLoadingDialog(message: "Uploading...");
    _isLoading.value = true;
    update();

    for (var file in _pickedFileList) {
      if (AppUtility.isVideoFile(file.path)) {
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
            AppUtility.printLog('Uploading Thumbnail : $progress %');
          },
        );

        if (!thumbnailUploadTask.isSuccessful) {
          AppUtility.showSnackBar(
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
            AppUtility.printLog('Uploading Video : $progress %');
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
          AppUtility.printLog(err);
          AppUtility.showSnackBar('Video upload failed.', StringValues.error);
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
            AppUtility.printLog('Uploading : $progress %');
          },
        )
            .then((value) {
          mediaFiles.add({
            "public_id": value.publicId,
            "url": value.secureUrl,
            "mediaType": "image"
          });
        }).catchError((err) {
          AppUtility.printLog(err);
          AppUtility.showSnackBar('Image upload failed.', StringValues.error);
          return;
        });
      }
    }

    AppUtility.closeDialog();
    AppUtility.showLoadingDialog(message: "Posting...");

    try {
      final body = {
        "caption": _caption.value,
        "mediaFiles": mediaFiles,
      };

      final response = await _apiProvider.createPost(_auth.token, body);

      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 201) {
        _caption.value = '';
        _pickedFileList.clear();
        _postController.postList.insert(0, Post.fromJson(decodedData['post']));
        _postController.update();
        _isLoading.value = false;
        update();
        AppUtility.closeDialog();
        RouteManagement.goToHomeView();
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.success,
        );
      } else {
        AppUtility.closeDialog();
        _isLoading.value = false;
        update();
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } on SocketException {
      AppUtility.closeDialog();
      _isLoading.value = false;
      update();
      AppUtility.printLog(StringValues.internetConnError);
      AppUtility.showSnackBar(
          StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      AppUtility.closeDialog();
      _isLoading.value = false;
      update();
      AppUtility.printLog(StringValues.connTimedOut);
      AppUtility.printLog(StringValues.connTimedOut);
      AppUtility.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      AppUtility.closeDialog();
      _isLoading.value = false;
      update();
      AppUtility.printLog(StringValues.formatExcError);
      AppUtility.printLog(e);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      AppUtility.closeDialog();
      _isLoading.value = false;
      update();
      AppUtility.printLog(StringValues.errorOccurred);
      AppUtility.printLog(exc);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    }
  }

  Future<void> _captureImage() async {
    final imagePicker = ImagePicker();
    final imageCropper = ImageCropper();
    const maxImageBytes = 1048576;

    /// Capture Image ----------------------------------------------------------
    final pickedImage = await imagePicker.pickImage(
      maxWidth: 1080.0,
      maxHeight: 1080.0,
      imageQuality: 100,
      source: ImageSource.camera,
    );

    if (pickedImage != null) {
      var croppedFile = await imageCropper.cropImage(
        maxWidth: 1080,
        maxHeight: 1080,
        sourcePath: pickedImage.path,
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
      AppUtility.printLog('Original file size: ${resultFile.sizeToKb()} KB');

      if (size > (5 * maxImageBytes)) {
        AppUtility.showSnackBar(
          'Image size must be less than 5mb',
          '',
        );
      } else if (size < (maxImageBytes / 2)) {
        AppUtility.printLog('Result $resultFile');
        AppUtility.printLog('Result file size: ${resultFile.sizeToKb()} KB');
        _pickedFileList.add(resultFile);
        update();
      } else {
        var tempDir = await getTemporaryDirectory();

        /// --------- Compressing Image ------------------------------------

        AppUtility.showLoadingDialog(message: 'Compressing...');
        var timestamp = DateTime.now().millisecondsSinceEpoch;
        AppUtility.printLog('Compressing...');
        resultFile = await FlutterImageCompress.compressAndGetFile(
          resultFile.path,
          '${tempDir.absolute.path}/temp$timestamp.jpg',
          quality: 60,
          format: CompressFormat.jpeg,
        );
        size = resultFile!.lengthSync();
        AppUtility.closeDialog();

        /// ----------------------------------------------------------------
        AppUtility.printLog('Result $resultFile');
        AppUtility.printLog('Result file size: ${resultFile.sizeToKb()} KB');
        _pickedFileList.add(resultFile);
        update();
      }
    }
  }

  Future<void> _selectMultipleImages() async {
    final filePicker = FilePicker.platform;
    final imageCropper = ImageCropper();
    var fileList = <PlatformFile>[];
    const maxImageBytes = 1048576;

    /// Pick Files
    final pickedFiles = await filePicker.pickFiles(
      allowMultiple: true,
      withReadStream: true,
      allowCompression: false,
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg', 'jpeg'],
    );

    if (pickedFiles != null) {
      fileList = pickedFiles.files;
      for (var file in fileList) {
        var croppedFile = await imageCropper.cropImage(
          maxWidth: 1080,
          maxHeight: 1080,
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
        AppUtility.printLog('Original file size: ${resultFile.sizeToKb()} KB');

        if (size > (5 * maxImageBytes)) {
          AppUtility.showSnackBar(
            'Image size must be less than 5mb',
            '',
          );
        } else if (size < (maxImageBytes / 2)) {
          AppUtility.printLog('Result $resultFile');
          AppUtility.printLog('Result file size: ${resultFile.sizeToKb()} KB');
          _pickedFileList.add(resultFile);
          update();
        } else {
          var tempDir = await getTemporaryDirectory();

          /// --------- Compressing Image ------------------------------------

          AppUtility.showLoadingDialog(message: 'Compressing...');
          var timestamp = DateTime.now().millisecondsSinceEpoch;
          AppUtility.printLog('Compressing...');
          resultFile = await FlutterImageCompress.compressAndGetFile(
            resultFile.path,
            '${tempDir.absolute.path}/temp$timestamp.jpg',
            quality: 60,
            format: CompressFormat.jpeg,
          );
          size = resultFile!.lengthSync();
          AppUtility.closeDialog();

          /// ----------------------------------------------------------------
          AppUtility.printLog('Result $resultFile');
          AppUtility.printLog('Result file size: ${resultFile.sizeToKb()} KB');
          _pickedFileList.add(resultFile);
          update();
        }
      }
    }
  }

  Future<void> _recordVideo() async {
    final imagePicker = ImagePicker();
    const maxVideoBytes = 10485760;

    /// Capture Image ----------------------------------------------------------
    final pickedVideo = await imagePicker.pickVideo(
      source: ImageSource.camera,
      maxDuration: const Duration(seconds: 30),
    );

    if (pickedVideo != null) {
      /// If File is Video ---------------------------------------------------
      /// --------------------------------------------------------------------

      var videoFile = File(pickedVideo.path);
      var videoSize = videoFile.lengthSync();
      AppUtility.printLog('Original video size: ${videoFile.sizeToMb()} MB');

      if (videoSize > (10 * maxVideoBytes)) {
        AppUtility.showSnackBar(
          'Video size must be less than 100mb',
          '',
        );
      } else if (videoSize < maxVideoBytes) {
        AppUtility.printLog('Result $videoFile');
        AppUtility.printLog('Result video size: ${videoFile.sizeToMb()} MB');

        _pickedFileList.add(videoFile);
        update();
      } else {
        /// ----------- Compress Video ---------------------------------------

        AppUtility.showLoadingDialog(message: 'Compressing...');
        var info = await VideoCompress.compressVideo(
          videoFile.path,
          quality: VideoQuality.DefaultQuality,
        );
        AppUtility.closeDialog();
        AppUtility.printLog('Result ${info!.toJson()}');
        videoFile = info.file!;
        videoSize = info.filesize!;

        /// ------------------------------------------------------------------

        AppUtility.printLog('Result $videoFile');
        AppUtility.printLog('Result video size: ${videoFile.sizeToMb()} MB');

        if (videoSize > (2 * maxVideoBytes)) {
          AppUtility.showSnackBar(
            'Video size is too large',
            '',
          );
        } else {
          _pickedFileList.add(videoFile);
          update();
        }
      }
    }
  }

  Future<void> _selectMultipleVideos() async {
    final filePicker = FilePicker.platform;
    var fileList = <PlatformFile>[];
    const maxVideoBytes = 10485760;

    /// Pick Files
    final pickedFiles = await filePicker.pickFiles(
      allowMultiple: true,
      withReadStream: true,
      allowCompression: false,
      type: FileType.custom,
      allowedExtensions: ['mp4', 'mkv'],
    );

    if (pickedFiles != null) {
      fileList = pickedFiles.files;
      for (var file in fileList) {
        /// If File is Video ---------------------------------------------------
        /// --------------------------------------------------------------------

        var videoFile = File(file.path!);
        var videoSize = file.size;
        AppUtility.printLog('Original video size: ${videoFile.sizeToMb()} MB');

        if (videoSize > (10 * maxVideoBytes)) {
          AppUtility.showSnackBar(
            'Video size must be less than 100mb',
            '',
          );
        } else if (videoSize < maxVideoBytes) {
          AppUtility.printLog('Result $videoFile');
          AppUtility.printLog('Result video size: ${videoFile.sizeToMb()} MB');

          _pickedFileList.add(videoFile);
          update();
        } else {
          /// ----------- Compress Video ---------------------------------------

          AppUtility.showLoadingDialog(message: 'Compressing...');
          var info = await VideoCompress.compressVideo(
            videoFile.path,
            quality: VideoQuality.DefaultQuality,
          );
          AppUtility.closeDialog();
          AppUtility.printLog('Result ${info!.toJson()}');
          videoFile = info.file!;
          videoSize = info.filesize!;

          /// ------------------------------------------------------------------

          AppUtility.printLog('Result $videoFile');
          AppUtility.printLog('Result video size: ${videoFile.sizeToMb()} MB');

          if (videoSize > (2 * maxVideoBytes)) {
            AppUtility.showSnackBar(
              'Video size is too large',
              '',
            );
          } else {
            _pickedFileList.add(videoFile);
            update();
          }
        }
      }
    }
  }

  Future<void> captureImage() async {
    await _captureImage();
    RouteManagement.goToCreatePostView();
  }

  Future<void> recordVideo() async {
    await _recordVideo();
    RouteManagement.goToCreatePostView();
  }

  Future<void> selectPostImages() async {
    await _selectMultipleImages();
    RouteManagement.goToCreatePostView();
  }

  Future<void> selectPosVideos() async {
    await _selectMultipleVideos();
    RouteManagement.goToCreatePostView();
  }

  void goToCaptionView() {
    if (_pickedFileList.length > 10) {
      AppUtility.showSnackBar(
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
      _pickedFileList.value = await AppUtility.selectMultipleFiles();
      update();
    }
  }

// Future<void> _showHashtagsDialog() async {
//   AppUtility.showSimpleDialog(
//     Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Dimens.boxHeight8,
//         SingleChildScrollView(
//           child: Padding(
//             padding: Dimens.edgeInsets0_16,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: _hashtagList
//                   .map(
//                     (e) => Text(
//                       '#${e.name}',
//                       style: AppStyles.style18Bold,
//                     ),
//                   )
//                   .toList(),
//             ),
//           ),
//         ),
//         Dimens.boxHeight8,
//       ],
//     ),
//     barrierDismissible: true,
//   );
// }
}
