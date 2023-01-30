import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/global_widgets/avatar_widget.dart';
import 'package:social_media_app/global_widgets/custom_app_bar.dart';
import 'package:social_media_app/global_widgets/unfocus_widget.dart';
import 'package:social_media_app/modules/chat/controllers/p2p_chat_controller.dart';

class P2PChatSettingsView extends StatelessWidget {
  const P2PChatSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return UnFocusWidget(
      child: Scaffold(
        body: SafeArea(
          child: SizedBox(
            width: Dimens.screenWidth,
            height: Dimens.screenHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                NxAppBar(
                  padding: Dimens.edgeInsetsDefault,
                ),
                Dimens.boxHeight8,
                _buildBody(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        child: Padding(
          padding: Dimens.edgeInsetsHorizDefault,
          child: GetBuilder<P2PChatController>(
            builder: (logic) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Dimens.boxHeight8,
                  Center(
                    child: AvatarWidget(
                      avatar: logic.user!.avatar,
                    ),
                  ),
                  Dimens.boxHeight16,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${logic.user!.fname} ${logic.user!.lname}',
                        style: AppStyles.style18Bold,
                      ),
                      if (logic.user!.isVerified) Dimens.boxWidth4,
                      if (logic.user!.isVerified)
                        Icon(
                          Icons.verified,
                          color: ColorValues.primaryColor,
                          size: Dimens.twenty,
                        )
                    ],
                  ),
                  Dimens.boxHeight2,
                  Text(
                    "@${logic.user!.uname}",
                    style: AppStyles.style14Normal.copyWith(
                      color: Theme.of(context).textTheme.titleMedium!.color,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
