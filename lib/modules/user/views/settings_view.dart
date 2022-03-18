import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/themes.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(StringValues.settings),
              GetBuilder<AppThemeController>(
                builder: (logic) => Switch(
                  value: logic.themeMode,
                  onChanged: (value) => logic.toggleThemeMode(value),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
