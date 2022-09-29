import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/global_widgets/custom_app_bar.dart';
import 'package:social_media_app/global_widgets/custom_refresh_indicator.dart';
import 'package:social_media_app/modules/chat/controllers/chat_controller.dart';
import 'package:social_media_app/modules/chat/widgets/chat_widget.dart';
import 'package:social_media_app/modules/home/controllers/profile_controller.dart';
import 'package:social_media_app/routes/route_management.dart';

class ChatsTabView extends StatelessWidget {
  const ChatsTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: SafeArea(
        child: SizedBox(
          width: Dimens.screenWidth,
          height: Dimens.screenHeight,
          child: NxRefreshIndicator(
            onRefresh: () async {},
            showProgress: false,
            child: Column(
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
                  Column(
                    children: logic.conversations
                        .map(
                          (item) => ChatWidget(
                            chat: item,
                            onTap: () => RouteManagement.goToChatDetailsView(
                              item.sender!.id ==
                                      ProfileController
                                          .find.profileDetails!.user!.id
                                  ? item.receiver!.id
                                  : item.sender!.id,
                              item.sender!.id ==
                                      ProfileController
                                          .find.profileDetails!.user!.id
                                  ? item.receiver!.uname
                                  : item.sender!.uname,
                            ),
                          ),
                        )
                        .toList(),
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
