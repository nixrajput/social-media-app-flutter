import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/apis/services/auth_service.dart';
import 'package:social_media_app/common/custom_app_bar.dart';
import 'package:social_media_app/common/custom_list_tile.dart';
import 'package:social_media_app/common/primary_text_btn.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/helpers/utils.dart';
import 'package:social_media_app/modules/profile/controllers/profile_controller.dart';
import 'package:social_media_app/modules/settings/controllers/account_type_controller.dart';
import 'package:social_media_app/routes/route_management.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

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
              const NxAppBar(
                title: StringValues.settings,
              ),
              _buildSettingsBody(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsBody() => Expanded(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: Dimens.edgeInsets8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                NxListTile(
                  padding: Dimens.edgeInsets8_0,
                  leading: Icon(
                    Icons.account_circle_outlined,
                    size: Dimens.twentyEight,
                    color: Theme.of(Get.context!).textTheme.bodyText1!.color,
                  ),
                  title: Text(
                    StringValues.account,
                    style: AppStyles.style16Normal.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onTap: RouteManagement.goToAccountSettingsView,
                ),
                NxListTile(
                  padding: Dimens.edgeInsets8_0,
                  leading: Icon(
                    Icons.verified_user_outlined,
                    size: Dimens.twentyEight,
                    color: Theme.of(Get.context!).textTheme.bodyText1!.color,
                  ),
                  title: Text(
                    StringValues.security,
                    style: AppStyles.style16Normal.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onTap: RouteManagement.goToSecuritySettingsView,
                ),
                NxListTile(
                  padding: Dimens.edgeInsets8_0,
                  leading: Icon(
                    Icons.lock_outline,
                    size: Dimens.twentyEight,
                    color: Theme.of(Get.context!).textTheme.bodyText1!.color,
                  ),
                  title: Text(
                    StringValues.privacy,
                    style: AppStyles.style16Normal.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onTap: RouteManagement.goToPrivacySettingsView,
                ),
                NxListTile(
                  padding: Dimens.edgeInsets8_0,
                  leading: Icon(
                    Icons.help_outline_outlined,
                    size: Dimens.twentyEight,
                    color: Theme.of(Get.context!).textTheme.bodyText1!.color,
                  ),
                  title: Text(
                    StringValues.help,
                    style: AppStyles.style16Normal.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onTap: RouteManagement.goToHelpSettingsView,
                ),
                NxListTile(
                  padding: Dimens.edgeInsets8_0,
                  leading: Icon(
                    Icons.info_outline,
                    size: Dimens.twentyEight,
                    color: Theme.of(Get.context!).textTheme.bodyText1!.color,
                  ),
                  title: Text(
                    StringValues.about,
                    style: AppStyles.style16Normal.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onTap: RouteManagement.goToAboutSettingsView,
                ),
                NxListTile(
                  padding: Dimens.edgeInsets8_0,
                  leading: Icon(
                    Icons.palette_outlined,
                    size: Dimens.twentyEight,
                    color: Theme.of(Get.context!).textTheme.bodyText1!.color,
                  ),
                  title: Text(
                    StringValues.theme,
                    style: AppStyles.style16Normal.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onTap: RouteManagement.goToThemeSettingsView,
                ),
                Dimens.boxHeight24,
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: NxTextButton(
                    label: StringValues.logout,
                    labelStyle: AppStyles.style24Normal.copyWith(
                      color: ColorValues.primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                    onTap: AuthService.find.logout,
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  _buildPrivacySettings() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          StringValues.privacy,
          style: AppStyles.style14Normal.copyWith(
            color: ColorValues.primaryColor,
          ),
        ),
        Dimens.boxHeight4,
        GetBuilder<ProfileController>(
          builder: (logic) => ListTile(
            onTap: () {
              AppUtils.showBottomSheet(
                [StringValues.public, StringValues.private]
                    .map(
                      (item) => GetBuilder<AccountTypeController>(
                        builder: (con) => ListTile(
                          onTap: () {
                            AppUtils.closeBottomSheet();
                            con.updateAccountType(item);
                          },
                          leading: Text(
                            item.toTitleCase(),
                            style: AppStyles.style16Bold.copyWith(),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              );
            },
            leading: const Icon(CupertinoIcons.checkmark_shield),
            title:
                const Text('${StringValues.account} ${StringValues.privacy}'),
            subtitle: Text(
              logic.profileData.user!.accountType.toTitleCase(),
            ),
          ),
        ),
      ],
    );
  }
}
