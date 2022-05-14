import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/apis/services/theme_controller.dart';
import 'package:social_media_app/common/custom_app_bar.dart';
import 'package:social_media_app/common/custom_radio_tile.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';

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
              const NxAppBar(
                title: StringValues.theme,
              ),
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
        padding: Dimens.edgeInsets8,
        child: SingleChildScrollView(
          child: GetBuilder<AppThemeController>(
            builder: (logic) {
              return Column(
                children: appThemeModes
                    .map(
                      (theme) => NxRadioTile(
                        padding: Dimens.edgeInsets16_0,
                        onTap: () => logic.setThemeMode(theme),
                        onChanged: (value) {
                          logic.setThemeMode(value);
                        },
                        title: theme.toString(),
                        value: theme.toString(),
                        groupValue: logic.themeMode,
                      ),
                    )
                    .toList(),
              );
            },
          ),
        ),
      ),
    );
  }
}
