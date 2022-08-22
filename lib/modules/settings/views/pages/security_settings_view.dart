import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/global_widgets/custom_app_bar.dart';
import 'package:social_media_app/global_widgets/custom_list_tile.dart';
import 'package:social_media_app/routes/route_management.dart';

class SecuritySettingsView extends StatelessWidget {
  const SecuritySettingsView({Key? key}) : super(key: key);

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
                title: StringValues.security,
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
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: Dimens.edgeInsets0_16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              NxListTile(
                leading: Icon(
                  Icons.key_outlined,
                  size: Dimens.twentyFour,
                  color: Theme.of(Get.context!).textTheme.bodyText1!.color,
                ),
                title: Text(
                  StringValues.changePassword,
                  style: AppStyles.style16Normal,
                ),
                onTap: RouteManagement.goToChangePasswordView,
              ),
              NxListTile(
                leading: Icon(
                  Icons.location_on_outlined,
                  size: Dimens.twentyFour,
                  color: Theme.of(Get.context!).textTheme.bodyText1!.color,
                ),
                title: Text(
                  "${StringValues.login} ${StringValues.activity}",
                  style: AppStyles.style16Normal,
                ),
                onTap: RouteManagement.goToLoginActivityView,
              ),
              NxListTile(
                leading: Icon(
                  Icons.security_outlined,
                  size: Dimens.twentyFour,
                  color: Theme.of(Get.context!).textTheme.bodyText1!.color,
                ),
                title: Text(
                  StringValues.twoFaAuth,
                  style: AppStyles.style16Normal,
                ),
                subtitle: RichText(
                  text: TextSpan(
                    text: StringValues.twoFaAuthHelpText,
                    style: AppStyles.style14Normal.copyWith(
                      color: Theme.of(Get.context!).textTheme.subtitle1!.color,
                    ),
                  ),
                ),
              ),
              Dimens.boxHeight16,
            ],
          ),
        ),
      ),
    );
  }
}
