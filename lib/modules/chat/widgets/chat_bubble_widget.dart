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

class ChatBubble extends StatefulWidget {
  const ChatBubble({
    Key? key,
    required this.message,
    this.onSwipeRight,
    this.onSwipeLeft,
  }) : super(key: key);

  final ChatMessage message;
  final VoidCallback? onSwipeRight;
  final VoidCallback? onSwipeLeft;

  @override
  State<ChatBubble> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  var tapped = false;

  void _onTap() {
    setState(() {
      tapped = !tapped;
    });
  }

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
    if (widget.message.seen == true) {
      return 'Seen';
    } else if (widget.message.delivered == true) {
      return 'Delivered';
    } else if (widget.message.sent == true) {
      return 'Sent';
    } else {
      return 'Sending';
    }
  }

  Color _setMessageStatusColor() {
    if (widget.message.seen == true) {
      return ColorValues.successColor;
    } else if (widget.message.delivered == true) {
      return Theme.of(Get.context!).textTheme.subtitle1!.color!;
    }

    return Theme.of(Get.context!).textTheme.subtitle2!.color!;
  }

  @override
  Widget build(BuildContext context) {
    var profile = ProfileController.find;
    var isYourMessage =
        widget.message.senderId == profile.profileDetails!.user!.id;

    return NxSwipeableWidget(
      onLeftSwipe: (details) => widget.onSwipeLeft?.call(),
      onRightSwipe: (details) => widget.onSwipeRight?.call(),
      iconOnLeftSwipe: Icons.reply,
      iconOnRightSwipe: Icons.reply,
      iconSize: Dimens.twentyFour,
      child: Container(
        alignment: isYourMessage ? Alignment.topRight : Alignment.topLeft,
        margin: Dimens.edgeInsetsOnlyBottom8,
        constraints: BoxConstraints(
          maxWidth: Dimens.screenWidth,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (tapped) _buildChatTime(isYourMessage, context),
            _buildChatBubbleWithReply(isYourMessage, profile),
            if (tapped && isYourMessage) _buildChatSeenStatus(isYourMessage),
          ],
        ),
      ),
    );
  }

  Column _buildChatSeenStatus(bool isYourMessage) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: isYourMessage ? Dimens.zero : Dimens.fourtyEight,
            right: isYourMessage ? Dimens.fourtyEight : Dimens.zero,
          ),
          child: Text(
            _setMessageStatus(isYourMessage),
            style: AppStyles.style12Bold.copyWith(
              color: _setMessageStatusColor(),
            ),
          ),
        ),
      ],
    );
  }

  Column _buildChatTime(bool isYourMessage, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment:
          isYourMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: isYourMessage ? Dimens.zero : Dimens.fourtyEight,
            right: isYourMessage ? Dimens.fourtyEight : Dimens.zero,
          ),
          child: Text(
            widget.message.createdAt!.getDateTime().toUpperCase(),
            style: AppStyles.style12Normal.copyWith(
              fontSize: Dimens.ten,
              color: Theme.of(context).textTheme.subtitle2!.color,
            ),
          ),
        ),
        Dimens.boxHeight4,
      ],
    );
  }

  Widget _buildChatBubbleWithReply(
      bool isYourMessage, ProfileController profile) {
    if (widget.message.replyTo != null && widget.message.replyTo!.id != null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment:
            isYourMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.message.replyTo != null &&
              widget.message.replyTo!.id != null)
            _buildReplyBubble(isYourMessage, profile),
          Transform.translate(
            offset: Offset(0, -Dimens.eight),
            child: _buildChatBubble(isYourMessage, profile),
          ),
        ],
      );
    }

    return _buildChatBubble(isYourMessage, profile);
  }

  Row _buildChatBubble(bool isYourMessage, ProfileController profile) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment:
          isYourMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (!isYourMessage)
          AvatarWidget(
            avatar: widget.message.sender!.avatar,
            size: Dimens.sixTeen,
          ),
        if (isYourMessage && _setMessageStatus(isYourMessage) == 'Sending')
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
          onTap: _onTap,
          child: PhysicalShape(
            clipBehavior: Clip.hardEdge,
            elevation: Dimens.zero,
            clipper: ChatBubbleClipper(
              radius: Dimens.sixTeen,
              nipSize: Dimens.six,
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
                  if (widget.message.mediaFile != null &&
                      widget.message.mediaFile!.url != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(Dimens.sixTeen),
                      child: _buildMediaFile(),
                    ),
                  if (widget.message.message != null &&
                      widget.message.message!.isNotEmpty)
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: isYourMessage
                          ? CrossAxisAlignment.start
                          : CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (widget.message.mediaFile != null &&
                            widget.message.mediaFile!.url != null)
                          Dimens.boxHeight8,
                        Text(
                          _decryptMessage(widget.message.message!),
                          style: AppStyles.style13Normal.copyWith(
                            color: _setMessageColor(isYourMessage),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
        if (!isYourMessage && _setMessageStatus(isYourMessage) == 'Sending')
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
    );
  }

  Padding _buildReplyBubble(bool isYourMessage, ProfileController profile) {
    var replyingUser =
        widget.message.senderId == profile.profileDetails!.user!.id
            ? 'You'
            : widget.message.sender!.fname;

    var repliedUser = (widget.message.replyTo!.senderId ==
                profile.profileDetails!.user!.id &&
            widget.message.senderId == profile.profileDetails!.user!.id)
        ? 'Yourself'
        : widget.message.replyTo!.senderId == profile.profileDetails!.user!.id
            ? 'You'
            : widget.message.replyTo!.sender!.fname;

    return Padding(
      padding: EdgeInsets.only(
        left: isYourMessage ? Dimens.zero : Dimens.fourty,
        right: isYourMessage ? Dimens.fourty : Dimens.zero,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment:
            isYourMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: isYourMessage ? Dimens.zero : Dimens.eight,
              right: isYourMessage ? Dimens.eight : Dimens.zero,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.reply,
                  color: Theme.of(Get.context!).textTheme.subtitle2!.color,
                  size: Dimens.twenty,
                ),
                Dimens.boxWidth4,
                Text(
                  '$replyingUser replied to $repliedUser',
                  style: AppStyles.style12Normal.copyWith(
                    color: Theme.of(Get.context!).textTheme.subtitle2!.color,
                  ),
                ),
              ],
            ),
          ),
          ChatReplyToWidget(
            reply: widget.message.replyTo!,
            isYourMessage: isYourMessage,
          ),
        ],
      ),
    );
  }

  Widget _buildMediaFile() {
    if (widget.message.mediaFile!.mediaType == "video") {
      return NxVideoPlayerWidget(
        url: widget.message.mediaFile!.url!,
        thumbnailUrl: widget.message.mediaFile!.thumbnail!.url,
        showControls: true,
      );
    }
    if (widget.message.mediaFile!.url!.startsWith("http") ||
        widget.message.mediaFile!.url!.startsWith("https")) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Get.to(
            () => ImageViewerScreen(url: widget.message.mediaFile!.url!)),
        child: CachedNetworkImage(
          imageUrl: widget.message.mediaFile!.url!,
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
      File(widget.message.mediaFile!.url!),
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
                .format(widget.message.createdAt!.toLocal())
                .toUpperCase(),
            style: AppStyles.style13Normal.copyWith(
              color: Theme.of(Get.context!).textTheme.subtitle1!.color,
            ),
          ),
        ),
        if (widget.message.senderId == currentUserId &&
            widget.message.createdAt!.isAfter(
              DateTime.now().subtract(const Duration(days: 7)),
            ))
          ListTile(
            onTap: () {
              AppUtility.closeBottomSheet();
              controller.deleteMessage(widget.message.id!);
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
            widget.onSwipeRight?.call();
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
