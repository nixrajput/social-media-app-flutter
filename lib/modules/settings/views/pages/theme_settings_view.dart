import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/app_services/theme_controller.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/global_widgets/custom_app_bar.dart';
import 'package:social_media_app/global_widgets/custom_radio_tile.dart';

class ThemeSettingsView extends StatelessWidget {
  const ThemeSettingsView({Key? key}) : super(key: key);

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
                title: StringValues.theme,
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
          child: GetBuilder<AppThemeController>(
            builder: (logic) => Column(
              children: [
                /// System

                NxRadioTile(
                  padding: Dimens.edgeInsets8,
                  bgColor: Theme.of(Get.context!).dialogBackgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimens.eight),
                    topRight: Radius.circular(Dimens.eight),
                  ),
                  onTap: () => logic.setThemeMode(AppThemeModes.system),
                  onChanged: (value) {
                    logic.setThemeMode(value);
                  },
                  title: StringValues.system.toString(),
                  value: AppThemeModes.system,
                  groupValue: logic.themeMode,
                ),

                Dimens.divider,

                /// Light

                NxRadioTile(
                  padding: Dimens.edgeInsets8,
                  bgColor: Theme.of(Get.context!).dialogBackgroundColor,
                  onTap: () => logic.setThemeMode(AppThemeModes.light),
                  onChanged: (value) {
                    logic.setThemeMode(value);
                  },
                  title: StringValues.light.toString(),
                  value: AppThemeModes.light,
                  groupValue: logic.themeMode,
                ),

                Dimens.divider,

                /// Dark

                NxRadioTile(
                  padding: Dimens.edgeInsets8,
                  bgColor: Theme.of(Get.context!).dialogBackgroundColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(Dimens.eight),
                    bottomRight: Radius.circular(Dimens.eight),
                  ),
                  onTap: () => logic.setThemeMode(AppThemeModes.dark),
                  onChanged: (value) {
                    logic.setThemeMode(value);
                  },
                  title: StringValues.dark.toString(),
                  value: AppThemeModes.dark,
                  groupValue: logic.themeMode,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
