import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:r_upgrade/r_upgrade.dart';
import 'package:social_media_app/constants/assets.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/extensions/string_extensions.dart';
import 'package:social_media_app/global_widgets/circular_progress_indicator.dart';
import 'package:social_media_app/global_widgets/primary_outlined_btn.dart';
import 'package:social_media_app/modules/app_update/app_update_controller.dart';

class AppUpdateView extends StatelessWidget {
  const AppUpdateView({super.key});

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: Dimens.edgeInsetsDefault,
      child: GetBuilder<AppUpdateController>(
        builder: (logic) {
          if (logic.isLoading) {
            return Center(
              child: _buildDownloadWindow(logic, context),
            );
          }
          return Center(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildSvgImage(context),
                  Dimens.boxHeight16,
                  _buildUpdateText(context),
                  Dimens.boxHeight8,
                  _buildCurrentVersionText(logic, context),
                  _buildLatestVersionText(logic, context),
                  Dimens.boxHeight16,
                  _buildChangeLog(logic, context),
                  Dimens.boxHeight16,
                  _buildUpdateHelpText(context),
                  Dimens.boxHeight16,
                  _buildUpdateNowBtn(logic, context),
                  Dimens.boxHeight16,
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Text _buildUpdateHelpText(BuildContext context) {
    return Text(
      StringValues.updateAvailableDesc,
      textAlign: TextAlign.center,
      style: AppStyles.style13Normal.copyWith(
        color: Theme.of(context).textTheme.titleMedium!.color,
      ),
    );
  }

  Text _buildUpdateText(BuildContext context) {
    return Text(
      StringValues.updateAvailable.toTitleCase(),
      textAlign: TextAlign.center,
      style: AppStyles.style20Bold.copyWith(
        color: Theme.of(context).textTheme.bodyLarge!.color,
      ),
    );
  }

  SvgPicture _buildSvgImage(BuildContext context) {
    return SvgPicture.asset(
      SvgAssets.upgrade,
      width: Dimens.screenWidth * 0.25,
      height: Dimens.screenWidth * 0.25,
    );
  }

  Container _buildChangeLog(AppUpdateController logic, BuildContext context) {
    return Container(
      height: Dimens.screenWidth,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: AppStyles.defaultShadow,
        borderRadius: BorderRadius.circular(Dimens.four),
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: Dimens.edgeInsets8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              StringValues.changelog.toTitleCase(),
              textAlign: TextAlign.center,
              style: AppStyles.style16Bold.copyWith(
                color: Theme.of(context).textTheme.bodyLarge!.color,
              ),
            ),
            _buildChangelogMarkdown(logic, context),
          ],
        ),
      ),
    );
  }

  NxOutlinedButton _buildUpdateNowBtn(
      AppUpdateController logic, BuildContext context) {
    return NxOutlinedButton(
      label: StringValues.updateNow.toUpperCase(),
      bgColor: Theme.of(context).textTheme.bodyLarge!.color,
      borderColor: Theme.of(context).textTheme.bodyLarge!.color,
      padding: Dimens.edgeInsets0_8,
      width: Dimens.screenWidth,
      height: Dimens.fiftySix,
      labelStyle: AppStyles.style16Bold.copyWith(
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      onTap: () => logic.downloadAppUpdate(),
    );
  }

  Markdown _buildChangelogMarkdown(
      AppUpdateController logic, BuildContext context) {
    return Markdown(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      padding: Dimens.edgeInsets8,
      data: logic.updateInfo.changelog!,
      styleSheet: MarkdownStyleSheet(
        p: AppStyles.style13Normal.copyWith(
          color: Theme.of(context).textTheme.titleMedium!.color,
        ),
        h1: AppStyles.style20Bold.copyWith(
          color: Theme.of(context).textTheme.bodyLarge!.color,
        ),
        h2: AppStyles.style18Bold.copyWith(
          color: Theme.of(context).textTheme.bodyLarge!.color,
        ),
        em: AppStyles.style13Normal.copyWith(
          color: Theme.of(context).textTheme.titleMedium!.color,
        ),
        blockquote: AppStyles.style13Normal.copyWith(
          color: Theme.of(context).textTheme.titleMedium!.color,
        ),
        code: AppStyles.style13Bold.copyWith(
          color: ColorValues.successColor,
        ),
      ),
    );
  }

  Row _buildLatestVersionText(AppUpdateController logic, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '${StringValues.newVersion} ${StringValues.version}:',
          textAlign: TextAlign.center,
          style: AppStyles.style13Normal.copyWith(
            color: Theme.of(context).textTheme.titleMedium!.color,
          ),
        ),
        Dimens.boxWidth4,
        Text(
          logic.updateInfo.latestVersion!,
          textAlign: TextAlign.center,
          style: AppStyles.style13Normal.copyWith(
            color: Theme.of(context).textTheme.bodyLarge!.color,
          ),
        ),
      ],
    );
  }

  Row _buildCurrentVersionText(
      AppUpdateController logic, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '${StringValues.current} ${StringValues.version}:',
          textAlign: TextAlign.center,
          style: AppStyles.style13Normal.copyWith(
            color: Theme.of(context).textTheme.titleMedium!.color,
          ),
        ),
        Dimens.boxWidth4,
        Text(
          logic.updateInfo.currentVersion!,
          textAlign: TextAlign.center,
          style: AppStyles.style13Normal.copyWith(
            color: Theme.of(context).textTheme.bodyLarge!.color,
          ),
        ),
      ],
    );
  }

  Widget _buildDownloadWindow(
          AppUpdateController logic, BuildContext context) =>
      StreamBuilder(
        stream: RUpgrade.stream,
        builder: (_, AsyncSnapshot<DownloadInfo> snapshot) {
          if (snapshot.hasData) {
            var progress = snapshot.data!.percent! / 100;
            var downloadSpeed = snapshot.data!.getSpeedString();
            var size = (snapshot.data!.currentLength! / 1024 / 1024)
                .toStringAsFixed(2);
            var totalSize =
                (snapshot.data!.maxLength! / 1024 / 1024).toStringAsFixed(2);

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (snapshot.data!.status == DownloadStatus.STATUS_RUNNING)
                  _buildDownloadSizeAndSpeed(
                    size,
                    totalSize,
                    downloadSpeed,
                    logic,
                    snapshot,
                    context,
                  ),
                Dimens.boxHeight8,
                _buildDownloadStatus(logic, snapshot, context),
                Dimens.boxHeight32,
                _buildProgressIndicator(progress, context),
                Dimens.boxHeight32,
                _buildResumePauseBtn(snapshot, context),
              ],
            );
          } else {
            return const Center(
              child: NxCircularProgressIndicator(),
            );
          }
        },
      );

  Text _buildDownloadStatus(AppUpdateController logic,
      AsyncSnapshot<DownloadInfo> snapshot, BuildContext context) {
    return Text(
      logic.getStatus(snapshot.data!.status),
      style: AppStyles.style14Bold.copyWith(
        color: Theme.of(context).textTheme.bodyLarge!.color,
      ),
    );
  }

  LinearProgressIndicator _buildProgressIndicator(
      double progress, BuildContext context) {
    return LinearProgressIndicator(
      value: progress,
      backgroundColor: Theme.of(context).dialogBackgroundColor,
      valueColor: AlwaysStoppedAnimation<Color>(
        Theme.of(context).textTheme.bodyLarge!.color!,
      ),
    );
  }

  NxOutlinedButton _buildResumePauseBtn(
      AsyncSnapshot<DownloadInfo> snapshot, BuildContext context) {
    return NxOutlinedButton(
      label: snapshot.data!.status == DownloadStatus.STATUS_RUNNING
          ? 'Pause'.toUpperCase()
          : 'Resume'.toUpperCase(),
      bgColor: snapshot.data!.status == DownloadStatus.STATUS_RUNNING
          ? Colors.transparent
          : Theme.of(context).textTheme.bodyLarge!.color,
      borderColor: Theme.of(context).textTheme.bodyLarge!.color,
      padding: Dimens.edgeInsets0_8,
      width: Dimens.screenWidth,
      height: Dimens.fiftySix,
      labelStyle: AppStyles.style16Bold.copyWith(
        color: snapshot.data!.status == DownloadStatus.STATUS_RUNNING
            ? Theme.of(context).textTheme.bodyLarge!.color
            : Theme.of(context).scaffoldBackgroundColor,
      ),
      onTap: snapshot.data!.status == DownloadStatus.STATUS_RUNNING
          ? () => RUpgrade.pause(snapshot.data!.id!)
          : () => RUpgrade.upgradeWithId(snapshot.data!.id!),
    );
  }

  Column _buildDownloadSizeAndSpeed(
    String size,
    String totalSize,
    String downloadSpeed,
    AppUpdateController logic,
    AsyncSnapshot<DownloadInfo> snapshot,
    BuildContext context,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '$size MB / $totalSize MB',
          style: AppStyles.style14Bold.copyWith(
            color: Theme.of(context).textTheme.bodyLarge!.color,
          ),
        ),
        Dimens.boxHeight8,
        Text(
          '$downloadSpeed',
          style: AppStyles.style14Bold.copyWith(
            color: Theme.of(context).textTheme.bodyLarge!.color,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: Dimens.screenWidth,
          height: Dimens.screenHeight,
          child: _buildBody(context),
        ),
      ),
    );
  }
}
