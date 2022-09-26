import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/apis/models/entities/server_key.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/extensions/string_extensions.dart';
import 'package:social_media_app/global_widgets/circular_progress_indicator.dart';
import 'package:social_media_app/global_widgets/custom_app_bar.dart';
import 'package:social_media_app/global_widgets/custom_refresh_indicator.dart';
import 'package:social_media_app/global_widgets/primary_icon_btn.dart';
import 'package:social_media_app/modules/chat/controllers/single_chat_controller.dart';

class SingleChatView extends StatelessWidget {
  const SingleChatView({
    Key? key,
    required this.receiverId,
    required this.receiverUname,
    required this.serverKey,
  }) : super(key: key);

  final String receiverId;
  final String receiverUname;
  final ServerKey? serverKey;

  @override
  Widget build(BuildContext context) {
    Get.put(SingleChatController(
      receiverId: receiverId,
      receiverUname: receiverUname,
      serverKey: serverKey,
    ));
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: SizedBox(
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
                        title: receiverUname,
                        padding: Dimens.edgeInsets8_16,
                      ),
                      Dimens.boxHeight8,
                      _buildBody(),
                    ],
                  ),
                  Positioned(
                    bottom: Dimens.zero,
                    left: Dimens.zero,
                    right: Dimens.zero,
                    child: GetBuilder<SingleChatController>(
                      builder: (con) => Container(
                        color:
                            Theme.of(Get.context!).dialogTheme.backgroundColor,
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
                                controller: con.messageTextController,
                                onChanged: (value) => con.onChangedText(value),
                                decoration: InputDecoration(
                                  hintText: StringValues.message.toTitleCase(),
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
                            if (con.message.isNotEmpty)
                              NxIconButton(
                                icon: Icons.send,
                                iconColor: ColorValues.primaryColor,
                                iconSize: Dimens.twentyFour,
                                onTap: con.sendMessage,
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
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Expanded(
      child: GetBuilder<SingleChatController>(
        builder: (logic) {
          if (logic.isLoading) {
            return const Center(child: NxCircularProgressIndicator());
          }

          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            padding: Dimens.edgeInsets0_16,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: logic.chatController.chats
                        .map(
                          (e) => Align(
                            alignment: e.sender!.id ==
                                    logic.profile.profileDetails!.user!.id
                                ? Alignment.topLeft
                                : Alignment.topRight,
                            child: Container(
                              width: Dimens.screenWidth * 0.75,
                              padding: Dimens.edgeInsets8,
                              margin: Dimens.edgeInsetsOnlyBottom16,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Dimens.eight),
                                color: Theme.of(Get.context!)
                                    .dialogBackgroundColor,
                              ),
                              child: Text(
                                e.message!,
                                style: AppStyles.style13Normal,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
                Dimens.boxHeight16,
              ],
            ),
          );
        },
      ),
    );
  }
}
