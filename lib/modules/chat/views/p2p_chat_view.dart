import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/apis/models/entities/chat_message.dart';
import 'package:social_media_app/apis/models/entities/media_file_message.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/enums.dart';
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
import 'package:social_media_app/modules/chat/widgets/chat_bubble_clipper.dart';
import 'package:social_media_app/modules/chat/widgets/chat_bubble_widget.dart';
import 'package:social_media_app/modules/chat/widgets/chat_reply_to_box.dart';
import 'package:social_media_app/routes/route_management.dart';
import 'package:social_media_app/utils/file_utility.dart';
import 'package:social_media_app/utils/utility.dart';

class P2PChatView extends StatelessWidget {
  const P2PChatView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<P2PChatController>(
          builder: (logic) {
            if (!logic.initialized) {
              return const Center(child: NxCircularProgressIndicator());
            }
            return KeyboardVisibilityBuilder(
              builder: (_, child, isKeyboardVisible) {
                if (isKeyboardVisible) {
                  if (logic.isTyping == false) {
                    logic.setIsTyping(true);
                    logic.sendTypingStatus('start');
                    AppUtility.log('Keyboard is visible');
                  }
                } else {
                  if (logic.isTyping == true) {
                    logic.setIsTyping(false);
                    logic.sendTypingStatus('end');
                    AppUtility.log('Keyboard is not visible');
                  }
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
                        _buildAppBar(context, logic),
                        _buildBody(context, logic),
                      ],
                    ),
                    _buildMessageTypingContainer(logic, context),
                    if (logic.scrolledToBottom == false)
                      _buildScrollToLast(logic, context),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Positioned _buildMessageTypingContainer(
      P2PChatController logic, BuildContext context) {
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
          Dimens.divider,
          _buildMessageTypingBox(logic, context),
          Dimens.divider,
        ],
      ),
    );
  }

  NxAppBar _buildAppBar(BuildContext context, P2PChatController logic) {
    return NxAppBar(
      padding: Dimens.edgeInsetsDefault,
      child: Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GetBuilder<ChatController>(builder: (con) {
              final isUserOnline = con.isUserOnline(logic.user!.id);
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    logic.user != null ? logic.user!.uname : '',
                    style: AppStyles.style16Bold.copyWith(
                      color: Theme.of(context).textTheme.bodyText1!.color,
                    ),
                  ),
                  if (isUserOnline)
                    Text(
                      StringValues.activeNow,
                      style: AppStyles.style12Normal.copyWith(
                        color: Theme.of(context).textTheme.subtitle1!.color,
                      ),
                    ),
                ],
              );
            }),
            const Spacer(),
            GestureDetector(
              onTap: RouteManagement.goToChatSettingsView,
              child: Container(
                padding: Dimens.edgeInsets6,
                decoration: BoxDecoration(
                  color: Theme.of(context).bottomAppBarColor,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Theme.of(context).dividerColor,
                  ),
                ),
                child: Icon(
                  Icons.more_vert_outlined,
                  size: Dimens.twenty,
                  color: Theme.of(context).textTheme.bodyText1!.color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _buildMessageTypingBox(
      P2PChatController logic, BuildContext context) {
    return Container(
      color: Theme.of(context).bottomAppBarColor,
      width: Dimens.screenWidth,
      height: Dimens.fourtyEight,
      padding: Dimens.edgeInsets0_12,
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
              keyboardType: TextInputType.multiline,
              textCapitalization: TextCapitalization.sentences,
              style: AppStyles.style14Normal.copyWith(
                color: Theme.of(Get.context!).textTheme.bodyText1!.color,
              ),
            ),
          ),
          Dimens.boxWidth8,
          if (logic.message.isNotEmpty)
            GestureDetector(
              onTap: logic.sendMessage,
              child: Container(
                padding: Dimens.edgeInsets6,
                decoration: const BoxDecoration(
                  color: ColorValues.primaryColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: Dimens.twenty,
                  color: Theme.of(context).textTheme.bodyText1!.color,
                ),
              ),
            )
          else
            NxIconButton(
              icon: Icons.add_outlined,
              iconSize: Dimens.twentyFour,
              iconColor: Theme.of(Get.context!).textTheme.bodyText1!.color,
              onTap: () => _showAttachmentOptions(logic),
            ),
        ],
      ),
    );
  }

  Positioned _buildScrollToLast(P2PChatController logic, BuildContext context) {
    return Positioned(
      bottom: Dimens.eighty,
      left: Dimens.zero,
      right: Dimens.zero,
      child: Container(
        padding: Dimens.edgeInsets12,
        decoration: BoxDecoration(
          color: Theme.of(context).bottomAppBarColor,
          shape: BoxShape.circle,
          border: Border.all(
            color: Theme.of(context).dividerColor,
          ),
        ),
        child: NxIconButton(
          icon: Icons.arrow_downward,
          iconSize: Dimens.twenty,
          iconColor: Theme.of(context).textTheme.bodyText1!.color,
          onTap: logic.scrollToLast,
        ),
      ),
    );
  }

  Widget _buildReplyTo(P2PChatController logic) {
    return Container(
      color: Theme.of(Get.context!).scaffoldBackgroundColor,
      width: Dimens.screenWidth,
      padding: Dimens.edgeInsets8,
      child: ChatReplyToBox(
        message: logic.replyTo,
        onClose: logic.clearReplyTo,
      ),
    );
  }

  Widget _buildBody(BuildContext context, P2PChatController logic) {
    if (logic.isLoading && logic.chatMessages.isEmpty) {
      return Center(
          child: Padding(
        padding: Dimens.edgeInsetsOnlyTop8,
        child: const NxCircularProgressIndicator(),
      ));
    }

    if (!logic.isLoading && logic.chatMessages.isEmpty) {
      return Expanded(
        child: Center(
          child: Padding(
            padding: Dimens.edgeInsetsHorizDefault,
            child: Text(
              StringValues.noMessages,
              style: AppStyles.style32Bold.copyWith(
                color: Theme.of(context).textTheme.subtitle1!.color,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }

    if (logic.scrolledToBottom) {
      Future.delayed(const Duration(milliseconds: 100), () {
        logic.markMessageAsRead();
      });
    }

    return Expanded(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        reverse: true,
        controller: logic.scrollController,
        padding: Dimens.edgeInsetsHorizDefault,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (logic.messageData != null &&
                    logic.messageData!.hasNextPage != null &&
                    logic.messageData!.hasNextPage!)
                  Center(
                    child: NxTextButton(
                      label: StringValues.loadMore,
                      onTap: () => logic.loadMore(),
                      labelStyle: AppStyles.style14Bold.copyWith(
                        color: ColorValues.linkColor,
                      ),
                      padding: Dimens.edgeInsets8_0,
                    ),
                  ),
                _buildChatMessages(logic.chatMessages, logic),
                if (logic.chatController.isUserTyping(logic.user!.id))
                  _buildTypingBubble(logic, logic.chatController),
              ],
            ),
            if (logic.isLoading && logic.chatMessages.isNotEmpty)
              const Center(child: NxCircularProgressIndicator()),
            Dimens.boxHeight60,
          ],
        ),
      ),
    );
  }

  Widget _buildTypingBubble(
      P2PChatController logic, ChatController chatsLogic) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Dimens.boxHeight8,
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            AvatarWidget(
              avatar: logic.user!.avatar,
              size: Dimens.sixTeen,
            ),
            PhysicalShape(
              elevation: Dimens.zero,
              clipper: ChatBubbleClipper(
                radius: Dimens.sixTeen,
                nipSize: Dimens.six,
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
                  showIndicator: chatsLogic.isUserTyping(logic.user!.id),
                ),
              ),
            )
          ],
        ),
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
          Text(
            date.formatDate().toUpperCase(),
            style: AppStyles.style12Bold.copyWith(
              color: Theme.of(Get.context!).textTheme.subtitle2!.color,
            ),
          ),
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
        children: [
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
