import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';
import 'package:r_upgrade/r_upgrade.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/extensions/string_extensions.dart';
import 'package:social_media_app/global_widgets/primary_outlined_btn.dart';
import 'package:social_media_app/modules/app_update/app_update_controller.dart';
import 'package:social_media_app/utils/utility.dart';

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
                children: [
                  AppUtility.buildAppLogo(fontSize: Dimens.thirtyTwo),
                  Dimens.boxHeight16,
                  RichText(
                    text: TextSpan(
                      text: StringValues.appUpdateAvailable.toTitleCase(),
                      style: AppStyles.style18Bold.copyWith(
                        color:
                            Theme.of(Get.context!).textTheme.bodyText1!.color,
                      ),
                    ),
                  ),
                  Dimens.boxHeight16,
                  Container(
                    height: Dimens.hundred * 2.4,
                    decoration: BoxDecoration(
                      color: Theme.of(Get.context!).dialogBackgroundColor,
                      borderRadius: BorderRadius.circular(Dimens.eight),
                    ),
                    child: Markdown(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      padding: Dimens.edgeInsets8,
                      data: logic.changelog,
                    ),
                  ),
                  Dimens.boxHeight20,
                  NxOutlinedButton(
                    label: 'Update Now'.toTitleCase(),
                    bgColor: Theme.of(Get.context!).textTheme.bodyText1!.color,
                    borderColor:
                        Theme.of(Get.context!).textTheme.bodyText1!.color,
                    padding: Dimens.edgeInsets0_8,
                    width: Dimens.screenWidth,
                    height: Dimens.fourty,
                    labelStyle: AppStyles.style14Normal.copyWith(
                      color: Theme.of(Get.context!).scaffoldBackgroundColor,
                    ),
                    onTap: () => logic.downloadAppUpdate(),
                  ),
                  Dimens.boxHeight16,
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDownloadWindow(AppUpdateController logic) => StreamBuilder(
        stream: RUpgrade.stream,
        builder: (_, AsyncSnapshot<DownloadInfo> snapshot) {
          if (snapshot.hasData) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: Dimens.screenWidth * 0.5,
                  width: Dimens.screenWidth * 0.5,
                  child: CircleDownloadWidget(
                    backgroundColor: snapshot.data!.status ==
                            DownloadStatus.STATUS_SUCCESSFUL
                        ? ColorValues.successColor
                        : null,
                    progress: snapshot.data!.percent! / 100,
                    child: Center(
                      child: Text(
                        snapshot.data!.status == DownloadStatus.STATUS_RUNNING
                            ? snapshot.data!.getSpeedString()
                            : logic.getStatus(snapshot.data!.status),
                        style: AppStyles.style14Bold.copyWith(
                          color:
                              Theme.of(Get.context!).textTheme.bodyText1!.color,
                        ),
                      ),
                    ),
                  ),
                ),
                Dimens.boxHeight32,
                NxOutlinedButton(
                  label: snapshot.data!.status == DownloadStatus.STATUS_RUNNING
                      ? 'Pause'.toTitleCase()
                      : 'Resume'.toTitleCase(),
                  borderColor:
                      Theme.of(Get.context!).textTheme.bodyText1!.color,
                  padding: Dimens.edgeInsets0_8,
                  width: Dimens.hundred,
                  height: Dimens.thirtySix,
                  labelStyle: AppStyles.style14Normal.copyWith(
                    color: Theme.of(Get.context!).textTheme.bodyText1!.color,
                  ),
                  onTap: snapshot.data!.status == DownloadStatus.STATUS_RUNNING
                      ? () => RUpgrade.pause(snapshot.data!.id!)
                      : () => RUpgrade.upgradeWithId(snapshot.data!.id!),
                ),
              ],
            );
          } else {
            return SizedBox(
              width: Dimens.sixty,
              height: Dimens.sixty,
              child: CircularProgressIndicator(strokeWidth: Dimens.two),
            );
          }
        },
      );
}

class CircleDownloadWidget extends StatelessWidget {
  final double? progress;
  final Widget? child;
  final Color? backgroundColor;

  const CircleDownloadWidget({
    Key? key,
    this.progress,
    this.child,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: CustomPaint(
        painter: CircleDownloadCustomPainter(
          backgroundColor ?? Theme.of(context).dialogBackgroundColor,
          ColorValues.primaryColor,
          progress,
        ),
        child: child,
      ),
    );
  }
}

class CircleDownloadCustomPainter extends CustomPainter {
  final Color? backgroundColor;
  final Color color;
  final double? progress;

  Paint? mPaint;

  CircleDownloadCustomPainter(this.backgroundColor, this.color, this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    mPaint ??= Paint();
    var width = size.width;
    var height = size.height;

    var progressRect =
        Rect.fromLTRB(0, height * (1 - progress!), width, height);
    var widgetRect = Rect.fromLTWH(0, 0, width, height);
    canvas.clipPath(Path()..addOval(widgetRect));

    canvas.drawRect(widgetRect, mPaint!..color = backgroundColor!);
    canvas.drawRect(progressRect, mPaint!..color = color);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
