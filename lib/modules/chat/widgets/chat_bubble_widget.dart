import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:social_media_app/apis/models/entities/chat_message.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/enums.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/extensions/date_extensions.dart';
import 'package:social_media_app/global_widgets/avatar_widget.dart';
import 'package:social_media_app/global_widgets/circular_progress_indicator.dart';
import 'package:social_media_app/global_widgets/swipeable_widget.dart';
import 'package:social_media_app/global_widgets/video_player_widget.dart';
import 'package:social_media_app/modules/chat/controllers/p2p_chat_controller.dart';
import 'package:social_media_app/modules/chat/views/image_viewer_screen.dart';
import 'package:social_media_app/modules/chat/widgets/chat_bubble_clipper.dart';
import 'package:social_media_app/modules/chat/widgets/chat_reply_to_widget.dart';
import 'package:social_media_app/modules/home/controllers/profile_controller.dart';
import 'package:social_media_app/utils/utility.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    Key? key,
    required this.message,
    this.onSwipeRight,
    this.onSwipeLeft,
  }) : super(key: key);

  final ChatMessage message;
  final VoidCallback? onSwipeRight;
  final VoidCallback? onSwipeLeft;

  String _decryptMessage(String encryptedMessage) {
    var decryptedMessage = utf8.decode(base64Decode(encryptedMessage));
    return decryptedMessage;
  }

  Color _setBubbleColor(bool isSenderBubble) {
    if (isSenderBubble) {
      return ColorValues.darkChatBubbleColor;
    }
    return Theme.of(Get.context!).dialogBackgroundColor;
  }

  Color _setMessageColor(bool isSenderBubble) {
    if (isSenderBubble) {
      return ColorValues.lightBgColor;
    }
    return Theme.of(Get.context!).textTheme.bodyText1!.color!;
  }

  EdgeInsets _setPadding(bool isSenderBubble) {
    if (isSenderBubble) {
      return EdgeInsets.only(
        top: Dimens.eight,
        bottom: Dimens.sixTeen,
        left: Dimens.eight,
        right: Dimens.sixTeen,
      );
    } else {
      return EdgeInsets.only(
        top: Dimens.eight,
        bottom: Dimens.sixTeen,
        left: Dimens.sixTeen,
        right: Dimens.eight,
      );
    }
  }

  String _setMessageStatus(bool isSenderBubble) {
    if (isSenderBubble) {
      if (message.seen == true) {
        return 'Seen';
      } else if (message.delivered == true) {
        return 'Delivered';
      } else if (message.sent == true) {
        return 'Sent';
      } else {
        return 'Pending';
      }
    } else {
      return '';
    }
  }

  Color _setMessageStatusColor() {
    if (message.seen == true) {
      return ColorValues.successColor;
    } else if (message.delivered == true) {
      return Theme.of(Get.context!).textTheme.subtitle1!.color!;
    }

    return ColorValues.lightGrayColor;
  }

  @override
  Widget build(BuildContext context) {
    var profile = ProfileController.find;
    var isYourMessage = message.senderId == profile.profileDetails!.user!.id;

    return NxSwipeableWidget(
      onLeftSwipe: (details) => onSwipeLeft?.call(),
      onRightSwipe: (details) => onSwipeRight?.call(),
      iconOnLeftSwipe: Icons.reply,
      iconOnRightSwipe: Icons.reply,
      iconSize: Dimens.twentyFour,
      child: Container(
        alignment: isYourMessage ? Alignment.topRight : Alignment.topLeft,
        margin: Dimens.edgeInsetsOnlyBottom8,
        constraints: BoxConstraints(
          maxWidth: Dimens.screenWidth,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!isYourMessage)
              AvatarWidget(
                avatar: message.sender!.avatar,
                size: Dimens.sixTeen,
              ),
            if (isYourMessage && _setMessageStatus(isYourMessage) == 'Pending')
              Padding(
                padding: EdgeInsets.only(bottom: Dimens.eight),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    NxCircularProgressIndicator(
                      size: Dimens.twenty,
                      strokeWidth: Dimens.one,
                      color: ColorValues.lightGrayColor,
                    ),
                    Dimens.boxWidth8,
                  ],
                ),
              ),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onLongPress: showChatDetailsAndOptions,
              child: PhysicalShape(
                elevation: Dimens.two,
                clipper: ChatBubbleClipper(
                  radius: Dimens.eight,
                  type: isYourMessage
                      ? BubbleType.sendBubble
                      : BubbleType.receiverBubble,
                ),
                color: _setBubbleColor(isYourMessage),
                child: Container(
                  margin: _setPadding(isYourMessage),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimens.eight),
                  ),
                  constraints: BoxConstraints(
                    maxWidth: Dimens.screenWidth * 0.7,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (message.replyTo != null &&
                          message.replyTo!.id != null)
                        Padding(
                          padding: Dimens.edgeInsets0.copyWith(
                            bottom: Dimens.four,
                          ),
                          child: ChatReplyToWidget(
                            reply: message.replyTo!,
                            isYourMessage: isYourMessage,
                          ),
                        ),
                      if (message.mediaFile != null &&
                          message.mediaFile!.url != null)
                        Padding(
                          padding: Dimens.edgeInsets0,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(Dimens.eight),
                            child: _buildMediaFile(),
                          ),
                        ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (message.message != null &&
                              message.message!.isNotEmpty)
                            Text(
                              _decryptMessage(message.message!),
                              style: AppStyles.style13Normal.copyWith(
                                color: _setMessageColor(isYourMessage),
                              ),
                            ),
                          Dimens.boxHeight8,
                          Text(
                            message.createdAt!.getTime(),
                            style: AppStyles.style12Normal.copyWith(
                              fontSize: Dimens.ten,
                              color: ColorValues.grayColor,
                            ),
                          ),
                          if (isYourMessage)
                            Text(
                              _setMessageStatus(isYourMessage),
                              style: AppStyles.style12Normal.copyWith(
                                fontSize: Dimens.ten,
                                color: _setMessageStatusColor(),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (!isYourMessage && _setMessageStatus(isYourMessage) == 'Pending')
              Padding(
                padding: EdgeInsets.only(bottom: Dimens.eight),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Dimens.boxWidth8,
                    NxCircularProgressIndicator(
                      size: Dimens.twenty,
                      strokeWidth: Dimens.one,
                      color: ColorValues.lightGrayColor,
                    ),
                  ],
                ),
              ),
            if (isYourMessage)
              AvatarWidget(
                avatar: profile.profileDetails!.user!.avatar,
                size: Dimens.sixTeen,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildMediaFile() {
    if (message.mediaFile!.mediaType == "video") {
      return NxVideoPlayerWidget(
        url: message.mediaFile!.url!,
        thumbnailUrl: message.mediaFile!.thumbnail!.url,
        showControls: true,
      );
    }
    if (message.mediaFile!.url!.startsWith("http") ||
        message.mediaFile!.url!.startsWith("https")) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () =>
            Get.to(() => ImageViewerScreen(url: message.mediaFile!.url!)),
        child: CachedNetworkImage(
          imageUrl: message.mediaFile!.url!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: Dimens.hundred * 2.4,
          progressIndicatorBuilder: (ctx, url, downloadProgress) => Container(
            width: double.infinity,
            height: Dimens.hundred * 2.4,
            decoration: BoxDecoration(
              color: ColorValues.grayColor.withOpacity(0.25),
            ),
            child: Center(
              child: NxCircularProgressIndicator(
                value: downloadProgress.progress,
              ),
            ),
          ),
          errorWidget: (ctx, url, err) => Container(
            width: double.infinity,
            height: Dimens.hundred * 2.4,
            decoration: BoxDecoration(
              color: ColorValues.grayColor.withOpacity(0.25),
            ),
            child: const Center(
              child: Icon(
                Icons.info,
                color: ColorValues.errorColor,
              ),
            ),
          ),
        ),
      );
    }

    return Image.file(
      File(message.mediaFile!.url!),
      fit: BoxFit.cover,
      width: double.infinity,
      height: Dimens.hundred * 2.4,
      errorBuilder: (context, url, error) => Container(
        width: double.infinity,
        height: Dimens.hundred * 2.4,
        decoration: BoxDecoration(
          color: ColorValues.grayColor.withOpacity(0.25),
        ),
        child: const Center(
          child: Icon(
            Icons.info,
            color: ColorValues.errorColor,
          ),
        ),
      ),
    );
  }

  showChatDetailsAndOptions() {
    var controller = P2PChatController.find;
    var currentUserId = controller.profile.profileDetails!.user!.id;

    AppUtility.showBottomSheet(
      children: [
        Padding(
          padding: Dimens.edgeInsets8_16,
          child: Text(
            DateFormat('dd MMM yyyy, hh:mm a')
                .format(message.createdAt!.toLocal()),
            style: AppStyles.style14Normal.copyWith(
              color: Theme.of(Get.context!).textTheme.subtitle2!.color,
            ),
          ),
        ),
        if (message.senderId == currentUserId)
          ListTile(
            onTap: () {
              AppUtility.closeBottomSheet();
              controller.deleteMessage(message.id!);
            },
            leading: const Icon(Icons.delete),
            title: Text(
              StringValues.delete,
              style: AppStyles.style16Bold.copyWith(
                color: Theme.of(Get.context!).textTheme.bodyText1!.color,
              ),
            ),
          ),
        ListTile(
          onTap: () {
            AppUtility.closeBottomSheet();
            onSwipeRight?.call();
          },
          leading: const Icon(Icons.reply),
          title: Text(
            StringValues.reply,
            style: AppStyles.style16Bold.copyWith(
              color: Theme.of(Get.context!).textTheme.bodyText1!.color,
            ),
          ),
        ),
        ListTile(
          onTap: AppUtility.closeBottomSheet,
          leading: const Icon(Icons.report),
          title: Text(
            StringValues.report,
            style: AppStyles.style16Bold.copyWith(
              color: Theme.of(Get.context!).textTheme.bodyText1!.color,
            ),
          ),
        ),
      ],
    );
  }
}
