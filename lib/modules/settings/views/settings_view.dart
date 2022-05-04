import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/apis/services/auth_controller.dart';
import 'package:social_media_app/apis/services/theme_controller.dart';
import 'package:social_media_app/common/custom_app_bar.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/helpers/utils.dart';
import 'package:social_media_app/modules/settings/controllers/account_type_controller.dart';

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
            padding: Dimens.edgeInsets8_16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDisplaySettings(),
                _buildAccountSettings(),
                _buildSecuritySettings(),
                _buildPrivacySettings(),
              ],
            ),
          ),
        ),
      );

  _buildDisplaySettings() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          StringValues.display,
          style: AppStyles.style14Normal.copyWith(
            color: ColorValues.primaryColor,
          ),
        ),
        Dimens.boxHeight4,
        GetBuilder<AppThemeController>(
          builder: (logic) => ListTile(
            onTap: () {
              AppUtils.showBottomSheet(
                appThemeModes
                    .map(
                      (theme) => ListTile(
                        onTap: () {
                          AppUtils.closeBottomSheet();
                          logic.setThemeMode(theme);
                        },
                        leading: Text(
                          theme.toString(),
                          style: AppStyles.style16Bold,
                        ),
                      ),
                    )
                    .toList(),
              );
            },
            leading: const Icon(CupertinoIcons.brightness_solid),
            title: const Text(StringValues.theme),
            subtitle: Text(
              logic.themeMode.toString(),
            ),
          ),
        ),
      ],
    );
  }

  _buildAccountSettings() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          StringValues.account,
          style: AppStyles.style14Normal.copyWith(
            color: ColorValues.primaryColor,
          ),
        ),
        Dimens.boxHeight4,
      ],
    );
  }

  _buildSecuritySettings() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          StringValues.security,
          style: AppStyles.style14Normal.copyWith(
            color: ColorValues.primaryColor,
          ),
        ),
        Dimens.boxHeight4,
      ],
    );
  }

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
        GetBuilder<AuthController>(
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
