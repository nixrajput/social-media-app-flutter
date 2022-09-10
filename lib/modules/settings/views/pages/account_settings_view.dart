import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/extensions/string_extensions.dart';
import 'package:social_media_app/global_widgets/custom_app_bar.dart';
import 'package:social_media_app/global_widgets/custom_list_tile.dart';
import 'package:social_media_app/routes/route_management.dart';

class AccountSettingsView extends StatelessWidget {
  const AccountSettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: Dimens.screenWidth,
          height: Dimens.screenHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              NxAppBar(
                padding: Dimens.edgeInsets8_16,
                title: StringValues.account,
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
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              /// Change Email Address

              NxListTile(
                padding: Dimens.edgeInsets12_8,
                bgColor: Theme.of(Get.context!).dialogBackgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimens.eight),
                  topRight: Radius.circular(Dimens.eight),
                ),
                leading: Icon(
                  Icons.mail_outline,
                  size: Dimens.twenty,
                  color: Theme.of(Get.context!).textTheme.bodyText1!.color,
                ),
                title: Text(
                  StringValues.changeEmailAddress.toTitleCase(),
                  style: AppStyles.style14Bold,
                ),
                onTap: () => RouteManagement.goToVerifyPasswordView(
                  RouteManagement.goToChangeEmailSettingsView,
                ),
              ),

              Dimens.divider,

              /// Add or Change Phone Number

              NxListTile(
                padding: Dimens.edgeInsets12_8,
                bgColor: Theme.of(Get.context!).dialogBackgroundColor,
                leading: Icon(
                  Icons.phone_outlined,
                  size: Dimens.twenty,
                  color: Theme.of(Get.context!).textTheme.bodyText1!.color,
                ),
                title: Text(
                  StringValues.changePhoneNo.toTitleCase(),
                  style: AppStyles.style14Bold,
                ),
                onTap: () => RouteManagement.goToVerifyPasswordView(
                  RouteManagement.goToChangePhoneSettingsView,
                ),
              ),

              Dimens.divider,

              /// Apply for Self Verification

              NxListTile(
                padding: Dimens.edgeInsets12_8,
                bgColor: Theme.of(Get.context!).dialogBackgroundColor,
                leading: Icon(
                  Icons.verified_user_outlined,
                  size: Dimens.twenty,
                  color: Theme.of(Get.context!).textTheme.bodyText1!.color,
                ),
                title: Text(
                  StringValues.applyForSelfVerify.toTitleCase(),
                  style: AppStyles.style14Bold,
                ),
              ),
              Dimens.divider,

              /// Apply for Blue Tick

              NxListTile(
                padding: Dimens.edgeInsets12_8,
                bgColor: Theme.of(Get.context!).dialogBackgroundColor,
                leading: Icon(
                  Icons.verified_outlined,
                  size: Dimens.twenty,
                  color: Theme.of(Get.context!).textTheme.bodyText1!.color,
                ),
                title: Text(
                  StringValues.applyForBlueTick.toTitleCase(),
                  style: AppStyles.style14Bold,
                ),
              ),

              Dimens.divider,

              /// Deactivate Account

              NxListTile(
                padding: Dimens.edgeInsets12_8,
                bgColor: Theme.of(Get.context!).dialogBackgroundColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(Dimens.eight),
                  bottomRight: Radius.circular(Dimens.eight),
                ),
                leading: Icon(
                  Icons.heart_broken_outlined,
                  size: Dimens.twenty,
                  color: Theme.of(Get.context!).textTheme.bodyText1!.color,
                ),
                title: Text(
                  StringValues.deactivateAccount,
                  style: AppStyles.style14Bold,
                ),
                onTap: RouteManagement.goToDeactivateAccountSettingsView,
              ),
              Dimens.boxHeight16,
            ],
          ),
        ),
      ),
    );
  }
}
