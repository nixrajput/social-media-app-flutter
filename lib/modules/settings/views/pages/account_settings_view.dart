import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/extensions/string_extensions.dart';
import 'package:social_media_app/global_widgets/custom_app_bar.dart';
import 'package:social_media_app/global_widgets/custom_list_tile.dart';

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
              NxListTile(
                leading: Icon(
                  Icons.mail_outline,
                  size: Dimens.twentyFour,
                  color: Theme.of(Get.context!).textTheme.bodyText1!.color,
                ),
                title: Text(
                  StringValues.changeEmail.toTitleCase(),
                  style: AppStyles.style16Normal,
                ),
              ),
              NxListTile(
                leading: Icon(
                  Icons.phone_outlined,
                  size: Dimens.twentyFour,
                  color: Theme.of(Get.context!).textTheme.bodyText1!.color,
                ),
                title: Text(
                  StringValues.changePhoneNo.toTitleCase(),
                  style: AppStyles.style16Normal,
                ),
              ),
              NxListTile(
                leading: Icon(
                  Icons.verified_outlined,
                  size: Dimens.twentyFour,
                  color: Theme.of(Get.context!).textTheme.bodyText1!.color,
                ),
                title: Text(
                  '${StringValues.verification.toTitleCase()} ${StringValues.request.toTitleCase()}',
                  style: AppStyles.style16Normal,
                ),
              ),
              NxListTile(
                leading: Icon(
                  Icons.download_outlined,
                  size: Dimens.twentyFour,
                  color: Theme.of(Get.context!).textTheme.bodyText1!.color,
                ),
                title: Text(
                  StringValues.downloadArchiveOfData,
                  style: AppStyles.style16Normal,
                ),
              ),
              NxListTile(
                leading: Icon(
                  Icons.heart_broken_outlined,
                  size: Dimens.twentyFour,
                  color: Theme.of(Get.context!).textTheme.bodyText1!.color,
                ),
                title: Text(
                  StringValues.deactivateAccount,
                  style: AppStyles.style16Normal,
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
