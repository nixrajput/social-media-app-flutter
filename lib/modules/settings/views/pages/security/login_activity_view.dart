import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/apis/services/auth_service.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/global_widgets/custom_app_bar.dart';
import 'package:social_media_app/global_widgets/custom_list_tile.dart';
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
              NxAppBar(
                title: 'Login Activity',
                padding: Dimens.edgeInsets8_16,
              ),
              Dimens.boxHeight24,
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
                  Dimens.boxHeight16,
                  Column(
                    children: logic.deviceInfo!.results!
                        .map(
                          (e) => NxListTile(
                            padding: Dimens.edgeInsetsOnlyBottom16,
                            leading: Icon(
                              Icons.location_on_outlined,
                              size: Dimens.twentyFour,
                            ),
                            title: RichText(
                              text: TextSpan(
                                text:
                                    "${e.locationInfo!.city!}, ${e.locationInfo!.regionName!}, ${e.locationInfo!.country!}",
                                style: AppStyles.style16Normal.copyWith(
                                  color: Theme.of(Get.context!)
                                      .textTheme
                                      .bodyText1!
                                      .color,
                                ),
                              ),
                            ),
                            subtitle: RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                  text: e.deviceInfo!['model'],
                                  style: AppStyles.style14Normal.copyWith(
                                    color: Theme.of(Get.context!)
                                        .textTheme
                                        .subtitle1!
                                        .color,
                                  ),
                                ),
                                if (e.deviceId == AuthService.find.deviceId)
                                  TextSpan(
                                    text: " •",
                                    style: AppStyles.style14Bold.copyWith(
                                      color: ColorValues.successColor,
                                    ),
                                  ),
                              ]),
                            ),
                            trailing: GestureDetector(
                              child: Icon(
                                Icons.more_horiz,
                                size: Dimens.twentyFour,
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
