import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/apis/models/entities/chat_message.dart';
import 'package:social_media_app/apis/models/entities/profile.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/global_widgets/circular_progress_indicator.dart';
import 'package:social_media_app/modules/home/controllers/profile_controller.dart';

class ChatReplyToBox extends StatelessWidget {
  const ChatReplyToBox({
    Key? key,
    required this.message,
    required this.onClose,
  }) : super(key: key);

  final ChatMessage message;
  final VoidCallback onClose;

  String _decryptMessage(String encryptedMessage) {
    var decryptedMessage = utf8.decode(base64Decode(encryptedMessage));
    return decryptedMessage;
  }

  @override
  Widget build(BuildContext context) {
    var profile = ProfileController.find.profileDetails!.user!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildReplyBubble(profile),
              Dimens.boxHeight4,
              if (message.mediaFile != null && message.mediaFile!.url != null)
                Text(
                  message.mediaFile!.mediaType == "video" ? 'Video' : 'Image',
                  style: AppStyles.style12Normal.copyWith(
                    color: Theme.of(Get.context!).textTheme.subtitle1!.color,
                  ),
                ),
              if (message.message != null && message.message!.isNotEmpty)
                Dimens.boxHeight2,
              if (message.message != null && message.message!.isNotEmpty)
                Text(
                  _decryptMessage(message.message!),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppStyles.style13Normal.copyWith(
                    color: Theme.of(Get.context!).textTheme.bodyText1!.color,
                  ),
                ),
            ],
          ),
        ),
        if (message.mediaFile != null && message.mediaFile!.url != null)
          _buildMediaFile(
            message.mediaFile!.mediaType == "video"
                ? message.mediaFile!.thumbnail!.url!
                : message.mediaFile!.url!,
          ),
        Dimens.boxWidth4,
        GestureDetector(
          onTap: onClose,
          child: Container(
            padding: Dimens.edgeInsets4,
            decoration: BoxDecoration(
              color: Theme.of(Get.context!).bottomAppBarColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.close,
              color: Theme.of(Get.context!).textTheme.subtitle2!.color,
              size: Dimens.twenty,
            ),
          ),
        )
      ],
    );
  }

  Widget _buildReplyBubble(Profile profile) {
    var repliedUser =
        message.senderId == profile.id ? 'Yourself' : message.sender!.fname;

    return Column(
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
              color: Theme.of(Get.context!).textTheme.subtitle2!.color,
              size: Dimens.twenty,
            ),
            Dimens.boxWidth4,
            Text(
              'Replying to $repliedUser',
              style: AppStyles.style12Normal.copyWith(
                color: Theme.of(Get.context!).textTheme.subtitle2!.color,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMediaFile(String url) {
    if (url.startsWith("http") || url.startsWith("https")) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(Dimens.eight),
        child: CachedNetworkImage(
          imageUrl: message.mediaFile!.url!,
          fit: BoxFit.cover,
          width: Dimens.fourtyEight,
          height: Dimens.fourtyEight,
          progressIndicatorBuilder: (ctx, url, downloadProgress) => Container(
            width: Dimens.fourtyEight,
            height: Dimens.fourtyEight,
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
            height: Dimens.hundred * 2,
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

    return ClipRRect(
      borderRadius: BorderRadius.circular(Dimens.eight),
      child: Image.file(
        File(message.mediaFile!.url!),
        fit: BoxFit.cover,
        width: Dimens.fourtyEight,
        height: Dimens.fourtyEight,
        errorBuilder: (context, url, error) => Container(
          width: Dimens.fourtyEight,
          height: Dimens.fourtyEight,
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
}
