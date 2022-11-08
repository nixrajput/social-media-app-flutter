import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/apis/models/entities/chat_message.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/extensions/string_extensions.dart';
import 'package:social_media_app/modules/chat/controllers/p2p_chat_controller.dart';
import 'package:social_media_app/modules/home/controllers/profile_controller.dart';

class ChatReplyToWidget extends StatelessWidget {
  const ChatReplyToWidget({
    Key? key,
    required this.reply,
    required this.isYourMessage,
  }) : super(key: key);

  final ChatMessage reply;
  final bool isYourMessage;

  String _decryptMessage(String encryptedMessage) {
    var decryptedMessage = utf8.decode(base64Decode(encryptedMessage));
    return decryptedMessage;
  }

  @override
  Widget build(BuildContext context) {
    var profile = ProfileController.find.profileDetails!.user!;
    var p2pController = P2PChatController.find;

    return GestureDetector(
      onTap: () =>
          p2pController.scrollToCustomChatMessage(reply.id ?? reply.tempId!),
      child: Container(
        padding: Dimens.edgeInsets8,
        decoration: BoxDecoration(
          color: ColorValues.grayColor.withOpacity(0.25),
          borderRadius: BorderRadius.circular(Dimens.eight),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.reply,
                  color: Theme.of(Get.context!).textTheme.subtitle1!.color,
                  size: Dimens.twenty,
                ),
                Dimens.boxWidth4,
                Text(
                  'Replying to',
                  style: AppStyles.style12Normal.copyWith(
                    color: isYourMessage
                        ? ColorValues.lightGrayColor
                        : Theme.of(Get.context!).textTheme.subtitle1!.color,
                  ),
                ),
              ],
            ),
            Dimens.boxHeight4,
            Text(
              reply.senderId == profile.id
                  ? 'You'
                  : '${reply.sender!.fname} ${reply.sender!.lname}',
              style: AppStyles.style13Bold.copyWith(
                color: isYourMessage
                    ? ColorValues.primaryLightColor
                    : ColorValues.primaryColor,
              ),
            ),
            Dimens.boxHeight4,
            if (reply.mediaFile != null && reply.mediaFile!.url != null)
              Text(
                reply.mediaFile!.mediaType!.toTitleCase(),
                style: AppStyles.style13Normal.copyWith(
                  color: Theme.of(context).textTheme.subtitle1!.color!,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            if (reply.message != null && reply.message!.isNotEmpty)
              Dimens.boxHeight2,
            if (reply.message != null && reply.message!.isNotEmpty)
              Text(
                _decryptMessage(reply.message!),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppStyles.style13Normal.copyWith(
                  color: isYourMessage
                      ? ColorValues.lightBgColor
                      : Theme.of(Get.context!).textTheme.bodyText1!.color,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
