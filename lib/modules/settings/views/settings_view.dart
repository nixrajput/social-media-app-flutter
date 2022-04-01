import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/apis/services/theme_controller.dart';
import 'package:social_media_app/common/custom_app_bar.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/helpers/utils.dart';

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
              Dimens.boxHeight8,
              _buildSettingsBody(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsBody() => GetBuilder<AppThemeController>(
        builder: (logic) => Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: Dimens.edgeInsets8_16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Display',
                    style: AppStyles.style14Normal.copyWith(
                      color: ColorValues.primaryColor,
                    ),
                  ),
                  Dimens.boxHeight4,
                  ListTile(
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
                ],
              ),
            ),
          ),
        ),
      );
}
