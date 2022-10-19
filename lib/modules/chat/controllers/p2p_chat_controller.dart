import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cloudinary/cloudinary.dart';
import 'package:flutter/material.dart' as material;
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_app/apis/models/entities/chat_message.dart';
import 'package:social_media_app/apis/models/entities/media_file.dart';
import 'package:social_media_app/apis/models/entities/media_file_message.dart';
import 'package:social_media_app/apis/models/entities/post_media_file.dart';
import 'package:social_media_app/apis/models/responses/chat_message_list_response.dart';
import 'package:social_media_app/apis/providers/api_provider.dart';
import 'package:social_media_app/apis/providers/socket_api_provider.dart';
import 'package:social_media_app/apis/services/auth_service.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/secrets.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/modules/chat/controllers/chat_controller.dart';
import 'package:social_media_app/modules/home/controllers/profile_controller.dart';
import 'package:social_media_app/utils/file_utility.dart';
import 'package:social_media_app/utils/utility.dart';

class P2PChatController extends GetxController {
  static P2PChatController get find => Get.find();

  final chatController = ChatController.find;
  final profile = ProfileController.find;
  final _auth = AuthService.find;
  final _apiProvider = ApiProvider(http.Client());
  final _socketApiProvider = SocketApiProvider();

  final messageTextController = material.TextEditingController();
  final scrollController = material.ScrollController();
  final listScrollController = material.ScrollController();

  final _isLoading = false.obs;
  final _scrolledToBottom = true.obs;
  final _isMoreLoading = false.obs;
  final _message = ''.obs;
  final _replyTo = ChatMessage().obs;
  final _messageData = const ChatMessageListResponse().obs;
  final _mediaFileMessages = RxList<MediaFileMessage>();

  bool get isLoading => _isLoading.value;

  bool get isMoreLoading => _isMoreLoading.value;

  bool get scrolledToBottom => _scrolledToBottom.value;

  String get message => _message.value;

  ChatMessage get replyTo => _replyTo.value;

  List<MediaFileMessage>? get mediaFileMessages => _mediaFileMessages;

  ChatMessageListResponse? get messageData => _messageData.value;

  /// Setters
  set setMessageData(ChatMessageListResponse response) =>
      _messageData.value = response;

  String? userId;
  String? username;
  MediaFile? profileImage;

  var cloudName = const String.fromEnvironment('CLOUDINARY_CLOUD_NAME',
      defaultValue: AppSecrets.cloudinaryCloudName);
  var uploadPreset = const String.fromEnvironment('CLOUDINARY_UPLOAD_PRESET',
      defaultValue: AppSecrets.cloudinaryUploadPreset);

  void onChangedText(value) {
    _message.value = value;
    update();
  }

  void onChangeReplyTo(ChatMessage replyTo) {
    _replyTo.value = replyTo;
    update();
  }

  void clearReplyTo() {
    _replyTo.value = ChatMessage();
    update();
  }

  void addMediaFileMessage(MediaFileMessage value) {
    _mediaFileMessages.add(value);
    update();
  }

  void addMediaFileMessages(List<MediaFileMessage> values) {
    _mediaFileMessages.addAll(values);
    update();
  }

  void removeFile(int index) {
    _mediaFileMessages.removeAt(index);
    update();
    if (_mediaFileMessages.isEmpty) {
      Get.back();
    }
  }

  @override
  void onClose() {
    sendTypingStatus('end');
    super.onClose();
  }

  void scrollToLast() {
    material.WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.animateTo(
        scrollController.position.minScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: material.Curves.easeOut,
      );
    });
  }

  void scrollToFirst() {
    material.WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: material.Curves.easeOut,
      );
    });
  }

  void scrollToCustomChatMessage(String messageId) async {
    var dataKey = material.GlobalObjectKey(messageId);
    AppUtility.printLog('key $dataKey');
    AppUtility.printLog('context ${dataKey.currentContext}');
    if (dataKey.currentContext != null) {
      var renderedObj = dataKey.currentContext!.findRenderObject();
      AppUtility.printLog('renderedObj $renderedObj');
      AppUtility.printLog('Searching object');
      await listScrollController.position.ensureVisible(
        renderedObj!,
        //alignment: 0.5,
        duration: const Duration(milliseconds: 300),
        curve: material.Curves.easeOut,
      );
      AppUtility.printLog('Searching done');
    }
  }

  Future<Map<String, dynamic>?> _uploadVideo(File file, File thumbnail) async {
    final cloudinary = Cloudinary.unsignedConfig(cloudName: cloudName);

    var thumbnailUploadTask = await cloudinary.unsignedUpload(
      uploadPreset: uploadPreset,
      file: thumbnail.path,
      resourceType: CloudinaryResourceType.image,
      folder: 'social_media_api/chats/thumbnails',
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
      return null;
    }

    try {
      var res = await cloudinary.unsignedUpload(
        uploadPreset: uploadPreset,
        file: file.path,
        resourceType: CloudinaryResourceType.video,
        folder: "social_media_api/chats/videos",
        progressCallback: (count, total) {
          var progress = ((count / total) * 100).toStringAsFixed(2);
          AppUtility.printLog('Uploading Video : $progress %');
        },
      );
      return {
        "public_id": res.publicId,
        "url": res.secureUrl,
        "thumbnail": {
          "public_id": thumbnailUploadTask.publicId,
          "url": thumbnailUploadTask.secureUrl,
        },
        "mediaType": "video"
      };
    } catch (err) {
      AppUtility.printLog(err);
      AppUtility.showSnackBar('Video upload failed.', StringValues.error);
      return null;
    }
  }

  Future<Map<String, dynamic>?> _uploadImage(File file) async {
    final cloudinary = Cloudinary.unsignedConfig(cloudName: cloudName);

    try {
      var res = await cloudinary.unsignedUpload(
        uploadPreset: uploadPreset,
        file: file.path,
        resourceType: CloudinaryResourceType.image,
        folder: "social_media_api/chats/images",
        progressCallback: (count, total) {
          var progress = ((count / total) * 100).toStringAsFixed(2);
          AppUtility.printLog('Uploading Image : $progress %');
        },
      );
      return {
        "public_id": res.publicId,
        "url": res.secureUrl,
        "mediaType": "image"
      };
    } catch (err) {
      AppUtility.printLog(err);
      AppUtility.showSnackBar('Image upload failed.', StringValues.error);
      return null;
    }
  }

  void sendMessage() async {
    material.FocusManager.instance.primaryFocus!.unfocus();

    if (_mediaFileMessages.isNotEmpty) {
      for (var mediaFileMessage in _mediaFileMessages) {
        var encryptedMessage =
            base64Encode(utf8.encode(mediaFileMessage.message ?? ''));
        var mediaFile = mediaFileMessage.file;

        if (FileUtility.isVideoFile(mediaFile.path)) {
          var compressdFile = await FileUtility.compressVideo(mediaFile.path);
          var thumbnailFile =
              await FileUtility.getVideoThumbnail(mediaFile.path);

          if (compressdFile != null && thumbnailFile != null) {
            var tempId = AppUtility.generateUid(10);

            var tempMessage = ChatMessage(
              tempId: tempId,
              senderId: profile.profileDetails!.user!.id,
              receiverId: userId!,
              message: encryptedMessage,
              mediaFile: PostMediaFile(
                mediaType: 'video',
                url: compressdFile.path,
                thumbnail: MediaFile(url: thumbnailFile.path),
              ),
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
              seen: false,
              sender: null,
              receiver: null,
            );

            chatController.addTempMessage(tempMessage);

            var urlResult = await _uploadVideo(compressdFile, thumbnailFile);

            if (urlResult != null) {
              _socketApiProvider.sendJson({
                "type": "send-message",
                "payload": {
                  "message": encryptedMessage,
                  "receiverId": userId,
                  "tempId": tempId,
                  "mediaFile": urlResult,
                  "replyTo": _replyTo.value.id,
                },
              });
            }
          }
        } else {
          var compressdFile = await FileUtility.compressImage(mediaFile.path);

          if (compressdFile != null) {
            var tempId = AppUtility.generateUid(10);

            var tempMessage = ChatMessage(
              tempId: tempId,
              senderId: profile.profileDetails!.user!.id,
              receiverId: userId!,
              message: encryptedMessage,
              mediaFile: PostMediaFile(
                mediaType: 'image',
                url: compressdFile.path,
              ),
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
              seen: false,
              sender: null,
              receiver: null,
            );

            chatController.addTempMessage(tempMessage);

            var urlResult = await _uploadImage(compressdFile);

            if (urlResult != null) {
              _socketApiProvider.sendJson({
                "type": "send-message",
                "payload": {
                  "message": encryptedMessage,
                  "receiverId": userId,
                  "tempId": tempId,
                  "mediaFile": urlResult,
                  "replyTo": _replyTo.value.id,
                },
              });
            }
          }
        }
      }

      _replyTo.value = ChatMessage();
      _mediaFileMessages.clear();
      update();
      scrollToLast();
      return;
    }

    messageTextController.clear();
    var encryptedMessage = base64Encode(utf8.encode(message));

    var tempId = AppUtility.generateUid(10);

    var tempMessage = ChatMessage(
      tempId: tempId,
      senderId: profile.profileDetails!.user!.id,
      receiverId: userId!,
      message: encryptedMessage,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      seen: false,
      sender: null,
      receiver: null,
    );

    chatController.addTempMessage(tempMessage);

    _socketApiProvider.sendJson({
      "type": "send-message",
      "payload": {
        "message": encryptedMessage,
        "receiverId": userId,
        "tempId": tempId,
        "replyTo": _replyTo.value.id,
      },
    });

    _message.value = '';
    _replyTo.value = ChatMessage();
    update();
    scrollToLast();
  }

  @override
  void onInit() {
    super.onInit();
    userId = Get.arguments[0];
    username = Get.arguments[1];
    profileImage = Get.arguments[2];
    if (userId != null) {
      _getData();
    }
    material.WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.addListener(() {
        if (scrollController.position.pixels >=
            scrollController.position.minScrollExtent + (2 * Dimens.hundred)) {
          _scrolledToBottom.value = false;
          update();
        } else {
          _scrolledToBottom.value = true;
          update();
        }
      });
    });
  }

  _getData() async {
    await _fetchMessagesById();
    _markMessageAsRead();
  }

  void deleteMultipleMessages(List<String> messageIds) {
    _socketApiProvider.sendJson({
      'type': 'delete-messages',
      'payload': {
        'messageIds': messageIds,
      }
    });
  }

  void deleteMessage(String messageId) {
    _socketApiProvider.sendJson({
      'type': 'delete-message',
      'payload': {
        'messageId': messageId,
      }
    });
  }

  void sendTypingStatus(String status) {
    _socketApiProvider.sendJson({
      'type': 'message-typing',
      'payload': {
        'receiverId': userId,
        'status': status,
      }
    });
  }

  void _markMessageAsRead() async {
    if (chatController.allMessages.isNotEmpty) {
      var unreadMessages = chatController.allMessages
          .where((element) =>
              (element.senderId == userId &&
                  element.receiverId == profile.profileDetails!.user!.id) &&
              element.seen == false)
          .toList();
      if (unreadMessages.isNotEmpty) {
        AppUtility.printLog('Marking message as read');
        for (var message in unreadMessages) {
          _socketApiProvider.sendJson(
            {
              "type": "read-message",
              "payload": {
                "messageId": message.id,
              }
            },
          );
          message.seen = true;
          message.seenAt = DateTime.now();
          update();
        }
      }
    }
  }

  // removeOverlay() {
  //   if (_overlayEntry != null) {
  //     _overlayEntry!.remove();
  //     _overlayEntry = null;
  //   }
  // }

  // onTapShowOverlay(material.TapDownDetails details, context, String messageId,
  //     String senderId) {
  //   var size = material.MediaQuery.of(context).size;
  //   var offset = details.globalPosition;

  //   _overlayEntry?.remove();
  //   overlayState = material.Overlay.of(context);

  //   _overlayEntry = material.OverlayEntry(
  //     builder: (material.BuildContext context) => material.Positioned(
  //       left: offset.dx,
  //       top: offset.dy,
  //       child: material.Material(
  //         color: material.Colors.transparent,
  //         child: material.Container(
  //           constraints: material.BoxConstraints(
  //             maxWidth: Dimens.screenWidth * 0.5,
  //             maxHeight: Dimens.screenHeight * 0.75,
  //           ),
  //           decoration: material.BoxDecoration(
  //             color: material.Theme.of(context).dialogBackgroundColor,
  //             borderRadius: material.BorderRadius.circular(Dimens.eight),
  //             boxShadow: [
  //               material.BoxShadow(
  //                 color: material.Colors.black.withOpacity(0.15),
  //                 blurRadius: Dimens.four,
  //                 spreadRadius: Dimens.two,
  //               ),
  //             ],
  //           ),
  //           padding: Dimens.edgeInsets8,
  //           child: material.Column(
  //             mainAxisAlignment: material.MainAxisAlignment.start,
  //             crossAxisAlignment: material.CrossAxisAlignment.start,
  //             mainAxisSize: material.MainAxisSize.min,
  //             children: [
  //               if (senderId == profile.profileDetails!.user!.id)
  //                 material.ListTile(
  //                   contentPadding: Dimens.edgeInsets0,
  //                   onTap: () {
  //                     removeOverlay();
  //                     deleteMessage(messageId);
  //                   },
  //                   leading: const material.Icon(material.Icons.delete),
  //                   minLeadingWidth: Dimens.twentyFour,
  //                   horizontalTitleGap: Dimens.eight,
  //                   title: material.Text(
  //                     StringValues.delete,
  //                     style: AppStyles.style14Normal.copyWith(
  //                       color: material.Theme.of(context)
  //                           .textTheme
  //                           .bodyText1!
  //                           .color,
  //                     ),
  //                   ),
  //                 ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  //   overlayState!.insert(_overlayEntry!);
  // }

  Future<void> _fetchMessagesById() async {
    AppUtility.printLog("Fetching Messages Request");
    _isLoading.value = true;
    update();

    try {
      final response = await _apiProvider.getMessagesById(_auth.token, userId!);
      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        AppUtility.printLog("Fetching Messages Success");
        setMessageData = ChatMessageListResponse.fromJson(decodedData);

        for (var element in messageData!.results!) {
          chatController.addToAllMessages(element);
        }

        _isLoading.value = false;
        update();
      } else {
        _isLoading.value = false;
        update();
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
        AppUtility.printLog("Fetching Messages Error");
      }
    } on SocketException {
      _isLoading.value = false;
      update();
      AppUtility.printLog("Fetching Last Messages Error");
      AppUtility.printLog(StringValues.internetConnError);
      AppUtility.showSnackBar(
          StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      _isLoading.value = false;
      update();
      AppUtility.printLog("Fetching Last Messages Error");
      AppUtility.printLog(StringValues.connTimedOut);
      AppUtility.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      _isLoading.value = false;
      update();
      AppUtility.printLog("Fetching Last Messages Error");
      AppUtility.printLog(StringValues.formatExcError);
      AppUtility.printLog(e);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      _isLoading.value = false;
      update();
      AppUtility.printLog("Fetching Last Messages Error");
      AppUtility.printLog(StringValues.errorOccurred);
      AppUtility.printLog(exc);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    }
  }

  Future<void> _loadMore({int? page}) async {
    AppUtility.printLog("Fetching More Last Messages Request");
    _isMoreLoading.value = true;
    update();

    try {
      final response =
          await _apiProvider.getMessagesById(_auth.token, userId!, page: page);
      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        setMessageData = ChatMessageListResponse.fromJson(decodedData);

        for (var element in messageData!.results!) {
          chatController.addToAllMessages(element);
        }

        _isMoreLoading.value = false;
        update();
        AppUtility.printLog("Fetching More Messages Success");
      } else {
        _isMoreLoading.value = false;
        update();
        AppUtility.printLog("Fetching Last Messages Error");
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } on SocketException {
      _isMoreLoading.value = false;
      update();
      AppUtility.printLog("Fetching Last Messages Error");
      AppUtility.printLog(StringValues.internetConnError);
      AppUtility.showSnackBar(
          StringValues.internetConnError, StringValues.error);
    } on TimeoutException {
      _isMoreLoading.value = false;
      update();
      AppUtility.printLog("Fetching Last Messages Error");
      AppUtility.printLog(StringValues.connTimedOut);
      AppUtility.showSnackBar(StringValues.connTimedOut, StringValues.error);
    } on FormatException catch (e) {
      _isMoreLoading.value = false;
      update();
      AppUtility.printLog("Fetching Last Messages Error");
      AppUtility.printLog(StringValues.formatExcError);
      AppUtility.printLog(e);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    } catch (exc) {
      _isMoreLoading.value = false;
      update();
      AppUtility.printLog("Fetching Last Messages Error");
      AppUtility.printLog(StringValues.errorOccurred);
      AppUtility.printLog(exc);
      AppUtility.showSnackBar(StringValues.errorOccurred, StringValues.error);
    }
  }

  Future<void> fetchLatestMessages() async => await _fetchMessagesById();

  Future<void> loadMore() async =>
      await _loadMore(page: _messageData.value.currentPage! + 1);

  void markMessageAsRead() => _markMessageAsRead();
}
