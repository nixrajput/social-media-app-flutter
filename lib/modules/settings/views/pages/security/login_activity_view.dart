import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/apis/services/auth_service.dart';
import 'package:social_media_app/common/custom_app_bar.dart';
import 'package:social_media_app/common/custom_list_tile.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/modules/settings/controllers/security_settings_controller.dart';

class LoginActivityView extends StatelessWidget {
  const LoginActivityView({Key? key}) : super(key: key);

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
                title: StringValues.security,
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
        child: GetBuilder<SecuritySettingsController>(
          builder: (logic) {
            if (logic.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Where You're Logged In",
                    style: AppStyles.style16Bold,
                  ),
                  Dimens.boxHeight8,
                  Column(
                    children: logic.loginInfo!.result!.devices!
                        .map(
                          (e) => NxListTile(
                            padding: Dimens.edgeInsetsOnlyBottom16,
                            leading: Icon(
                              Icons.location_on_outlined,
                              size: Dimens.twentyEight,
                            ),
                            title: Row(
                              children: [
                                Text(
                                  e['locationInfo']['city'] +
                                      ", " +
                                      e['locationInfo']['country'],
                                  style: AppStyles.style16Normal,
                                ),
                                if (e['deviceInfo']['deviceId'] ==
                                    AuthService.find.deviceId)
                                  Dimens.boxWidth8,
                                if (e['deviceInfo']['deviceId'] ==
                                    AuthService.find.deviceId)
                                  Text(
                                    "This Device",
                                    style: AppStyles.style16Normal.copyWith(
                                      color: ColorValues.successColor,
                                    ),
                                  )
                              ],
                            ),
                            subtitle: Text(
                              e['deviceInfo']['model'],
                              style: AppStyles.style14Normal.copyWith(
                                color: Theme.of(Get.context!)
                                    .textTheme
                                    .subtitle1!
                                    .color,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  Dimens.boxHeight20,
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
