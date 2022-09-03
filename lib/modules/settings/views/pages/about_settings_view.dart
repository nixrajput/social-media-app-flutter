import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constants/assets.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/global_widgets/asset_image.dart';
import 'package:social_media_app/global_widgets/custom_app_bar.dart';
import 'package:social_media_app/global_widgets/primary_outlined_btn.dart';
import 'package:social_media_app/helpers/utils.dart';
import 'package:social_media_app/modules/app_update/app_update_controller.dart';

class AboutSettingsView extends StatelessWidget {
  const AboutSettingsView({Key? key}) : super(key: key);

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
                title: StringValues.about,
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
      child: Padding(
        padding: Dimens.edgeInsets0_16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppUtils.buildAppLogo(fontSize: Dimens.fourty),
                RichText(
                  text: TextSpan(
                    text:
                        'VERSION  ${AppUpdateController.find.version}+${AppUpdateController.find.buildNumber}',
                    style: AppStyles.style14Normal.copyWith(
                      color: Theme.of(Get.context!).textTheme.subtitle1!.color,
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Column(
              children: [
                NxOutlinedButton(
                  label: 'Download Latest APK',
                  borderColor:
                      Theme.of(Get.context!).textTheme.bodyText1!.color,
                  padding: Dimens.edgeInsets0_8,
                  width: Dimens.screenWidth,
                  height: Dimens.thirtySix,
                  labelStyle: AppStyles.style14Normal.copyWith(
                    color: Theme.of(Get.context!).textTheme.bodyText1!.color,
                  ),
                  onTap: () =>
                      AppUtils.openUrl(Uri.parse(StringValues.appDownloadUrl)),
                ),
                Dimens.boxHeight16,
                NxOutlinedButton(
                  label: 'GitHub Repository',
                  borderColor:
                      Theme.of(Get.context!).textTheme.bodyText1!.color,
                  padding: Dimens.edgeInsets0_8,
                  width: Dimens.screenWidth,
                  height: Dimens.thirtySix,
                  labelStyle: AppStyles.style14Normal.copyWith(
                    color: Theme.of(Get.context!).textTheme.bodyText1!.color,
                  ),
                  onTap: () =>
                      AppUtils.openUrl(Uri.parse(StringValues.appGithubUrl)),
                ),
                Dimens.boxHeight16,
                NxOutlinedButton(
                  label: 'Our Website',
                  borderColor:
                      Theme.of(Get.context!).textTheme.bodyText1!.color,
                  padding: Dimens.edgeInsets0_8,
                  width: Dimens.screenWidth,
                  height: Dimens.thirtySix,
                  labelStyle: AppStyles.style14Normal.copyWith(
                    color: Theme.of(Get.context!).textTheme.bodyText1!.color,
                  ),
                  onTap: () =>
                      AppUtils.openUrl(Uri.parse(StringValues.websiteUrl)),
                ),
              ],
            ),
            const Spacer(),
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(Dimens.hundred),
                child: NxAssetImage(
                  imgAsset: AssetValues.makeInIndia,
                  fit: BoxFit.cover,
                  width: Dimens.hundred,
                  height: Dimens.hundred,
                ),
              ),
            ),
            Dimens.boxHeight16,
          ],
        ),
      ),
    );
  }
}
