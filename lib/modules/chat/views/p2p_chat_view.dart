import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/apis/models/entities/chat_message.dart';
import 'package:social_media_app/apis/models/entities/media_file_message.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/extensions/date_extensions.dart';
import 'package:social_media_app/extensions/string_extensions.dart';
import 'package:social_media_app/global_widgets/avatar_widget.dart';
import 'package:social_media_app/global_widgets/circular_progress_indicator.dart';
import 'package:social_media_app/global_widgets/custom_app_bar.dart';
import 'package:social_media_app/global_widgets/keyboard_visibility_builder.dart';
import 'package:social_media_app/global_widgets/primary_icon_btn.dart';
import 'package:social_media_app/global_widgets/primary_text_btn.dart';
import 'package:social_media_app/global_widgets/typing_indicator_dots.dart';
import 'package:social_media_app/helpers/global_string_key.dart';
import 'package:social_media_app/modules/chat/controllers/chat_controller.dart';
import 'package:social_media_app/modules/chat/controllers/p2p_chat_controller.dart';
import 'package:social_media_app/modules/chat/views/preview_media_files_view.dart';
import 'package:social_media_app/modules/chat/widgets/bubble_type.dart';
import 'package:social_media_app/modules/chat/widgets/chat_bubble_clipper.dart';
import 'package:social_media_app/modules/chat/widgets/chat_bubble_widget.dart';
import 'package:social_media_app/modules/chat/widgets/chat_reply_to_box.dart';
import 'package:social_media_app/utils/file_utility.dart';
import 'package:social_media_app/utils/utility.dart';

class P2PChatView extends StatelessWidget {
  const P2PChatView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: GetBuilder<P2PChatController>(
            builder: (logic) {
              if (!logic.initialized) {
                return const Center(child: NxCircularProgressIndicator());
              }
              return KeyboardVisibilityBuilder(
                builder: (_, child, isKeyboardVisible) {
                  if (isKeyboardVisible) {
                    logic.sendTypingStatus('start');
                  } else {
                    logic.sendTypingStatus('end');
                  }

                  return child;
                },
                child: SizedBox(
                  width: Dimens.screenWidth,
                  height: Dimens.screenHeight,
                  child: Stack(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _buildAppBar(logic),
                          _buildBody(logic),
                        ],
                      ),
                      _buildMessageTypingContainer(logic),
                      if (logic.scrolledToBottom == false)
                        _buildScrollToLast(logic),
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

  Positioned _buildMessageTypingContainer(P2PChatController logic) {
    return Positioned(
      bottom: Dimens.zero,
      left: Dimens.zero,
      right: Dimens.zero,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (logic.replyTo.id != null) _buildReplyTo(logic),
          _buildMessageTypingBox(logic),
        ],
      ),
    );
  }

  NxAppBar _buildAppBar(P2PChatController logic) {
    return NxAppBar(
      padding: Dimens.edgeInsets8_16,
      bgColor: Theme.of(Get.context!).dialogBackgroundColor,
      leading: Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AvatarWidget(
              avatar: logic.profileImage,
              size: Dimens.twenty,
            ),
            Dimens.boxWidth8,
            GetBuilder<ChatController>(builder: (con) {
              final isUserOnline = con.isUserOnline(logic.userId!);
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    logic.username ?? '',
                    style: AppStyles.style18Bold.copyWith(
                      fontSize: isUserOnline ? Dimens.sixTeen : Dimens.eighteen,
                    ),
                  ),
                  if (isUserOnline)
                    Text(
                      'Online',
                      style: AppStyles.style12Normal.copyWith(
                        color: ColorValues.successColor,
                      ),
                    ),
                ],
              );
            }),
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
    );
  }

  Container _buildMessageTypingBox(P2PChatController logic) {
    return Container(
      color: Theme.of(Get.context!).dialogTheme.backgroundColor,
      width: Dimens.screenWidth,
      height: Dimens.fourtyEight,
      padding: Dimens.edgeInsets0_8,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: TextFormField(
              controller: logic.messageTextController,
              onChanged: (value) => logic.onChangedText(value),
              decoration: InputDecoration(
                hintText: StringValues.message.toTitleCase(),
                hintStyle: AppStyles.style14Normal.copyWith(
                  color: Theme.of(Get.context!).textTheme.subtitle1!.color,
                ),
                border: InputBorder.none,
              ),
              minLines: 1,
              maxLines: 5,
              style: AppStyles.style14Normal.copyWith(
                color: Theme.of(Get.context!).textTheme.bodyText1!.color,
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
                  icon: Icons.attach_file,
                  iconSize: Dimens.twentyFour,
                  iconColor: Theme.of(Get.context!).textTheme.bodyText1!.color,
                  onTap: () => _showAttachmentOptions(logic),
                )
              ],
            ),
        ],
      ),
    );
  }

  Positioned _buildScrollToLast(P2PChatController logic) {
    return Positioned(
      bottom: Dimens.hundred * 1.6,
      right: Dimens.sixTeen,
      child: Container(
        padding: Dimens.edgeInsets8,
        decoration: const BoxDecoration(
          color: ColorValues.primaryLightColor,
          shape: BoxShape.circle,
        ),
        child: NxIconButton(
          icon: Icons.keyboard_double_arrow_down,
          iconSize: Dimens.twentyFour,
          iconColor: ColorValues.whiteColor,
          onTap: logic.scrollToLast,
        ),
      ),
    );
  }

  Widget _buildReplyTo(P2PChatController logic) {
    return Container(
      color: Theme.of(Get.context!).dialogTheme.backgroundColor,
      width: Dimens.screenWidth,
      padding: Dimens.edgeInsets8,
      child: ChatReplyToBox(
        message: logic.replyTo,
        onClose: logic.clearReplyTo,
      ),
    );
  }

  Widget _buildBody(P2PChatController logic) {
    if (logic.isLoading) {
      return Center(
          child: Padding(
        padding: Dimens.edgeInsetsOnlyTop8,
        child: const NxCircularProgressIndicator(),
      ));
    }

    final currentUser = logic.profile.profileDetails!.user!;

    return Expanded(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        reverse: true,
        controller: logic.scrollController,
        padding: Dimens.edgeInsets0_8,
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
                    if (logic.messageData != null &&
                        logic.messageData!.hasNextPage != null &&
                        logic.messageData!.hasNextPage!)
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
                    _buildChatMessages(filteredMessages, logic),
                    if (chatsLogic.isUserTyping(logic.userId!))
                      Dimens.boxHeight8,
                    if (chatsLogic.isUserTyping(logic.userId!))
                      _buildTypingBubble(logic, chatsLogic),
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

  Row _buildTypingBubble(P2PChatController logic, ChatController chatsLogic) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        AvatarWidget(
          avatar: logic.profileImage,
          size: Dimens.sixTeen,
        ),
        PhysicalShape(
          elevation: Dimens.two,
          clipper: ChatBubbleClipper(
            radius: Dimens.eight,
            type: BubbleType.receiverBubble,
          ),
          color: Theme.of(Get.context!).dialogBackgroundColor,
          child: Padding(
            padding: EdgeInsets.only(
              top: Dimens.eight,
              bottom: Dimens.sixTeen,
              left: Dimens.sixTeen,
              right: Dimens.eight,
            ),
            child: TypingIndicator(
              showIndicator: chatsLogic.isUserTyping(logic.userId!),
            ),
          ),
        )
      ],
    );
  }

  Column _buildChatMessages(
      List<ChatMessage> filteredMessages, P2PChatController logic) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (var i = 0; i < filteredMessages.length; i++)
          _buildChatBubble(
            filteredMessages,
            filteredMessages[i],
            i,
            logic,
          ),
      ],
    );
  }

  _buildChatBubble(List<ChatMessage> filteredMessages, ChatMessage message,
      int index, P2PChatController logic) {
    var isSameDate = true;

    final date = message.createdAt!;

    if (index == 0) {
      isSameDate = false;
    } else {
      final previousDate = filteredMessages[index - 1].createdAt!;
      isSameDate = date.isSameDate(previousDate);
    }

    if (index == 0 || !isSameDate) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(date.formatDate()),
          Dimens.boxHeight8,
          ChatBubble(
            key: GlobalStringKey(message.id ?? message.tempId!),
            message: message,
            onSwipeLeft: () {
              AppUtility.printLog('swipe left');
            },
            onSwipeRight: () {
              logic.onChangeReplyTo(message);
            },
          )
        ],
      );
    }

    return ChatBubble(
      key: GlobalStringKey(message.id ?? message.tempId!),
      message: message,
      onSwipeLeft: () {
        AppUtility.printLog('swipe left');
      },
      onSwipeRight: () {
        logic.onChangeReplyTo(message);
      },
    );
  }

  void _showAttachmentOptions(P2PChatController logic) =>
      AppUtility.showBottomSheet(
        [
          ListTile(
            onTap: () async {
              AppUtility.closeBottomSheet();
              var file = await FileUtility.captureImage();
              if (file != null) {
                var message = MediaFileMessage(file: file);
                logic.addMediaFileMessage(message);
                await Get.to(() => const PreviewMediaFilesView());
              }
            },
            leading: const Icon(Icons.camera),
            title: Text(
              StringValues.captureImage,
              style: AppStyles.style16Bold,
            ),
          ),
          ListTile(
            onTap: () async {
              AppUtility.closeBottomSheet();
              var file = await FileUtility.recordVideo();
              if (file != null) {
                var message = MediaFileMessage(file: file);
                logic.addMediaFileMessage(message);
                await Get.to(() => const PreviewMediaFilesView());
              }
            },
            leading: const Icon(Icons.videocam),
            title: Text(
              StringValues.recordVideo,
              style: AppStyles.style16Bold,
            ),
          ),
          ListTile(
            onTap: () async {
              AppUtility.closeBottomSheet();
              var files = await FileUtility.selectMultipleImages();
              if (files != null && files.isNotEmpty) {
                for (var file in files) {
                  var message = MediaFileMessage(file: file);
                  logic.addMediaFileMessage(message);
                }
                await Get.to(() => const PreviewMediaFilesView());
              }
            },
            leading: const Icon(Icons.photo_album),
            title: Text(
              StringValues.chooseImages,
              style: AppStyles.style16Bold,
            ),
          ),
          ListTile(
            onTap: () async {
              AppUtility.closeBottomSheet();
              var files = await FileUtility.selectMultipleVideos();
              if (files != null && files.isNotEmpty) {
                for (var file in files) {
                  var message = MediaFileMessage(file: file);
                  logic.addMediaFileMessage(message);
                }
                await Get.to(() => const PreviewMediaFilesView());
              }
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
