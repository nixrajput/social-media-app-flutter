import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/extensions/string_extensions.dart';
import 'package:social_media_app/global_widgets/circular_progress_indicator.dart';
import 'package:social_media_app/global_widgets/custom_app_bar.dart';
import 'package:social_media_app/global_widgets/custom_refresh_indicator.dart';
import 'package:social_media_app/global_widgets/primary_icon_btn.dart';
import 'package:social_media_app/global_widgets/primary_text_btn.dart';
import 'package:social_media_app/modules/chat/controllers/chat_controller.dart';
import 'package:social_media_app/modules/chat/controllers/single_chat_controller.dart';
import 'package:social_media_app/modules/chat/widgets/bubble_type.dart';
import 'package:social_media_app/modules/chat/widgets/chat_bubble_clipper.dart';
import 'package:social_media_app/modules/home/controllers/profile_controller.dart';

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
                  onRefresh: () async {},
                  showProgress: false,
                  child: Stack(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          NxAppBar(
                            title: logic.receiverUname,
                            padding: Dimens.edgeInsets8_16,
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
                                    )
                                  ],
                                ),
                            ],
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

    return Expanded(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        padding: Dimens.edgeInsets0_16,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GetBuilder<ChatController>(
              builder: (chatsLogic) {
                chatsLogic.chats
                    .sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (chatsLogic.chatListData!.hasNextPage!)
                      Center(
                        child: NxTextButton(
                          label: 'Load more messages',
                          onTap: () => logic.loadMoreMessages(
                              chatsLogic.chatListData!.currentPage!),
                          labelStyle: AppStyles.style14Bold.copyWith(
                            color: ColorValues.primaryLightColor,
                          ),
                          padding: Dimens.edgeInsets8_0,
                        ),
                      ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: chatsLogic.chats
                          .where((element) =>
                              (element.sender!.id ==
                                      ProfileController
                                          .find.profileDetails!.user!.id &&
                                  element.receiver!.id == logic.receiverId) ||
                              (element.sender!.id == logic.receiverId &&
                                  element.receiver!.id ==
                                      ProfileController
                                          .find.profileDetails!.user!.id))
                          .map(
                            (e) => Container(
                              alignment: e.sender!.id ==
                                      logic.profile.profileDetails!.user!.id
                                  ? Alignment.topRight
                                  : Alignment.topLeft,
                              margin: Dimens.edgeInsetsOnlyBottom8,
                              child: PhysicalShape(
                                elevation: Dimens.two,
                                clipper: ChatBubbleClipper6(
                                  radius: Dimens.eight,
                                  type: e.sender!.id ==
                                          logic.profile.profileDetails!.user!.id
                                      ? BubbleType.sendBubble
                                      : BubbleType.receiverBubble,
                                ),
                                color: Theme.of(Get.context!)
                                    .dialogBackgroundColor,
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(
                                    maxWidth: Dimens.screenWidth * 0.75,
                                  ),
                                  child: Padding(
                                    padding: setPadding(e.sender!.id ==
                                            logic.profile.profileDetails!.user!
                                                .id
                                        ? BubbleType.sendBubble
                                        : BubbleType.receiverBubble),
                                    child: Text(
                                      e.message!,
                                      style: AppStyles.style13Normal,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
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

  EdgeInsets setPadding(BubbleType type) {
    if (type == BubbleType.sendBubble) {
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
}
