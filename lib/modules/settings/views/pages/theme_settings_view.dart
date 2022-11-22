import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/app_services/theme_controller.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/extensions/string_extensions.dart';
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
              _buildBody(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: Dimens.edgeInsets0_16,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          child: GetBuilder<AppThemeController>(
            builder: (logic) => Column(
              children: [
                /// System
                NxRadioTile(
                  padding: Dimens.edgeInsets16_12,
                  bgColor: Theme.of(context).dialogBackgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimens.eight),
                    topRight: Radius.circular(Dimens.eight),
                  ),
                  onTap: () => logic.setThemeMode(AppThemeModes.system),
                  onChanged: (value) {
                    logic.setThemeMode(value);
                  },
                  title: Text(
                    StringValues.systemDefault.toTitleCase(),
                    style: AppStyles.style14Bold,
                  ),
                  subtitle: Text(
                    StringValues.systemDefaultDesc,
                    style: AppStyles.style13Normal.copyWith(
                      color: Theme.of(context).textTheme.subtitle1!.color,
                    ),
                  ),
                  value: AppThemeModes.system,
                  groupValue: logic.themeMode,
                ),

                Dimens.divider,

                /// Light
                NxRadioTile(
                  padding: Dimens.edgeInsets16_12,
                  bgColor: Theme.of(context).dialogBackgroundColor,
                  onTap: () => logic.setThemeMode(AppThemeModes.light),
                  onChanged: (value) {
                    logic.setThemeMode(value);
                  },
                  title: Text(
                    StringValues.light.toTitleCase(),
                    style: AppStyles.style14Bold,
                  ),
                  subtitle: Text(
                    StringValues.lightModeDesc,
                    style: AppStyles.style13Normal.copyWith(
                      color: Theme.of(context).textTheme.subtitle1!.color,
                    ),
                  ),
                  value: AppThemeModes.light,
                  groupValue: logic.themeMode,
                ),

                Dimens.divider,

                /// Dark
                NxRadioTile(
                  padding: Dimens.edgeInsets16_12,
                  bgColor: Theme.of(context).dialogBackgroundColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(Dimens.eight),
                    bottomRight: Radius.circular(Dimens.eight),
                  ),
                  onTap: () => logic.setThemeMode(AppThemeModes.dark),
                  onChanged: (value) {
                    logic.setThemeMode(value);
                  },
                  title: Text(
                    StringValues.dark.toTitleCase(),
                    style: AppStyles.style14Bold,
                  ),
                  subtitle: Text(
                    StringValues.darkModeDesc,
                    style: AppStyles.style13Normal.copyWith(
                      color: Theme.of(context).textTheme.subtitle1!.color,
                    ),
                  ),
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
