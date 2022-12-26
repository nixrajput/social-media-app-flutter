import 'dart:async';
import 'dart:io';

import 'package:cloudinary/cloudinary.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:social_media_app/apis/models/entities/hashtag.dart';
import 'package:social_media_app/apis/models/entities/post.dart';
import 'package:social_media_app/apis/models/responses/hashtag_response.dart';
import 'package:social_media_app/apis/providers/api_provider.dart';
import 'package:social_media_app/app_services/auth_service.dart';
import 'package:social_media_app/constants/secrets.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/modules/home/controllers/post_controller.dart';
import 'package:social_media_app/modules/home/controllers/profile_controller.dart';
import 'package:social_media_app/routes/route_management.dart';
import 'package:social_media_app/utils/file_utility.dart';
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

  final _pickedFileList = <File>[];
  final _isLoading = false.obs;
  final List<HashTag> _hashtagList = [];
  final _currentFileIndex = 0.obs;
  final _postVisibility = <String, dynamic>{}.obs;

  Worker? _hashtagWorker;

  HashTagResponse get hashtagData => _hashtagData.value;

  List<HashTag> get postList => _hashtagList;

  List<File> get pickedFileList => _pickedFileList;

  String get caption => _caption.value;

  bool get isLoading => _isLoading.value;

  int get currentFileIndex => _currentFileIndex.value;

  Map<String, dynamic> get postVisibility => _postVisibility;

  /// Setters
  set setCaption(String value) => _caption.value = value;

  set setHashtagData(HashTagResponse value) => _hashtagData.value = value;

  void onChangeCaption(String value) {
    setCaption = value;
    update();
  }

  void onPostVisibilityChange(Map<String, dynamic> value) {
    _postVisibility.value = value;
    update();
  }

  void onChangeFile(int index) {
    _currentFileIndex.value = index;
    update();
  }

  Future<void> removePostFile(int index) async {
    if (_pickedFileList.isEmpty) {
      return;
    }
    _pickedFileList.removeAt(index);
    if (_currentFileIndex.value > 0) {
      _currentFileIndex.value--;
    }
    update();
  }

  var cloudName = const String.fromEnvironment('CLOUDINARY_CLOUD_NAME',
      defaultValue: AppSecrets.cloudinaryCloudName);
  var uploadPreset = const String.fromEnvironment('CLOUDINARY_UPLOAD_PRESET',
      defaultValue: AppSecrets.cloudinaryUploadPreset);

  @override
  onInit() {
    super.onInit();
    _postVisibility.value = {'id': 'public', 'title': 'Public'};
  }

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

    AppUtility.showLoadingDialog(message: "Compressing...");

    for (var i = 0; i < _pickedFileList.length; i++) {
      var file = _pickedFileList[i];
      var isVideoFile = FileUtility.isVideoFile(file.path);

      if (isVideoFile) {
        await compressVideo(i);
      } else {
        await compressImage(i);
      }
    }

    AppUtility.closeDialog();
    AppUtility.showLoadingDialog(message: "Uploading...");

    for (var i = 0; i < _pickedFileList.length; i++) {
      var file = _pickedFileList[i];
      var isVideoFile = FileUtility.isVideoFile(file.path);

      if (isVideoFile) {
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
            AppUtility.log('Uploading Thumbnail : $progress %');
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
            AppUtility.log('Uploading Video : $progress %');
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
          AppUtility.log('Video upload failed. Error: $err', tag: 'error');
          AppUtility.showSnackBar(
              'Video upload failed. Error: $err', StringValues.error);
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
            AppUtility.log('Uploading : $progress %');
          },
        )
            .then((value) {
          mediaFiles.add({
            "public_id": value.publicId,
            "url": value.secureUrl,
            "mediaType": "image"
          });
        }).catchError((err) {
          AppUtility.log('Image upload failed. Error: $err', tag: 'error');
          AppUtility.showSnackBar(
              'Image upload failed. Error: $err', StringValues.error);
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
        "visibility": _postVisibility['id']!,
      };

      final response = await _apiProvider.createPost(_auth.token, body);

      if (response.isSuccessful) {
        final decodedData = response.data;
        _caption.value = '';
        _pickedFileList.clear();
        _postController.postList.insert(0, Post.fromJson(decodedData['post']));
        _postController.update();
        await ProfileController.find.fetchProfileDetails(fetchPost: true);
        _isLoading.value = false;
        update();
        AppUtility.closeDialog();
        RouteManagement.goToHomeView();
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
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
      AppUtility.log('Error: $exc', tag: 'error');
      AppUtility.showSnackBar('Error: $exc', StringValues.error);
    }
  }

  /// Pick Image

  Future<void> _selectMultipleImages() async {
    final filePicker = FilePicker.platform;
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

    if (pickedFiles == null) {
      return;
    }

    fileList = pickedFiles.files;
    for (var file in fileList) {
      var imageFile = File(file.path!);
      File? resultFile = imageFile;
      var size = imageFile.lengthSync();

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

  /// Capture Image

  Future<void> _captureImage() async {
    final imagePicker = ImagePicker();
    const maxImageBytes = 1048576;

    /// Capture Image ----------------------------------------------------------
    final pickedImage = await imagePicker.pickImage(
      maxWidth: 1080.0,
      maxHeight: 1080.0,
      imageQuality: 100,
      source: ImageSource.camera,
    );

    if (pickedImage != null) {
      var imageFile = File(pickedImage.path);
      File? resultFile = imageFile;
      var size = imageFile.lengthSync();

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

  /// Crop Image

  Future<void> cropImage(int index, BuildContext context) async {
    final image = _pickedFileList[index];
    var croppedImage = await FileUtility.cropImage(image, context);

    if (croppedImage == null) {
      AppUtility.showSnackBar(
        'Error: Image cropping failed',
        StringValues.error,
      );
      return;
    }

    _pickedFileList.removeAt(index);
    _pickedFileList.insert(index, croppedImage);
    update();
  }

  /// Compress Image

  Future<void> compressImage(int index) async {
    var image = _pickedFileList[index];
    var croppedImage = File(image.path);
    var tempDir = await getTemporaryDirectory();

    AppUtility.log('Compressing...');
    AppUtility.showLoadingDialog(message: 'Compressing...');

    var timestamp = DateTime.now().millisecondsSinceEpoch;

    var resultFile = await FlutterImageCompress.compressAndGetFile(
      croppedImage.path,
      '${tempDir.absolute.path}/temp$timestamp.jpg',
      quality: 60,
      format: CompressFormat.jpeg,
    );

    if (resultFile == null) {
      AppUtility.closeDialog();
      AppUtility.showSnackBar(
          'Error: Image compression failed', StringValues.error);
      AppUtility.log('Compression done');
      return;
    }

    _pickedFileList.removeAt(index);
    _pickedFileList.insert(index, resultFile);
    update();

    AppUtility.closeDialog();
    AppUtility.log('Compression done');
  }

  /// Pick Video

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

    if (pickedFiles == null) {
      return;
    }

    fileList = pickedFiles.files;
    for (var file in fileList) {
      var imageFile = File(file.path!);
      File? resultFile = imageFile;
      var size = imageFile.lengthSync();

      if (size > (10 * maxVideoBytes)) {
        AppUtility.showSnackBar(
          'Video size must be less than 100mb',
          '',
        );
      } else {
        _pickedFileList.add(resultFile);
        update();
      }
    }
  }

  /// Compress Video

  Future<void> compressVideo(int index) async {
    var video = _pickedFileList[index];
    var videoFile = File(video.path);

    AppUtility.log('Compressing...');
    AppUtility.showLoadingDialog(message: 'Compressing...');

    var info = await VideoCompress.compressVideo(
      videoFile.path,
      quality: VideoQuality.DefaultQuality,
    );

    if (info == null) {
      AppUtility.closeDialog();
      AppUtility.showSnackBar(
          'Error: Video compression failed', StringValues.error);
      AppUtility.log('Compression done');
      return;
    }

    _pickedFileList.removeAt(index);
    _pickedFileList.insert(index, info.file!);
    update();

    AppUtility.closeDialog();
    AppUtility.log('Compression done');
  }

  /// Capture Video

  Future<void> _recordVideo() async {
    final imagePicker = ImagePicker();
    const maxVideoBytes = 10485760;

    /// Capture Image ----------------------------------------------------------
    final pickedVideo = await imagePicker.pickVideo(
      source: ImageSource.camera,
      maxDuration: const Duration(seconds: 30),
    );

    if (pickedVideo != null) {
      var imageFile = File(pickedVideo.path);
      File? resultFile = imageFile;
      var size = imageFile.lengthSync();

      if (size > (10 * maxVideoBytes)) {
        AppUtility.showSnackBar(
          'Video size must be less than 100mb',
          '',
        );
      } else {
        _pickedFileList.add(resultFile);
        update();
      }
    }
  }

  Future<void> captureImage() async => await _captureImage();

  Future<void> recordVideo() async => await _recordVideo();

  Future<void> selectPostImages() async => await _selectMultipleImages();

  Future<void> selectPosVideos() async => await _selectMultipleVideos();

  void goToPostPreview() {
    if (_pickedFileList.isEmpty) return;
    if (_pickedFileList.length > 10) {
      AppUtility.showSnackBar(
        'Post can\'t have more than 10 images or videos',
        '',
      );
      return;
    }
    RouteManagement.goToPostPreviewView();
  }

  Future<void> createNewPost() async {
    if (_pickedFileList.isEmpty) {
      return;
    }
    await _createNewPost();
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
