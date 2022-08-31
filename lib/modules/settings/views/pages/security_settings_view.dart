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
              /// Change Password

              NxListTile(
                padding: Dimens.edgeInsets12_8,
                bgColor: Theme.of(Get.context!).dialogBackgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimens.eight),
                  topRight: Radius.circular(Dimens.eight),
                ),
                leading: Icon(
                  Icons.key_outlined,
                  size: Dimens.twenty,
                  color: Theme.of(Get.context!).textTheme.bodyText1!.color,
                ),
                title: Text(
                  StringValues.changePassword,
                  style: AppStyles.style14Bold,
                ),
                onTap: RouteManagement.goToChangePasswordView,
              ),

              Dimens.divider,

              /// Login Activity

              NxListTile(
                padding: Dimens.edgeInsets12_8,
                bgColor: Theme.of(Get.context!).dialogBackgroundColor,
                leading: Icon(
                  Icons.location_on_outlined,
                  size: Dimens.twenty,
                  color: Theme.of(Get.context!).textTheme.bodyText1!.color,
                ),
                title: Text(
                  "${StringValues.login} ${StringValues.activity}",
                  style: AppStyles.style14Bold,
                ),
                onTap: RouteManagement.goToLoginActivityView,
              ),

              Dimens.divider,

              /// 2-FA

              NxListTile(
                padding: Dimens.edgeInsets12_8,
                bgColor: Theme.of(Get.context!).dialogBackgroundColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(Dimens.eight),
                  bottomRight: Radius.circular(Dimens.eight),
                ),
                leading: Icon(
                  Icons.security_outlined,
                  size: Dimens.twenty,
                  color: Theme.of(Get.context!).textTheme.bodyText1!.color,
                ),
                title: Text(
                  StringValues.twoFaAuth,
                  style: AppStyles.style14Bold,
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
