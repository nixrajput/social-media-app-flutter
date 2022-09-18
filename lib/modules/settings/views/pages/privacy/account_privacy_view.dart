import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/extensions/string_extensions.dart';
import 'package:social_media_app/global_widgets/custom_app_bar.dart';
import 'package:social_media_app/global_widgets/custom_radio_tile.dart';
import 'package:social_media_app/modules/home/controllers/profile_controller.dart';
import 'package:social_media_app/modules/settings/controllers/account_privacy_controller.dart';

class AccountPrivacyView extends StatelessWidget {
  const AccountPrivacyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: Dimens.screenWidth,
          height: Dimens.screenHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NxAppBar(
                title: StringValues.accountPrivacy,
                padding: Dimens.edgeInsets8_16,
              ),
              Dimens.boxHeight16,
              _buildBody(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Expanded(
      child: Padding(
        padding: Dimens.edgeInsets0_16,
        child: SingleChildScrollView(
          child: GetBuilder<AccountPrivacyController>(
            builder: (logic) => Column(
              children: [
                /// Public

                NxRadioTile(
                  padding: Dimens.edgeInsets8,
                  bgColor: Theme.of(Get.context!).dialogBackgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimens.eight),
                    topRight: Radius.circular(Dimens.eight),
                  ),
                  onTap: () => logic.changeAccountPrivacy(false),
                  onChanged: (v) => logic.changeAccountPrivacy(false),
                  title: StringValues.public.toTitleCase(),
                  value: false,
                  groupValue:
                      ProfileController.find.profileDetails!.user!.isPrivate,
                ),

                Dimens.divider,

                /// Private

                NxRadioTile(
                  padding: Dimens.edgeInsets8,
                  bgColor: Theme.of(Get.context!).dialogBackgroundColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(Dimens.eight),
                    bottomRight: Radius.circular(Dimens.eight),
                  ),
                  onTap: () => logic.changeAccountPrivacy(true),
                  onChanged: (v) => logic.changeAccountPrivacy(true),
                  title: StringValues.private.toTitleCase(),
                  value: true,
                  groupValue:
                      ProfileController.find.profileDetails!.user!.isPrivate,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
