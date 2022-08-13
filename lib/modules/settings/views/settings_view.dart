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
            crossAxisAlignment: CrossAxisAlignment.stretch,
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
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                NxListTile(
                  padding: Dimens.edgeInsets16_0,
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
                  padding: Dimens.edgeInsets16_0,
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
                  padding: Dimens.edgeInsets16_0,
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
                  padding: Dimens.edgeInsets16_0,
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
                  padding: Dimens.edgeInsets16_0,
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
                  padding: Dimens.edgeInsets16_0,
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
                  padding: Dimens.edgeInsets4,
                  child: NxTextButton(
                    label: StringValues.logout,
                    labelStyle: AppStyles.style20Normal.copyWith(
                      color: ColorValues.primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                    onTap: () {
                      RouteManagement.goToLoginView();
                      AuthService.find.logout();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
