import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';
import 'package:r_upgrade/r_upgrade.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: Dimens.screenWidth,
          height: Dimens.screenHeight,
          child: _buildBody(),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: Dimens.edgeInsets0_16,
      child: GetBuilder<AppUpdateController>(
        builder: (logic) {
          if (logic.isLoading) {
            return Center(
              child: _buildDownloadWindow(logic),
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
                  _buildUpdateHelpText(),
                  Dimens.boxHeight16,
                  _buildChangeLog(logic),
                  Dimens.boxHeight16,
                  _buildUpdateNowBtn(logic),
                  Dimens.boxHeight16,
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Column _buildUpdateHelpText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          StringValues.updateAvailable.toTitleCase(),
          style: AppStyles.style20Bold.copyWith(
            color: Theme.of(Get.context!).textTheme.bodyText1!.color,
          ),
        ),
        Dimens.boxHeight8,
        Text(
          StringValues.updateAvailableDesc,
          style: AppStyles.style13Normal.copyWith(
            color: Theme.of(Get.context!).textTheme.subtitle1!.color,
          ),
        ),
      ],
    );
  }

  Container _buildChangeLog(AppUpdateController logic) {
    return Container(
      height: Dimens.screenWidth,
      decoration: BoxDecoration(
        color: Theme.of(Get.context!).dialogBackgroundColor,
        borderRadius: BorderRadius.circular(Dimens.eight),
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildCurrentVersionText(logic),
            _buildLatestVersionText(logic),
            Dimens.boxHeight8,
            Dimens.divider,
            _buildChangelogMarkdown(logic),
          ],
        ),
      ),
    );
  }

  NxOutlinedButton _buildUpdateNowBtn(AppUpdateController logic) {
    return NxOutlinedButton(
      label: StringValues.updateNow.toUpperCase(),
      bgColor: Theme.of(Get.context!).textTheme.bodyText1!.color,
      borderColor: Theme.of(Get.context!).textTheme.bodyText1!.color,
      padding: Dimens.edgeInsets0_8,
      width: Dimens.screenWidth,
      height: Dimens.fiftySix,
      labelStyle: AppStyles.style16Bold.copyWith(
        color: Theme.of(Get.context!).scaffoldBackgroundColor,
      ),
      onTap: () => logic.downloadAppUpdate(),
    );
  }

  Markdown _buildChangelogMarkdown(AppUpdateController logic) {
    return Markdown(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      padding: Dimens.edgeInsets8,
      data: logic.updateInfo.changelog!,
      styleSheet: MarkdownStyleSheet(
        p: AppStyles.style13Normal.copyWith(
          color: Theme.of(Get.context!).textTheme.subtitle1!.color,
        ),
        h1: AppStyles.style20Bold.copyWith(
          color: Theme.of(Get.context!).textTheme.bodyText1!.color,
        ),
        h2: AppStyles.style18Bold.copyWith(
          color: Theme.of(Get.context!).textTheme.bodyText1!.color,
        ),
        em: AppStyles.style13Normal.copyWith(
          color: Theme.of(Get.context!).textTheme.subtitle1!.color,
        ),
        blockquote: AppStyles.style13Normal.copyWith(
          color: Theme.of(Get.context!).textTheme.subtitle1!.color,
        ),
        code: AppStyles.style13Bold.copyWith(
          color: ColorValues.successColor,
        ),
      ),
    );
  }

  Padding _buildLatestVersionText(AppUpdateController logic) {
    return Padding(
      padding: Dimens.edgeInsets0_8,
      child: Row(
        children: [
          Text(
            '${StringValues.newVersion} ${StringValues.version}:',
            style: AppStyles.style13Normal.copyWith(
              color: Theme.of(Get.context!).textTheme.subtitle1!.color,
            ),
          ),
          Dimens.boxWidth4,
          Text(
            logic.updateInfo.latestVersion!,
            style: AppStyles.style13Normal.copyWith(
              color: Theme.of(Get.context!).textTheme.bodyText1!.color,
            ),
          ),
        ],
      ),
    );
  }

  Padding _buildCurrentVersionText(AppUpdateController logic) {
    return Padding(
      padding: Dimens.edgeInsets8,
      child: Row(
        children: [
          Text(
            '${StringValues.current} ${StringValues.version}:',
            style: AppStyles.style13Normal.copyWith(
              color: Theme.of(Get.context!).textTheme.subtitle1!.color,
            ),
          ),
          Dimens.boxWidth4,
          Text(
            logic.updateInfo.currentVersion!,
            style: AppStyles.style13Normal.copyWith(
              color: Theme.of(Get.context!).textTheme.bodyText1!.color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDownloadWindow(AppUpdateController logic) => StreamBuilder(
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
                  ),
                Dimens.boxHeight8,
                _buildDownloadStatus(logic, snapshot),
                Dimens.boxHeight32,
                _buildProgressIndicator(progress),
                Dimens.boxHeight32,
                _buildResumePauseBtn(snapshot),
              ],
            );
          } else {
            return const Center(
              child: NxCircularProgressIndicator(),
            );
          }
        },
      );

  Text _buildDownloadStatus(
      AppUpdateController logic, AsyncSnapshot<DownloadInfo> snapshot) {
    return Text(
      logic.getStatus(snapshot.data!.status),
      style: AppStyles.style14Bold.copyWith(
        color: Theme.of(Get.context!).textTheme.bodyText1!.color,
      ),
    );
  }

  LinearProgressIndicator _buildProgressIndicator(double progress) {
    return LinearProgressIndicator(
      value: progress,
      backgroundColor: Theme.of(Get.context!).dialogBackgroundColor,
      valueColor: AlwaysStoppedAnimation<Color>(
        Theme.of(Get.context!).textTheme.bodyText1!.color!,
      ),
    );
  }

  NxOutlinedButton _buildResumePauseBtn(AsyncSnapshot<DownloadInfo> snapshot) {
    return NxOutlinedButton(
      label: snapshot.data!.status == DownloadStatus.STATUS_RUNNING
          ? 'Pause'.toUpperCase()
          : 'Resume'.toUpperCase(),
      bgColor: snapshot.data!.status == DownloadStatus.STATUS_RUNNING
          ? Colors.transparent
          : Theme.of(Get.context!).textTheme.bodyText1!.color,
      borderColor: Theme.of(Get.context!).textTheme.bodyText1!.color,
      padding: Dimens.edgeInsets0_8,
      width: Dimens.screenWidth,
      height: Dimens.fiftySix,
      labelStyle: AppStyles.style16Bold.copyWith(
        color: snapshot.data!.status == DownloadStatus.STATUS_RUNNING
            ? Theme.of(Get.context!).textTheme.bodyText1!.color
            : Theme.of(Get.context!).scaffoldBackgroundColor,
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
      AsyncSnapshot<DownloadInfo> snapshot) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '$size MB / $totalSize MB',
          style: AppStyles.style14Bold.copyWith(
            color: Theme.of(Get.context!).textTheme.bodyText1!.color,
          ),
        ),
        Dimens.boxHeight8,
        Text(
          '$downloadSpeed',
          style: AppStyles.style14Bold.copyWith(
            color: Theme.of(Get.context!).textTheme.bodyText1!.color,
          ),
        ),
      ],
    );
  }
}
