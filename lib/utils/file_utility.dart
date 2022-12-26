import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/extensions/file_extensions.dart';
import 'package:social_media_app/utils/utility.dart';
import 'package:video_compress_ds/video_compress_ds.dart';

const maxImageBytes = 1048576;
const maxVideoBytes = 10485760;

abstract class FileUtility {
  static Future<String> read(String path) async {
    return await File(path).readAsString();
  }

  static Future<void> write(String path, String content) async {
    await File(path).writeAsString(content);
  }

  static bool isVideoFile(String path) {
    const videoFilesTypes = [".mp4", ".mkv"];
    var ext = p.extension(path);
    // log('extension : $ext');
    // log(videoFilesTypes.contains(ext).toString());
    return videoFilesTypes.contains(ext);
  }

  /// Get Video Thumbnail
  static Future<File?> getVideoThumbnail(String path) async {
    try {
      var thumbFile = await VideoCompress.getFileThumbnail(
        path,
        quality: 60,
        position: 500,
      );

      return thumbFile;
    } catch (e) {
      AppUtility.log('getVideoThumbnailError : $e');
      return null;
    }
  }

  static Future<File?> compressImage(String path) async {
    File? resultFile = File(path);
    var size = resultFile.lengthSync();
    AppUtility.log('Original file size: ${resultFile.sizeToKb()} KB');

    if (size < (maxImageBytes / 2)) {
      AppUtility.log('Result $resultFile');
      AppUtility.log('Result file size: ${resultFile.sizeToKb()} KB');
      return resultFile;
    }
    var tempDir = await getTemporaryDirectory();

    /// --------- Compressing Image ------------------------------------

    var timestamp = DateTime.now().millisecondsSinceEpoch;
    AppUtility.log('Compressing...');
    resultFile = await FlutterImageCompress.compressAndGetFile(
      resultFile.path,
      '${tempDir.absolute.path}/temp$timestamp.jpg',
      quality: 60,
      format: CompressFormat.jpeg,
    );
    size = resultFile!.lengthSync();

    /// ----------------------------------------------------------------
    AppUtility.log('Result $resultFile');
    AppUtility.log('Result file size: ${resultFile.sizeToKb()} KB');
    return resultFile;
  }

  static Future<File?> compressVideo(String path) async {
    File? videoFile = File(path);
    var size = videoFile.lengthSync();
    AppUtility.log('Original file size: ${videoFile.sizeToKb()} KB');

    if (size < maxVideoBytes) {
      AppUtility.log('Result $videoFile');
      AppUtility.log('Result video size: ${videoFile.sizeToMb()} MB');

      return videoFile;
    }

    /// ----------- Compress Video ---------------------------------------

    var info = await VideoCompress.compressVideo(
      videoFile.path,
      quality: VideoQuality.DefaultQuality,
    );
    AppUtility.closeDialog();
    AppUtility.log('Result ${info!.toJson()}');
    videoFile = info.file!;
    size = info.filesize!;

    /// ------------------------------------------------------------------

    AppUtility.log('Result $videoFile');
    AppUtility.log('Result video size: ${videoFile.sizeToMb()} MB');

    if (size > (2 * maxVideoBytes)) {
      AppUtility.showSnackBar(
        'Video size is too large',
        '',
      );

      return null;
    }

    return videoFile;
  }

  static Future<File?> captureImage() async {
    final imagePicker = ImagePicker();

    final pickedImage = await imagePicker.pickImage(
      imageQuality: 100,
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.front,
    );

    if (pickedImage == null) {
      AppUtility.log('No image selected');
      return null;
    }

    var imageFile = File(pickedImage.path);
    var size = imageFile.lengthSync();

    if (size > (5 * maxImageBytes)) {
      AppUtility.showSnackBar(
        'Image size must be less than 5 mb',
        '',
      );
      return null;
    }
    return imageFile;
  }

  static Future<File?> selectImage({ImageSource? source}) async {
    final imagePicker = ImagePicker();

    final pickedImage = await imagePicker.pickImage(
      source: source ?? ImageSource.gallery,
      imageQuality: 100,
    );

    if (pickedImage == null) {
      AppUtility.log('No image selected');
      return null;
    }

    var imageFile = File(pickedImage.path);
    var size = imageFile.lengthSync();

    if (size > (5 * maxImageBytes)) {
      AppUtility.showSnackBar(
        'Image size must be less than 5 mb',
        '',
      );
      return null;
    }
    return imageFile;
  }

  static Future<List<File>?> selectMultipleImages() async {
    var fileList = <File>[];
    final imagePicker = ImagePicker();

    final pickedImages = await imagePicker.pickMultiImage(
      imageQuality: 100,
    );

    if (pickedImages.isEmpty) {
      AppUtility.log('No image selected');
      return null;
    }

    for (var image in pickedImages) {
      var imageFile = File(image.path);
      var size = imageFile.lengthSync();

      if (size > (5 * maxImageBytes)) {
        AppUtility.showSnackBar(
          'Image size must be less than 5 mb',
          '',
        );
      } else {
        fileList.add(imageFile);
      }
    }

    return fileList;
  }

  static Future<File?> recordVideo() async {
    final imagePicker = ImagePicker();

    final pickedVideo = await imagePicker.pickVideo(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.front,
      maxDuration: const Duration(seconds: 30),
    );

    if (pickedVideo == null) {
      AppUtility.log('No video selected');
      return null;
    }

    var imageFile = File(pickedVideo.path);
    var size = imageFile.lengthSync();

    if (size > (10 * maxVideoBytes)) {
      AppUtility.showSnackBar(
        'Video size must be less than 100 mb',
        '',
      );
      return null;
    }
    return imageFile;
  }

  static Future<List<File>?> selectMultipleVideos() async {
    final filePicker = FilePicker.platform;
    var fileList = <File>[];

    final pickedVideos = await filePicker.pickFiles(
      allowMultiple: true,
      withReadStream: true,
      allowCompression: false,
      type: FileType.custom,
      allowedExtensions: ['mp4', 'mkv'],
    );

    if (pickedVideos!.files.isEmpty) {
      AppUtility.log('No video selected');
      return null;
    }

    for (var video in pickedVideos.files) {
      var videoFile = File(video.path!);
      var size = videoFile.lengthSync();

      if (size > (10 * maxVideoBytes)) {
        AppUtility.showSnackBar(
          'Video size must be less than 100 mb',
          '',
        );
      } else {
        fileList.add(videoFile);
      }
    }

    return fileList;
  }

  static Future<File?> selectDocument() async {
    final filePicker = FilePicker.platform;

    final pickedDocument = await filePicker.pickFiles(
      allowMultiple: false,
      withReadStream: true,
      allowCompression: false,
      type: FileType.custom,
      allowedExtensions: ['pdf', 'png', 'jpg', 'jpeg'],
    );

    if (pickedDocument!.files.isEmpty) {
      AppUtility.log('No document selected');
      return null;
    }

    for (var doc in pickedDocument.files) {
      var document = File(doc.path!);
      var size = document.lengthSync();

      if (size > (5 * maxImageBytes)) {
        AppUtility.showSnackBar(
          'Document size must be less than 5 mb',
          '',
        );
      } else {
        return document;
      }
    }

    return null;
  }

  static Future<List<File>?> selectMultipleDocuments() async {
    final filePicker = FilePicker.platform;
    var fileList = <File>[];

    final pickedDocuments = await filePicker.pickFiles(
      allowMultiple: true,
      withReadStream: true,
      allowCompression: false,
      type: FileType.custom,
      allowedExtensions: ['pdf', 'png', 'jpg', 'jpeg'],
    );

    if (pickedDocuments!.files.isEmpty) {
      AppUtility.log('No document selected');
      return null;
    }

    for (var video in pickedDocuments.files) {
      var videoFile = File(video.path!);
      var size = videoFile.lengthSync();

      if (size > (5 * maxImageBytes)) {
        AppUtility.showSnackBar(
          'Document size must be less than 5 mb',
          '',
        );
      } else {
        fileList.add(videoFile);
      }
    }

    return fileList;
  }

  static Future<File?> cropImage(File imageFile, BuildContext context,
      {List<CropAspectRatioPreset>? aspectRatioPresets,
      int? maxWidth,
      int? maxHeight,
      CropAspectRatio? aspectRatio}) async {
    final imageCropper = ImageCropper();

    final croppedImage = await imageCropper.cropImage(
      sourcePath: imageFile.path,
      maxWidth: maxWidth ?? 1080,
      maxHeight: maxHeight ?? 1080,
      compressFormat: ImageCompressFormat.jpg,
      aspectRatio:
          aspectRatio ?? const CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
      compressQuality: 100,
      aspectRatioPresets: aspectRatioPresets ??
          [
            CropAspectRatioPreset.square,
          ],
      uiSettings: [
        AndroidUiSettings(
          toolbarColor: Theme.of(context).scaffoldBackgroundColor,
          toolbarTitle: StringValues.cropImage,
          toolbarWidgetColor: Theme.of(context).colorScheme.primary,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        IOSUiSettings(
          title: StringValues.cropImage,
          minimumAspectRatio: 1.0,
        ),
      ],
    );

    if (croppedImage == null) {
      AppUtility.log('No image selected');
      return null;
    }

    var image = File(croppedImage.path);
    return image;
  }
}
