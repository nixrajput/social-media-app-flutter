import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/apis/models/entities/chat_message.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/global_widgets/avatar_widget.dart';
import 'package:social_media_app/global_widgets/get_time_ago_refresh_widget/get_time_ago_widget.dart';
import 'package:social_media_app/modules/chat/controllers/chat_controller.dart';
import 'package:social_media_app/modules/home/controllers/profile_controller.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget(
      {Key? key,
      required this.chat,
      this.onTap,
      required this.totalLength,
      required this.index})
      : super(key: key);

  final ChatMessage chat;
  final VoidCallback? onTap;
  final int totalLength;
  final int index;

  String _decryptMessage(String encryptedMessage) {
    var decryptedMessage = utf8.decode(base64Decode(encryptedMessage));
    return decryptedMessage;
  }

  @override
  Widget build(BuildContext context) {
    var profile = ProfileController.find;
    var user = chat.sender!.id == profile.profileDetails!.user!.id
        ? chat.receiver!
        : chat.sender!;

    var isSender = chat.sender!.id == profile.profileDetails!.user!.id;
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: Dimens.zero),
            padding: Dimens.edgeInsets8,
            constraints: BoxConstraints(
              maxWidth: Dimens.screenWidth,
            ),
            decoration: BoxDecoration(
              color: chat.receiver!.id ==
                          ProfileController.find.profileDetails!.user!.id &&
                      chat.seen == false
                  ? ColorValues.primaryColor.withOpacity(0.15)
                  : Theme.of(Get.context!).dialogBackgroundColor,
              borderRadius: (index == 0 || index == totalLength - 1)
                  ? BorderRadius.only(
                      topLeft: Radius.circular(
                          index == 0 ? Dimens.eight : Dimens.zero),
                      topRight: Radius.circular(
                          index == 0 ? Dimens.eight : Dimens.zero),
                      bottomLeft: Radius.circular(index == totalLength - 1
                          ? Dimens.eight
                          : Dimens.zero),
                      bottomRight: Radius.circular(index == totalLength - 1
                          ? Dimens.eight
                          : Dimens.zero),
                    )
                  : const BorderRadius.all(Radius.zero),
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
                              // Positioned(
                              //   top: Dimens.two,
                              //   right: Dimens.two,
                              //   child: Container(
                              //     width: Dimens.twelve,
                              //     height: Dimens.twelve,
                              //     decoration: const BoxDecoration(
                              //       color: ColorValues.successColor,
                              //       shape: BoxShape.circle,
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                          Dimens.boxWidth8,
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  user.uname,
                                  style: AppStyles.style13Bold,
                                ),
                                Text(
                                  _decryptMessage(chat.message!),
                                  style: AppStyles.style13Normal,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Dimens.boxWidth8,
                    Expanded(
                      flex: 0,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GetTimeAgoWidget(
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
                          if (isSender)
                            Text(
                              _setMessageStatus(),
                              style: AppStyles.style13Normal.copyWith(
                                fontSize: Dimens.eleven,
                                color: _setMessageStatusColor(),
                              ),
                            )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (index != totalLength - 1) Dimens.divider,
        ],
      ),
    );
  }

  String _setMessageStatus() {
    if (chat.seen == true) {
      return 'Seen';
    } else if (chat.delivered == true) {
      return 'Delivered';
    } else if (chat.sent == true) {
      return 'Sent';
    }

    return 'Pending';
  }

  Color _setMessageStatusColor() {
    if (chat.seen == true) {
      return ColorValues.successColor;
    } else if (chat.delivered == true || chat.sent == true) {
      return Theme.of(Get.context!).textTheme.subtitle1!.color!;
    }

    return ColorValues.darkGrayColor;
  }
}
