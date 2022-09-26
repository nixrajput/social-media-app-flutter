import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/apis/models/entities/chat_message.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/global_widgets/custom_app_bar.dart';
import 'package:social_media_app/global_widgets/custom_refresh_indicator.dart';
import 'package:social_media_app/modules/chat/bindings/single_chat_binding.dart';
import 'package:social_media_app/modules/chat/controllers/chat_controller.dart';
import 'package:social_media_app/modules/chat/views/single_chat_view.dart';
import 'package:social_media_app/modules/chat/widgets/chat_widget.dart';

class ChatView extends StatelessWidget {
  const ChatView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                        title: StringValues.chats,
                        padding: Dimens.edgeInsets8_16,
                      ),
                      Dimens.boxHeight8,
                      _buildBody(),
                    ],
                  ),
                  Positioned(
                    bottom: Dimens.sixTeen,
                    right: Dimens.sixTeen,
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        padding: Dimens.edgeInsets12,
                        constraints: BoxConstraints(
                          minWidth: Dimens.fourty,
                          minHeight: Dimens.fourty,
                        ),
                        decoration: BoxDecoration(
                            color: ColorValues.primaryColor,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(Dimens.zero, Dimens.eight),
                                blurRadius: Dimens.eight,
                                color: ColorValues.blackColor.withOpacity(0.1),
                              )
                            ]),
                        child: Center(
                          child: Icon(
                            Icons.add_outlined,
                            size: Dimens.thirtyTwo,
                            color: ColorValues.whiteColor,
                          ),
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
      child: GetBuilder<ChatController>(
        builder: (logic) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            padding: Dimens.edgeInsets0_16,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (logic.chatListData == null || logic.chats.isEmpty)
                  Center(
                    child: Text(
                      StringValues.noConversation,
                      style: AppStyles.style32Bold.copyWith(
                        color:
                            Theme.of(Get.context!).textTheme.subtitle1!.color,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                else
                  StatefulBuilder(builder: (context, setInnerState) {
                    var present = <String>{};
                    var uniqueList = <ChatMessage>[];
                    uniqueList = logic.chats
                        .where((element) =>
                            element.sender!.id !=
                                logic.profile.profileDetails!.user!.id &&
                            present.add(element.sender!.id))
                        .toList();
                    setInnerState(() {});
                    return Column(
                      children: uniqueList
                          .map((item) => ChatWidget(
                                chat: item,
                                onTap: () => Get.to(
                                  binding: SingleChatBinding(),
                                  () => SingleChatView(
                                    receiverId: item.sender!.id,
                                    receiverUname: item.sender!.uname,
                                    serverKey: item.sender!.publicKeys,
                                  ),
                                  transition: Transition.circularReveal,
                                  duration: const Duration(milliseconds: 500),
                                ),
                              ))
                          .toList(),
                    );
                  }),
                Dimens.boxHeight16,
              ],
            ),
          );
        },
      ),
    );
  }
}
