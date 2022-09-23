import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:social_media_app/apis/models/entities/chat_message.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/global_widgets/avatar_widget.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget({Key? key, required this.chat, this.onTap})
      : super(key: key);

  final ChatMessage chat;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: Dimens.edgeInsets0,
        margin: Dimens.edgeInsetsOnlyBottom16,
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
                            avatar: chat.sender!.avatar,
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
                              chat.sender!.uname,
                              style: AppStyles.style13Normal.copyWith(
                                fontWeight: chat.seen == true
                                    ? FontWeight.w400
                                    : FontWeight.w700,
                              ),
                            ),
                            Text(
                              chat.message!,
                              style: AppStyles.style13Normal.copyWith(
                                fontWeight: chat.seen == true
                                    ? FontWeight.w400
                                    : FontWeight.w700,
                              ),
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
                  child: Text(
                    GetTimeAgo.parse(chat.createdAt!),
                    style: AppStyles.style12Normal.copyWith(
                      color: chat.seen == true
                          ? Theme.of(Get.context!).textTheme.subtitle1!.color
                          : Theme.of(Get.context!).textTheme.bodyText1!.color,
                      fontWeight:
                          chat.seen == true ? FontWeight.w400 : FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
