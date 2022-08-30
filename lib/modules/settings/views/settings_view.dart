import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/apis/services/auth_service.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/global_widgets/custom_app_bar.dart';
import 'package:social_media_app/global_widgets/custom_list_tile.dart';
import 'package:social_media_app/global_widgets/primary_filled_btn.dart';
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
              Dimens.boxHeight8,
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
                NxListTile(
                  padding: Dimens.edgeInsets16_0,
                  leading: Icon(
                    Icons.account_circle_outlined,
                    size: Dimens.twentyFour,
                    color: Theme.of(Get.context!).textTheme.bodyText1!.color,
                  ),
                  title: Text(
                    StringValues.account,
                    style: AppStyles.style16Normal,
                  ),
                  subtitle: RichText(
                    text: TextSpan(
                      text: StringValues.accountSettingsHelp,
                      style: AppStyles.style14Normal.copyWith(
                        color:
                            Theme.of(Get.context!).textTheme.subtitle1!.color,
                      ),
                    ),
                  ),
                  onTap: RouteManagement.goToAccountSettingsView,
                ),
                NxListTile(
                  padding: Dimens.edgeInsets16_0,
                  leading: Icon(
                    Icons.verified_user_outlined,
                    size: Dimens.twentyFour,
                    color: Theme.of(Get.context!).textTheme.bodyText1!.color,
                  ),
                  title: Text(
                    StringValues.security,
                    style: AppStyles.style16Normal,
                  ),
                  subtitle: RichText(
                    text: TextSpan(
                      text: StringValues.securitySettingsHelp,
                      style: AppStyles.style14Normal.copyWith(
                        color:
                            Theme.of(Get.context!).textTheme.subtitle1!.color,
                      ),
                    ),
                  ),
                  onTap: RouteManagement.goToSecuritySettingsView,
                ),
                NxListTile(
                  padding: Dimens.edgeInsets16_0,
                  leading: Icon(
                    Icons.lock_outline,
                    size: Dimens.twentyFour,
                    color: Theme.of(Get.context!).textTheme.bodyText1!.color,
                  ),
                  title: Text(
                    StringValues.privacy,
                    style: AppStyles.style16Normal,
                  ),
                  subtitle: RichText(
                    text: TextSpan(
                      text: StringValues.privacySettingsHelp,
                      style: AppStyles.style14Normal.copyWith(
                        color:
                            Theme.of(Get.context!).textTheme.subtitle1!.color,
                      ),
                    ),
                  ),
                  onTap: RouteManagement.goToPrivacySettingsView,
                ),
                NxListTile(
                  padding: Dimens.edgeInsets16_0,
                  leading: Icon(
                    Icons.help_outline_outlined,
                    size: Dimens.twentyFour,
                    color: Theme.of(Get.context!).textTheme.bodyText1!.color,
                  ),
                  title: Text(
                    StringValues.help,
                    style: AppStyles.style16Normal,
                  ),
                  subtitle: RichText(
                    text: TextSpan(
                      text: StringValues.helpSettingsHelp,
                      style: AppStyles.style14Normal.copyWith(
                        color:
                            Theme.of(Get.context!).textTheme.subtitle1!.color,
                      ),
                    ),
                  ),
                  onTap: RouteManagement.goToHelpSettingsView,
                ),
                NxListTile(
                  padding: Dimens.edgeInsets16_0,
                  leading: Icon(
                    Icons.palette_outlined,
                    size: Dimens.twentyFour,
                    color: Theme.of(Get.context!).textTheme.bodyText1!.color,
                  ),
                  title: Text(
                    StringValues.theme,
                    style: AppStyles.style16Normal,
                  ),
                  subtitle: RichText(
                    text: TextSpan(
                      text: StringValues.themeSettingsHelp,
                      style: AppStyles.style14Normal.copyWith(
                        color:
                            Theme.of(Get.context!).textTheme.subtitle1!.color,
                      ),
                    ),
                  ),
                  onTap: RouteManagement.goToThemeSettingsView,
                ),
                NxListTile(
                  padding: Dimens.edgeInsets16_0,
                  leading: Icon(
                    Icons.info_outline,
                    size: Dimens.twentyFour,
                    color: Theme.of(Get.context!).textTheme.bodyText1!.color,
                  ),
                  title: Text(
                    StringValues.about,
                    style: AppStyles.style16Normal,
                  ),
                  subtitle: RichText(
                    text: TextSpan(
                      text: StringValues.aboutSettingsHelp,
                      style: AppStyles.style14Normal.copyWith(
                        color:
                            Theme.of(Get.context!).textTheme.subtitle1!.color,
                      ),
                    ),
                  ),
                  onTap: RouteManagement.goToAboutSettingsView,
                ),
                Dimens.boxHeight24,
                NxFilledButton(
                  label: StringValues.logout.toUpperCase(),
                  onTap: () {
                    RouteManagement.goToWelcomeView();
                    AuthService.find.logout();
                  },
                ),
                Dimens.boxHeight16,
              ],
            ),
          ),
        ),
      );
}
