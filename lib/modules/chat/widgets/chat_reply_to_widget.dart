import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/apis/models/entities/chat_message.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/extensions/string_extensions.dart';
import 'package:social_media_app/modules/chat/controllers/p2p_chat_controller.dart';

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
    var p2pController = P2PChatController.find;

    return GestureDetector(
      onTap: () =>
          p2pController.scrollToCustomChatMessage(reply.id ?? reply.tempId!),
      child: Container(
        padding: EdgeInsets.all(Dimens.eight),
        decoration: BoxDecoration(
          color: Theme.of(context).textTheme.subtitle2!.color!.withOpacity(0.5),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Dimens.sixTeen),
            topRight: Radius.circular(Dimens.sixTeen),
            bottomLeft: isYourMessage
                ? Radius.circular(Dimens.sixTeen)
                : Radius.circular(Dimens.zero),
            bottomRight: isYourMessage
                ? Radius.circular(Dimens.zero)
                : Radius.circular(Dimens.sixTeen),
          ),
        ),
        constraints: BoxConstraints(
          maxWidth: Dimens.screenWidth * 0.75,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
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
                style: AppStyles.style13Normal.copyWith(
                  color: Theme.of(Get.context!).textTheme.bodyText1!.color,
                ),
              ),
            Dimens.boxHeight8,
          ],
        ),
      ),
    );
  }
}
