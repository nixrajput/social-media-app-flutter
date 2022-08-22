import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/extensions/string_extensions.dart';
import 'package:social_media_app/global_widgets/custom_app_bar.dart';
import 'package:social_media_app/global_widgets/custom_list_tile.dart';
import 'package:social_media_app/global_widgets/custom_radio_tile.dart';
import 'package:social_media_app/global_widgets/primary_icon_btn.dart';
import 'package:social_media_app/helpers/utils.dart';
import 'package:social_media_app/modules/profile/controllers/profile_controller.dart';
import 'package:social_media_app/modules/settings/controllers/account_type_controller.dart';

class PrivacySettingsView extends StatelessWidget {
  const PrivacySettingsView({Key? key}) : super(key: key);

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
                title: StringValues.privacy,
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
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GetBuilder<ProfileController>(
                builder: (logic) => NxListTile(
                  leading: Icon(
                    Icons.lock_outline,
                    size: Dimens.twentyFour,
                    color: Theme.of(Get.context!).textTheme.bodyText1!.color,
                  ),
                  title: Text(
                    StringValues.accountPrivacy,
                    style: AppStyles.style16Normal,
                  ),
                  onTap: () => _showAccountPrivacyDialog(logic),
                ),
              ),
              NxListTile(
                leading: Icon(
                  Icons.add_circle_outline,
                  size: Dimens.twentyFour,
                  color: Theme.of(Get.context!).textTheme.bodyText1!.color,
                ),
                title: Text(
                  StringValues.posts,
                  style: AppStyles.style16Normal,
                ),
              ),
              NxListTile(
                leading: Icon(
                  Icons.chat_bubble_outline,
                  size: Dimens.twentyFour,
                  color: Theme.of(Get.context!).textTheme.bodyText1!.color,
                ),
                title: Text(
                  StringValues.comments,
                  style: AppStyles.style16Normal,
                ),
              ),
              NxListTile(
                leading: Icon(
                  Icons.history_outlined,
                  size: Dimens.twentyFour,
                  color: Theme.of(Get.context!).textTheme.bodyText1!.color,
                ),
                title: Text(
                  StringValues.story,
                  style: AppStyles.style16Normal,
                ),
              ),
              NxListTile(
                leading: Icon(
                  Icons.online_prediction,
                  size: Dimens.twentyFour,
                  color: Theme.of(Get.context!).textTheme.bodyText1!.color,
                ),
                title: Text(
                  "${StringValues.activity} ${StringValues.status.toTitleCase()}",
                  style: AppStyles.style16Normal,
                ),
              ),
              Dimens.boxHeight16,
            ],
          ),
        ),
      ),
    );
  }

  void _showAccountPrivacyDialog(ProfileController logic) {
    AppUtils.showSimpleDialog(
      GetBuilder<AccountTypeController>(
        init: AccountTypeController(),
        builder: (con) => Padding(
          padding: Dimens.edgeInsets16,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text(
                    StringValues.accountPrivacy,
                    style: AppStyles.style20Bold,
                  ),
                  const Spacer(),
                  NxIconButton(
                    icon: Icons.close,
                    iconSize: Dimens.thirtyTwo,
                    onTap: AppUtils.closeDialog,
                  ),
                ],
              ),
              Dimens.boxHeight24,
              Column(
                children: [StringValues.public, StringValues.private]
                    .map(
                      (val) => NxRadioTile(
                        padding: Dimens.edgeInsets8_0,
                        onTap: () => con.updateAccountType(val),
                        onChanged: (value) {
                          con.updateAccountType(val);
                        },
                        title: val.toTitleCase(),
                        value: val,
                        groupValue: logic.profileData.user!.accountType,
                      ),
                    )
                    .toList(),
              ),
              Dimens.boxHeight24,
            ],
          ),
        ),
      ),
    );
  }
}
