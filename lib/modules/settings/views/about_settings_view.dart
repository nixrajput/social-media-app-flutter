import 'package:flutter/material.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/global_widgets/custom_app_bar.dart';
import 'package:social_media_app/global_widgets/primary_outlined_btn.dart';
import 'package:social_media_app/global_widgets/unfocus_widget.dart';
import 'package:social_media_app/modules/app_update/app_update_controller.dart';
import 'package:social_media_app/utils/utility.dart';

class AboutSettingsView extends StatelessWidget {
  const AboutSettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return UnFocusWidget(
      child: Scaffold(
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
                  padding: Dimens.edgeInsetsDefault,
                ),
                Dimens.boxHeight16,
                _buildBody(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: Dimens.edgeInsetsHorizDefault,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTopPart(context),
            const Spacer(),
            _buildMiddlePart(context),
            const Spacer(),
            _buildBottomPart(context),
            Dimens.boxHeight16,
          ],
        ),
      ),
    );
  }

  Column _buildTopPart(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppUtility.buildAppLogo(context, fontSize: Dimens.thirtyTwo),
        RichText(
          text: TextSpan(
            text:
                '${StringValues.version}  ${AppUpdateController.find.version}+${AppUpdateController.find.buildNumber}',
            style: AppStyles.style14Normal.copyWith(
              color: Theme.of(context).textTheme.subtitle1!.color,
            ),
          ),
        ),
      ],
    );
  }

  Column _buildMiddlePart(BuildContext context) {
    return Column(
      children: [
        NxOutlinedButton(
          label: StringValues.downloadLatestApp,
          borderColor: Theme.of(context).textTheme.bodyText1!.color,
          padding: Dimens.edgeInsets0_8,
          width: Dimens.screenWidth,
          height: Dimens.thirtySix,
          labelStyle: AppStyles.style14Normal.copyWith(
            color: Theme.of(context).textTheme.bodyText1!.color,
          ),
          onTap: () =>
              AppUtility.openUrl(Uri.parse(StringValues.appDownloadUrl)),
        ),
        Dimens.boxHeight8,
        NxOutlinedButton(
          label: StringValues.githubRepo,
          borderColor: Theme.of(context).textTheme.bodyText1!.color,
          padding: Dimens.edgeInsets0_8,
          width: Dimens.screenWidth,
          height: Dimens.thirtySix,
          labelStyle: AppStyles.style14Normal.copyWith(
            color: Theme.of(context).textTheme.bodyText1!.color,
          ),
          onTap: () => AppUtility.openUrl(Uri.parse(StringValues.appGithubUrl)),
        ),
        Dimens.boxHeight8,
        NxOutlinedButton(
          label: StringValues.ourWebsite,
          borderColor: Theme.of(context).textTheme.bodyText1!.color,
          padding: Dimens.edgeInsets0_8,
          width: Dimens.screenWidth,
          height: Dimens.thirtySix,
          labelStyle: AppStyles.style14Normal.copyWith(
            color: Theme.of(context).textTheme.bodyText1!.color,
          ),
          onTap: () => AppUtility.openUrl(Uri.parse(StringValues.websiteUrl)),
        ),
        Dimens.boxHeight8,
        NxOutlinedButton(
          label: StringValues.joinTelegramChannel,
          borderColor: Theme.of(context).textTheme.bodyText1!.color,
          padding: Dimens.edgeInsets0_8,
          width: Dimens.screenWidth,
          height: Dimens.thirtySix,
          labelStyle: AppStyles.style14Normal.copyWith(
            color: Theme.of(context).textTheme.bodyText1!.color,
          ),
          onTap: () => AppUtility.openUrl(Uri.parse(StringValues.telegramUrl)),
        ),
      ],
    );
  }

  Column _buildBottomPart(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              StringValues.developedBy,
              textAlign: TextAlign.center,
              style: AppStyles.style14Normal.copyWith(
                color: Theme.of(context).textTheme.subtitle1!.color,
              ),
            ),
            Dimens.boxWidth4,
            Flexible(
              child: GestureDetector(
                onTap: () =>
                    AppUtility.openUrl(Uri.parse(StringValues.portfolioUrl)),
                child: Text(
                  StringValues.developerName,
                  textAlign: TextAlign.center,
                  style: AppStyles.style14Bold.copyWith(
                    color: ColorValues.linkColor,
                  ),
                ),
              ),
            ),
          ],
        ),
        Dimens.boxHeight8,
        Text(
          StringValues.madeWithLove,
          style: AppStyles.style14Normal.copyWith(
            color: Theme.of(context).textTheme.subtitle1!.color,
          ),
        ),
      ],
    );
  }
}
