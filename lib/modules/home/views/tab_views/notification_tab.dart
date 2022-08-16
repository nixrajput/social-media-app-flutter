import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/common/asset_image.dart';
import 'package:social_media_app/common/custom_app_bar.dart';
import 'package:social_media_app/constants/assets.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/modules/home/controllers/notification_controller.dart';
import 'package:social_media_app/modules/home/views/widgets/notification_widget.dart';

class NotificationTabView extends StatelessWidget {
  const NotificationTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<NotificationController>(
        builder: (logic) => RefreshIndicator(
          onRefresh: logic.fetchNotifications,
          child: SizedBox(
            width: Dimens.screenWidth,
            height: Dimens.screenHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const NxAppBar(
                  title: StringValues.notifications,
                  showBackBtn: false,
                ),
                // _buildNotificationBody(logic),
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
      ));
    }
    if (logic.notifications == null || logic.notifications!.count! <= 0) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          NxAssetImage(
            imgAsset: AssetValues.error,
            width: Dimens.hundred * 2,
            height: Dimens.hundred * 2,
          ),
          Dimens.boxHeight8,
          Text(
            StringValues.noNotifications,
            style: AppStyles.style20Normal.copyWith(
              color: Theme.of(Get.context!).textTheme.subtitle1!.color,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      );
    }

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: Dimens.edgeInsets8,
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
