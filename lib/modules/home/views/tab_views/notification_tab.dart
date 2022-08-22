import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/global_widgets/custom_app_bar.dart';
import 'package:social_media_app/global_widgets/primary_outlined_btn.dart';
import 'package:social_media_app/modules/home/controllers/notification_controller.dart';
import 'package:social_media_app/modules/home/views/widgets/notification_widget.dart';

class NotificationTabView extends StatelessWidget {
  const NotificationTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<NotificationController>(
        builder: (logic) => RefreshIndicator(
          onRefresh: logic.getNotifications,
          child: SizedBox(
            width: Dimens.screenWidth,
            height: Dimens.screenHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                NxAppBar(
                  title: StringValues.notifications,
                  padding: Dimens.edgeInsets8_16,
                  showBackBtn: false,
                ),
                Dimens.boxHeight16,
                _buildNotificationBody(logic),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationBody(NotificationController logic) {
    if (logic.isLoading) {
      return const Expanded(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    if (logic.notifications == null || logic.notifications!.results!.isEmpty) {
      return Expanded(
        child: Padding(
          padding: Dimens.edgeInsets0_16,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Dimens.boxHeight8,
              Text(
                StringValues.noNotifications,
                style: AppStyles.style32Bold.copyWith(
                  color: Theme.of(Get.context!).textTheme.subtitle1!.color,
                ),
                textAlign: TextAlign.center,
              ),
              Dimens.boxHeight16,
              NxOutlinedButton(
                width: Dimens.hundred,
                height: Dimens.thirtySix,
                label: StringValues.refresh,
                onTap: () => logic.getNotifications(),
              ),
            ],
          ),
        ),
      );
    }

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: Dimens.edgeInsets0_16,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: logic.notifications!.results!
              .map((item) => NotificationWidget(notification: item))
              .toList(),
        ),
      ),
    );
  }
}
