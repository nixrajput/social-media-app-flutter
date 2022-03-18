import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/constants/themes.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: Dimens.screenWidth,
          height: Dimens.screenHeight,
          child: Padding(
            padding: Dimens.edgeInsets16,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  StringValues.settings,
                  style: AppStyles.style24Bold,
                ),
                Dimens.boxHeight32,
                GetBuilder<AppThemeController>(
                  builder: (logic) => DropdownButton(
                      isExpanded: true,
                      value: logic.themeMode,
                      items: appThemeModes
                          .map(
                            (item) => DropdownMenuItem(
                              value: item,
                              child: Text(
                                item,
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        logic.setThemeMode(value);
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
