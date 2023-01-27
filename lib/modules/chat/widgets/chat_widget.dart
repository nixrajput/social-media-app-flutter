import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/apis/models/entities/chat_message.dart';
import 'package:social_media_app/apis/models/entities/user.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/extensions/string_extensions.dart';
import 'package:social_media_app/global_widgets/avatar_widget.dart';
import 'package:social_media_app/global_widgets/get_time_ago_refresh_widget/get_time_ago_widget.dart';
import 'package:social_media_app/global_widgets/verified_widget.dart';
import 'package:social_media_app/modules/home/controllers/profile_controller.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget({
    Key? key,
    required this.chat,
    this.onTap,
    required this.totalLength,
    required this.index,
    required this.isOnline,
  }) : super(key: key);

  final ChatMessage chat;
  final VoidCallback? onTap;
  final int totalLength;
  final int index;
  final bool isOnline;

  String _decryptMessage(String encryptedMessage) {
    var decryptedMessage = utf8.decode(base64Decode(encryptedMessage));
    return decryptedMessage;
  }

  @override
  Widget build(BuildContext context) {
    var profile = ProfileController.find;
    var user = chat.senderId == profile.profileDetails!.user!.id
        ? chat.receiver!
        : chat.sender!;

    var isSender = chat.senderId == profile.profileDetails!.user!.id;

    return InkWell(
      onTap: onTap,
      child: Container(
        margin: Dimens.edgeInsets8_0,
        padding: Dimens.edgeInsets8,
        constraints: BoxConstraints(
          maxWidth: Dimens.screenWidth,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).bottomAppBarColor,
          borderRadius: BorderRadius.circular(Dimens.four),
          boxShadow: AppStyles.defaultShadow,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Stack(
                        children: [
                          AvatarWidget(
                            avatar: user.avatar,
                            size: Dimens.twentyFour,
                          ),
                          if (isOnline)
                            Positioned(
                              top: Dimens.two,
                              right: Dimens.two,
                              child: Container(
                                width: Dimens.twelve,
                                height: Dimens.twelve,
                                decoration: const BoxDecoration(
                                  color: ColorValues.successColor,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                        ],
                      ),
                      Dimens.boxWidth8,
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildUserUsername(context, user),
                            if (chat.mediaFile != null &&
                                chat.mediaFile!.url != null)
                              Text(
                                chat.mediaFile!.mediaType!.toTitleCase(),
                                style: AppStyles.style13Normal.copyWith(
                                  color: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .color!,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              )
                            else
                              Text(
                                _decryptMessage(chat.message!),
                                style: (!isSender && chat.seen == false)
                                    ? AppStyles.style13Normal.copyWith(
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .color!,
                                        fontWeight: FontWeight.w500,
                                      )
                                    : AppStyles.style13Normal.copyWith(
                                        color: Theme.of(context)
                                            .textTheme
                                            .subtitle1!
                                            .color!,
                                      ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Dimens.boxWidth8,
                Expanded(
                  flex: 0,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          GetTimeAgoWidget(
                            pattern: 'dd MMM',
                            date: chat.createdAt!,
                            builder: (BuildContext context, String value) =>
                                Text(
                              value,
                              style: AppStyles.style12Normal.copyWith(
                                color: Theme.of(Get.context!)
                                    .textTheme
                                    .subtitle1!
                                    .color,
                              ),
                            ),
                          ),
                          if (isSender) Dimens.boxHeight2,
                          if (isSender) _buildMessageStatus(),
                        ],
                      ),
                      Dimens.boxWidth8,
                      if (chat.receiver!.id ==
                              ProfileController.find.profileDetails!.user!.id &&
                          chat.seen == false)
                        Container(
                          width: Dimens.eight,
                          height: Dimens.eight,
                          decoration: const BoxDecoration(
                            color: ColorValues.errorColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserUsername(BuildContext context, User user) => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: RichText(
              text: TextSpan(
                text: user.uname.toLowerCase(),
                style: AppStyles.style14Bold.copyWith(
                  color: Theme.of(context).textTheme.bodyText1!.color,
                ),
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          if (user.isVerified) Dimens.boxWidth4,
          if (user.isVerified)
            VerifiedWidget(
              verifiedCategory: user.verifiedCategory!,
              size: Dimens.fourteen,
            ),
        ],
      );

  Widget _buildMessageStatus() {
    if (chat.seen == true) {
      return Icon(
        Icons.done_all,
        size: Dimens.sixTeen,
        color: ColorValues.successColor,
      );
    } else if (chat.delivered == true) {
      return Icon(
        Icons.done_all,
        size: Dimens.sixTeen,
        color: Theme.of(Get.context!).textTheme.subtitle1!.color!,
      );
    } else if (chat.sent == true) {
      return Icon(
        Icons.done,
        size: Dimens.sixTeen,
        color: Theme.of(Get.context!).textTheme.subtitle1!.color!,
      );
    }

    return Container(
      width: Dimens.sixTeen,
      height: Dimens.sixTeen,
      decoration: const BoxDecoration(
        color: ColorValues.errorColor,
        shape: BoxShape.circle,
      ),
    );
  }
}
