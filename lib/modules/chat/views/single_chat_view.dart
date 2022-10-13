import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/apis/models/entities/chat_message.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/extensions/string_extensions.dart';
import 'package:social_media_app/global_widgets/avatar_widget.dart';
import 'package:social_media_app/global_widgets/circular_progress_indicator.dart';
import 'package:social_media_app/global_widgets/custom_app_bar.dart';
import 'package:social_media_app/global_widgets/custom_refresh_indicator.dart';
import 'package:social_media_app/global_widgets/get_time_ago_refresh_widget/get_time_ago_widget.dart';
import 'package:social_media_app/global_widgets/primary_icon_btn.dart';
import 'package:social_media_app/global_widgets/primary_text_btn.dart';
import 'package:social_media_app/modules/chat/controllers/chat_controller.dart';
import 'package:social_media_app/modules/chat/controllers/single_chat_controller.dart';
import 'package:social_media_app/modules/chat/widgets/bubble_type.dart';
import 'package:social_media_app/modules/chat/widgets/chat_bubble_clipper.dart';
import 'package:social_media_app/modules/home/controllers/profile_controller.dart';
import 'package:social_media_app/utils/utility.dart';

class SingleChatView extends StatelessWidget {
  const SingleChatView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: GetBuilder<SingleChatController>(
            builder: (logic) {
              if (!logic.initialized) {
                return const Center(child: NxCircularProgressIndicator());
              }
              return SizedBox(
                width: Dimens.screenWidth,
                height: Dimens.screenHeight,
                child: NxRefreshIndicator(
                  onRefresh: logic.fetchLatestMessages,
                  showProgress: false,
                  child: Stack(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          NxAppBar(
                            padding: Dimens.edgeInsets8_16,
                            leading: Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    logic.username ?? '',
                                    style: AppStyles.style18Bold,
                                  ),
                                  const Spacer(),
                                  // NxIconButton(
                                  //   icon: Icons.more_vert,
                                  //   iconColor: Theme.of(context)
                                  //       .textTheme
                                  //       .bodyText1!
                                  //       .color,
                                  //   onTap: () {},
                                  // ),
                                ],
                              ),
                            ),
                          ),
                          Dimens.boxHeight8,
                          _buildBody(logic),
                        ],
                      ),
                      Positioned(
                        bottom: Dimens.zero,
                        left: Dimens.zero,
                        right: Dimens.zero,
                        child: Container(
                          color: Theme.of(Get.context!)
                              .dialogTheme
                              .backgroundColor,
                          width: Dimens.screenWidth,
                          height: Dimens.fourtyEight,
                          padding: Dimens.edgeInsets0_8,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              NxIconButton(
                                icon: Icons.emoji_emotions_outlined,
                                iconSize: Dimens.twentyFour,
                                onTap: () {},
                              ),
                              Dimens.boxWidth8,
                              Expanded(
                                child: TextFormField(
                                  controller: logic.messageTextController,
                                  onChanged: (value) =>
                                      logic.onChangedText(value),
                                  decoration: InputDecoration(
                                    hintText:
                                        StringValues.message.toTitleCase(),
                                    hintStyle: AppStyles.style14Normal.copyWith(
                                      color: Theme.of(Get.context!)
                                          .textTheme
                                          .subtitle1!
                                          .color,
                                    ),
                                    border: InputBorder.none,
                                  ),
                                  minLines: 1,
                                  maxLines: 1,
                                  style: AppStyles.style14Normal.copyWith(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .color,
                                  ),
                                ),
                              ),
                              Dimens.boxWidth8,
                              if (logic.message.isNotEmpty)
                                NxIconButton(
                                  icon: Icons.send,
                                  iconColor: ColorValues.primaryColor,
                                  iconSize: Dimens.twentyFour,
                                  onTap: logic.sendMessage,
                                )
                              else
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    NxIconButton(
                                      icon: Icons.attach_file_outlined,
                                      iconSize: Dimens.twentyFour,
                                      iconColor: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .color,
                                      onTap: () {},
                                      //onTap: _showCreatePostOptions,
                                    )
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ),
                      if (logic.scrolledToBottom == false)
                        Positioned(
                          bottom: Dimens.hundred,
                          right: Dimens.sixTeen,
                          child: Container(
                            padding: Dimens.edgeInsets8,
                            decoration: const BoxDecoration(
                                color: ColorValues.primaryColor,
                                shape: BoxShape.circle),
                            child: NxIconButton(
                              icon: Icons.arrow_downward,
                              iconSize: Dimens.twentyFour,
                              iconColor: ColorValues.whiteColor,
                              onTap: logic.scrollToLast,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildBody(SingleChatController logic) {
    if (logic.isLoading) {
      return const Center(child: NxCircularProgressIndicator());
    }

    final currentUser = logic.profile.profileDetails!.user!;

    return Expanded(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        reverse: true,
        controller: logic.scrollController,
        padding: Dimens.edgeInsets0_16,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GetBuilder<ChatController>(
              builder: (chatsLogic) {
                chatsLogic.allMessages
                    .sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
                var filteredMessages = chatsLogic.allMessages
                    .where((element) =>
                        (element.senderId == currentUser.id &&
                            element.receiverId == logic.userId) ||
                        (element.senderId == logic.userId &&
                            element.receiver!.id == currentUser.id))
                    .toList();

                if (logic.scrolledToBottom) {
                  Future.delayed(const Duration(milliseconds: 100), () {
                    logic.markMessageAsRead();
                  });
                }

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (logic.messageData!.hasNextPage!)
                      Center(
                        child: NxTextButton(
                          label: 'Load older messages',
                          onTap: () => logic.loadMore(),
                          labelStyle: AppStyles.style14Bold.copyWith(
                            color: ColorValues.primaryLightColor,
                          ),
                          padding: Dimens.edgeInsets8_0,
                        ),
                      ),
                    ListView.builder(
                      itemCount: filteredMessages.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final message = filteredMessages[index];
                        return ChatBubble(
                          message: message,
                        );
                      },
                    ),
                  ],
                );
              },
            ),
            Dimens.boxHeight60,
          ],
        ),
      ),
    );
  }

  void _showCreatePostOptions() => AppUtility.showBottomSheet(
        [
          ListTile(
            onTap: () {
              AppUtility.closeBottomSheet();
              //CreatePostController.find.captureImage();
            },
            leading: const Icon(Icons.camera),
            title: Text(
              StringValues.captureImage,
              style: AppStyles.style16Bold,
            ),
          ),
          ListTile(
            onTap: () {
              AppUtility.closeBottomSheet();
              //CreatePostController.find.recordVideo();
            },
            leading: const Icon(Icons.videocam),
            title: Text(
              StringValues.recordVideo,
              style: AppStyles.style16Bold,
            ),
          ),
          ListTile(
            onTap: () {
              AppUtility.closeBottomSheet();
              // CreatePostController.find.selectPostImages();
            },
            leading: const Icon(Icons.photo_album),
            title: Text(
              StringValues.chooseImages,
              style: AppStyles.style16Bold,
            ),
          ),
          ListTile(
            onTap: () {
              AppUtility.closeBottomSheet();
              // CreatePostController.find.selectPosVideos();
            },
            leading: const Icon(Icons.video_collection),
            title: Text(
              StringValues.chooseVideos,
              style: AppStyles.style16Bold,
            ),
          ),
        ],
      );
}

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
