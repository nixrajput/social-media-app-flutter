import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/apis/services/auth_service.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/extensions/string_extensions.dart';
import 'package:social_media_app/global_widgets/custom_app_bar.dart';
import 'package:social_media_app/global_widgets/custom_list_tile.dart';
import 'package:social_media_app/modules/app_update/app_update_controller.dart';
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
              NxAppBar(
                padding: Dimens.edgeInsets8_16,
                title: StringValues.settings,
              ),
              Dimens.boxHeight16,
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
            padding: Dimens.edgeInsets0_16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                /// Account

                NxListTile(
                  padding: Dimens.edgeInsets12_8,
                  bgColor: Theme.of(Get.context!).dialogBackgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimens.eight),
                    topRight: Radius.circular(Dimens.eight),
                  ),
                  leading: Icon(
                    Icons.account_circle_outlined,
                    size: Dimens.twentyFour,
                    color: Theme.of(Get.context!).textTheme.bodyText1!.color,
                  ),
                  title: Text(
                    StringValues.account,
                    style: AppStyles.style16Bold,
                  ),
                  onTap: RouteManagement.goToAccountSettingsView,
                ),

                Dimens.divider,

                /// Security

                NxListTile(
                  padding: Dimens.edgeInsets12_8,
                  bgColor: Theme.of(Get.context!).dialogBackgroundColor,
                  leading: Icon(
                    Icons.verified_user_outlined,
                    size: Dimens.twentyFour,
                    color: Theme.of(Get.context!).textTheme.bodyText1!.color,
                  ),
                  title: Text(
                    StringValues.security,
                    style: AppStyles.style16Bold,
                  ),
                  onTap: RouteManagement.goToSecuritySettingsView,
                ),

                Dimens.divider,

                /// Privacy

                NxListTile(
                  padding: Dimens.edgeInsets12_8,
                  bgColor: Theme.of(Get.context!).dialogBackgroundColor,
                  leading: Icon(
                    Icons.lock_outline,
                    size: Dimens.twentyFour,
                    color: Theme.of(Get.context!).textTheme.bodyText1!.color,
                  ),
                  title: Text(
                    StringValues.privacy,
                    style: AppStyles.style16Bold,
                  ),
                  onTap: RouteManagement.goToPrivacySettingsView,
                ),

                Dimens.divider,

                /// Help

                NxListTile(
                  padding: Dimens.edgeInsets12_8,
                  bgColor: Theme.of(Get.context!).dialogBackgroundColor,
                  leading: Icon(
                    Icons.help_outline_outlined,
                    size: Dimens.twentyFour,
                    color: Theme.of(Get.context!).textTheme.bodyText1!.color,
                  ),
                  title: Text(
                    StringValues.help,
                    style: AppStyles.style16Bold,
                  ),
                  onTap: RouteManagement.goToHelpSettingsView,
                ),

                Dimens.divider,

                /// Theme

                NxListTile(
                  padding: Dimens.edgeInsets12_8,
                  bgColor: Theme.of(Get.context!).dialogBackgroundColor,
                  leading: Icon(
                    Icons.palette_outlined,
                    size: Dimens.twentyFour,
                    color: Theme.of(Get.context!).textTheme.bodyText1!.color,
                  ),
                  title: Text(
                    StringValues.theme,
                    style: AppStyles.style16Bold,
                  ),
                  onTap: RouteManagement.goToThemeSettingsView,
                ),

                Dimens.divider,

                /// About

                NxListTile(
                  padding: Dimens.edgeInsets12_8,
                  bgColor: Theme.of(Get.context!).dialogBackgroundColor,
                  leading: Icon(
                    Icons.info_outline,
                    size: Dimens.twentyFour,
                    color: Theme.of(Get.context!).textTheme.bodyText1!.color,
                  ),
                  title: Text(
                    StringValues.about,
                    style: AppStyles.style16Bold,
                  ),
                  onTap: RouteManagement.goToAboutSettingsView,
                ),

                Dimens.divider,

                /// Check for update

                NxListTile(
                  padding: Dimens.edgeInsets12_8,
                  bgColor: Theme.of(Get.context!).dialogBackgroundColor,
                  leading: Icon(
                    Icons.loop_outlined,
                    size: Dimens.twentyFour,
                    color: Theme.of(Get.context!).textTheme.bodyText1!.color,
                  ),
                  title: Text(
                    StringValues.checkForUpdates.toTitleCase(),
                    style: AppStyles.style16Bold,
                  ),
                  onTap: () => AppUpdateController.find.checkAppUpdate(),
                ),

                Dimens.divider,

                /// Logout

                NxListTile(
                  padding: Dimens.edgeInsets12_8,
                  bgColor: Theme.of(Get.context!).dialogBackgroundColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(Dimens.eight),
                    bottomRight: Radius.circular(Dimens.eight),
                  ),
                  leading: Icon(
                    Icons.logout_outlined,
                    size: Dimens.twentyFour,
                    color: Theme.of(Get.context!).textTheme.bodyText1!.color,
                  ),
                  title: Text(
                    StringValues.logout,
                    style: AppStyles.style16Bold,
                  ),
                  onTap: () async {
                    await AuthService.find.logout();
                    RouteManagement.goToWelcomeView();
                  },
                ),
                Dimens.boxHeight16,
              ],
            ),
          ),
        ),
      );
}
