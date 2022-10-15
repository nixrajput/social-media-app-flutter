import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/apis/models/entities/chat_message.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/global_widgets/avatar_widget.dart';
import 'package:social_media_app/global_widgets/get_time_ago_refresh_widget/get_time_ago_widget.dart';
import 'package:social_media_app/modules/chat/widgets/bubble_type.dart';
import 'package:social_media_app/modules/chat/widgets/chat_bubble_clipper.dart';
import 'package:social_media_app/modules/home/controllers/profile_controller.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({Key? key, required this.message}) : super(key: key);

  final ChatMessage message;

  String _decryptMessage(String encryptedMessage) {
    var decryptedMessage = utf8.decode(base64Decode(encryptedMessage));
    return decryptedMessage;
  }

  Color _setBubbleColor(bool isSenderBubble) {
    if (isSenderBubble) {
      return Theme.of(Get.context!).dialogBackgroundColor.withOpacity(0.75);
    }
    return Theme.of(Get.context!).dialogBackgroundColor;
  }

  Color _setMessageColor(bool isSenderBubble) {
    // if (isSenderBubble) {
    //   return ColorValues.whiteColor;
    // }
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
    } else if (message.delivered == true || message.sent == true) {
      return Theme.of(Get.context!).textTheme.subtitle1!.color!;
    }

    return ColorValues.darkGrayColor;
  }

  @override
  Widget build(BuildContext context) {
    var profile = ProfileController.find;
    var isYourMessage = message.senderId == profile.profileDetails!.user!.id;

    return Container(
      alignment: isYourMessage ? Alignment.topRight : Alignment.topLeft,
      margin: Dimens.edgeInsetsOnlyBottom8,
      constraints: BoxConstraints(
        maxWidth: Dimens.screenWidth,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment:
            isYourMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!isYourMessage)
            AvatarWidget(
              avatar: message.sender!.avatar,
              size: Dimens.sixTeen,
            ),
          PhysicalShape(
            elevation: Dimens.two,
            clipper: ChatBubbleClipper(
              radius: Dimens.eight,
              type: isYourMessage
                  ? BubbleType.sendBubble
                  : BubbleType.receiverBubble,
            ),
            color: _setBubbleColor(isYourMessage),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: Dimens.screenWidth * 0.7,
              ),
              child: Padding(
                padding: _setPadding(isYourMessage),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: isYourMessage
                      ? CrossAxisAlignment.start
                      : CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _decryptMessage(message.message!),
                      style: AppStyles.style13Normal.copyWith(
                        color: _setMessageColor(isYourMessage),
                      ),
                    ),
                    Dimens.boxHeight8,
                    Align(
                      widthFactor: Dimens.one,
                      alignment: isYourMessage
                          ? Alignment.topLeft
                          : Alignment.topRight,
                      child: GetTimeAgoWidget(
                        date: message.createdAt!,
                        pattern: 'dd MMM',
                        builder: (BuildContext context, String value) => Text(
                          value,
                          style: AppStyles.style13Normal.copyWith(
                            fontSize: Dimens.eleven,
                            color: ColorValues.darkGrayColor,
                          ),
                        ),
                      ),
                    ),
                    if (isYourMessage)
                      Align(
                        widthFactor: Dimens.one,
                        alignment: isYourMessage
                            ? Alignment.topLeft
                            : Alignment.topRight,
                        child: Text(
                          _setMessageStatus(isYourMessage),
                          style: AppStyles.style13Normal.copyWith(
                            fontSize: Dimens.eleven,
                            color: _setMessageStatusColor(),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
          if (isYourMessage)
            AvatarWidget(
              avatar: profile.profileDetails!.user!.avatar,
              size: Dimens.sixTeen,
            ),
        ],
      ),
    );
  }
}
