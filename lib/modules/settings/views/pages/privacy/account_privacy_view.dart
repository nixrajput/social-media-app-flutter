import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
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
                padding: Dimens.edgeInsetsDefault,
              ),
              _buildBody(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: Dimens.edgeInsetsHorizDefault,
        child: SingleChildScrollView(
          child: GetBuilder<AccountPrivacyController>(
            builder: (logic) => Column(
              children: [
                Dimens.boxHeight8,

                /// Public
                NxRadioTile(
                  padding: Dimens.edgeInsets12,
                  bgColor: Theme.of(context).bottomAppBarColor,
                  borderRadius: BorderRadius.circular(Dimens.four),
                  onTap: () => logic.changeAccountPrivacy(false),
                  onChanged: (v) => logic.changeAccountPrivacy(false),
                  title: Text(
                    StringValues.public.toTitleCase(),
                    style: AppStyles.style14Bold,
                  ),
                  subtitle: Text(
                    StringValues.publicPrivacyDesc,
                    style: AppStyles.style13Normal.copyWith(
                      color: Theme.of(context).textTheme.subtitle1!.color,
                    ),
                  ),
                  value: false,
                  groupValue:
                      ProfileController.find.profileDetails!.user!.isPrivate,
                ),

                Dimens.boxHeight8,

                /// Private
                NxRadioTile(
                  padding: Dimens.edgeInsets12,
                  bgColor: Theme.of(context).bottomAppBarColor,
                  borderRadius: BorderRadius.circular(Dimens.four),
                  onTap: () => logic.changeAccountPrivacy(true),
                  onChanged: (v) => logic.changeAccountPrivacy(true),
                  title: Text(
                    StringValues.private.toTitleCase(),
                    style: AppStyles.style14Bold,
                  ),
                  subtitle: Text(
                    StringValues.privatePrivacyDesc,
                    style: AppStyles.style13Normal.copyWith(
                      color: Theme.of(context).textTheme.subtitle1!.color,
                    ),
                  ),
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
