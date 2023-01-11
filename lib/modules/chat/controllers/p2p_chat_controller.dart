import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cloudinary/cloudinary.dart';
import 'package:flutter/material.dart' as material;
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_app/apis/models/entities/chat_message.dart';
import 'package:social_media_app/apis/models/entities/media_file.dart';
import 'package:social_media_app/apis/models/entities/media_file_message.dart';
import 'package:social_media_app/apis/models/entities/post_media_file.dart';
import 'package:social_media_app/apis/models/entities/user.dart';
import 'package:social_media_app/apis/models/responses/chat_message_list_response.dart';
import 'package:social_media_app/apis/providers/api_provider.dart';
import 'package:social_media_app/apis/providers/socket_api_provider.dart';
import 'package:social_media_app/app_services/auth_service.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/secrets.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/helpers/global_string_key.dart';
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

  final String kChatDataKey = 'chatData';

  final messageTextController = material.TextEditingController();
  final scrollController = material.ScrollController();

  final _isLoading = false.obs;
  final _scrolledToBottom = true.obs;
  final _isMoreLoading = false.obs;
  final _message = ''.obs;
  final _replyTo = ChatMessage().obs;
  final _chatMessages = <ChatMessage>[].obs;
  final _messageData = const ChatMessageListResponse().obs;
  final _mediaFileMessages = RxList<MediaFileMessage>();
  final _isTyping = false.obs;

  bool get isLoading => _isLoading.value;

  bool get isMoreLoading => _isMoreLoading.value;

  bool get scrolledToBottom => _scrolledToBottom.value;

  String get message => _message.value;

  ChatMessage get replyTo => _replyTo.value;

  List<MediaFileMessage>? get mediaFileMessages => _mediaFileMessages;

  ChatMessageListResponse? get messageData => _messageData.value;

  List<ChatMessage> get chatMessages => _chatMessages;

  bool get isTyping => _isTyping.value;

  void setIsTyping(bool value) {
    _isTyping.value = value;
  }

  /// Setters
  set setMessageData(ChatMessageListResponse response) =>
      _messageData.value = response;

  User? user;

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
    scrollController.animateTo(
      scrollController.position.minScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: material.Curves.easeOut,
    );
  }

  void scrollToFirst() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: material.Curves.easeOut,
    );
  }

  void scrollToCustomChatMessage(String messageId) async {
    var dataKey = GlobalStringKey(messageId);
    if (dataKey.currentContext != null) {
      var renderedObj = dataKey.currentContext!.findRenderObject()!;
      await scrollController.position.ensureVisible(
        renderedObj,
        alignment: 0.5,
        duration: const Duration(milliseconds: 300),
        curve: material.Curves.easeOut,
      );
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
        AppUtility.log('Uploading Thumbnail : $progress %');
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
          AppUtility.log('Uploading Video : $progress %');
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
      AppUtility.log(err);
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
          AppUtility.log('Uploading Image : $progress %');
        },
      );
      return {
        "public_id": res.publicId,
        "url": res.secureUrl,
        "mediaType": "image"
      };
    } catch (err) {
      AppUtility.log('Image upload failed. Error: $err', tag: 'error');
      AppUtility.showSnackBar('Image upload failed.', StringValues.error);
      return null;
    }
  }

  void addTempMessage(ChatMessage message) {
    _chatMessages.add(message);
    update();
    chatController.addMessageToLastMessagesList(message);
  }

  void sendMessage() async {
    material.FocusManager.instance.primaryFocus!.unfocus();

    if (_mediaFileMessages.isNotEmpty) {
      for (var mediaFileMessage in _mediaFileMessages) {
        var encryptedMessage =
            base64Encode(utf8.encode(mediaFileMessage.message ?? ''));
        var mediaFile = mediaFileMessage.file;

        if (FileUtility.isVideoFile(mediaFile.path)) {
          var compressedFile = await FileUtility.compressVideo(mediaFile.path);
          var thumbnailFile =
              await FileUtility.getVideoThumbnail(mediaFile.path);

          if (compressedFile != null && thumbnailFile != null) {
            var tempId = AppUtility.generateUid(10);

            var tempMessage = ChatMessage(
              tempId: tempId,
              senderId: profile.profileDetails!.user!.id,
              receiverId: user!.id,
              message: encryptedMessage,
              mediaFile: PostMediaFile(
                mediaType: 'video',
                url: compressedFile.path,
                thumbnail: MediaFile(url: thumbnailFile.path),
              ),
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
              seen: false,
              sender: null,
              receiver: null,
            );

            addTempMessage(tempMessage);

            if (!_socketApiProvider.isConnected) {
              await _socketApiProvider.init();
            }

            var urlResult = await _uploadVideo(compressedFile, thumbnailFile);

            if (urlResult != null) {
              AppUtility.log('Sending message');
              _socketApiProvider.sendJson({
                "type": "send-message",
                "payload": {
                  "message": encryptedMessage,
                  "receiverId": user!.id,
                  "tempId": tempId,
                  "mediaFile": urlResult,
                  "replyTo": _replyTo.value.id,
                },
              });
            }
          }
        } else {
          var compressedFile = await FileUtility.compressImage(mediaFile.path);

          if (compressedFile != null) {
            var tempId = AppUtility.generateUid(10);

            var tempMessage = ChatMessage(
              tempId: tempId,
              senderId: profile.profileDetails!.user!.id,
              receiverId: user!.id,
              message: encryptedMessage,
              mediaFile: PostMediaFile(
                mediaType: 'image',
                url: compressedFile.path,
              ),
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
              seen: false,
              sender: null,
              receiver: null,
            );

            addTempMessage(tempMessage);

            if (!_socketApiProvider.isConnected) {
              await _socketApiProvider.init();
            }

            var urlResult = await _uploadImage(compressedFile);

            if (urlResult != null) {
              AppUtility.log('Sending message');
              _socketApiProvider.sendJson({
                "type": "send-message",
                "payload": {
                  "message": encryptedMessage,
                  "receiverId": user!.id,
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
      receiverId: user!.id,
      message: encryptedMessage,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      seen: false,
      sender: null,
      receiver: null,
    );

    addTempMessage(tempMessage);

    if (!_socketApiProvider.isConnected) {
      await _socketApiProvider.init();
    }

    AppUtility.log('Sending message');
    _socketApiProvider.sendJson({
      "type": "send-message",
      "payload": {
        "message": encryptedMessage,
        "receiverId": user!.id,
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
    user = Get.arguments[0];
    if (user != null) {
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

  void _getData() async {
    var currentUserId = profile.profileDetails!.user!.id;

    var chatBox = kChatDataKey + user!.id + currentUserId;

    await Hive.openBox<ChatMessage>(chatBox);

    Hive.box<ChatMessage>(chatBox).watch().listen((event) async {
      if (event.deleted) {
        AppUtility.log('Deleted message ${event.key}');

        _chatMessages.removeWhere((element) =>
            element.id == event.key || element.tempId == event.key);
        _chatMessages.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
        update();

        if (_chatMessages.isNotEmpty) {
          var lastMessage = _chatMessages[_chatMessages.length - 1];
          await chatController.saveLastMessageToLocalDB(lastMessage);
        }
      } else {
        var message = event.value;
        var tempMessage = _chatMessages.firstWhereOrNull((element) =>
            element.id == message.id || element.tempId == message.tempId);
        if (tempMessage != null) {
          var updatedMessage = tempMessage.copyWith(
            id: message.id,
            sender: message.sender,
            receiver: message.receiver,
            replyTo: message.replyTo,
            sent: message.sent,
            sentAt: message.sentAt,
            delivered: message.delivered,
            deliveredAt: message.deliveredAt,
            seen: message.seen,
            seenAt: message.seenAt,
            createdAt: message.createdAt,
            updatedAt: message.updatedAt,
          );
          _chatMessages.removeWhere((element) =>
              element.id == message.id || element.tempId == message.tempId);
          _chatMessages.add(updatedMessage);
          _chatMessages.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
        } else {
          _chatMessages.add(message);
          _chatMessages.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
        }

        update();
      }
    });

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
        'receiverId': user!.id,
        'status': status,
      }
    });
  }

  void _markMessageAsRead() async {
    if (_chatMessages.isNotEmpty) {
      var unreadMessages = _chatMessages
          .where((element) =>
              (element.senderId == user!.id &&
                  element.receiverId == profile.profileDetails!.user!.id) &&
              element.seen == false)
          .toList();
      if (unreadMessages.isNotEmpty) {
        AppUtility.log('Marking message as read');
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
    _isLoading.value = true;
    update();

    try {
      final response =
          await _apiProvider.getMessagesById(_auth.token, user!.id);

      if (response.isSuccessful) {
        final decodedData = response.data;
        setMessageData = ChatMessageListResponse.fromJson(decodedData);

        for (var element in messageData!.results!) {
          await chatController.saveChatDataToLocalDB(element);
        }

        _isLoading.value = false;
        update();
      } else {
        final decodedData = response.data;
        _isLoading.value = false;
        update();
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } catch (exc) {
      _isLoading.value = false;
      update();
      AppUtility.showSnackBar('Error: ${exc.toString()}', StringValues.error);
    }
  }

  Future<void> _loadMore() async {
    _isMoreLoading.value = true;
    update();

    var page = _messageData.value.currentPage! + 1;

    try {
      final response =
          await _apiProvider.getMessagesById(_auth.token, user!.id, page: page);

      if (response.isSuccessful) {
        final decodedData = response.data;
        setMessageData = ChatMessageListResponse.fromJson(decodedData);

        for (var element in messageData!.results!) {
          await chatController.saveChatDataToLocalDB(element);
        }

        _isMoreLoading.value = false;
        update();
      } else {
        final decodedData = response.data;
        _isMoreLoading.value = false;
        update();
        AppUtility.showSnackBar(
          decodedData[StringValues.message],
          StringValues.error,
        );
      }
    } catch (exc) {
      _isLoading.value = false;
      update();
      AppUtility.showSnackBar('Error: ${exc.toString()}', StringValues.error);
    }
  }

  Future<void> fetchLatestMessages() async => await _fetchMessagesById();

  Future<void> loadMore() async => await _loadMore();

  void markMessageAsRead() => _markMessageAsRead();
}
