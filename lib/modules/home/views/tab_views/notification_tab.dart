import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/extensions/date_extensions.dart';
import 'package:social_media_app/global_widgets/circular_progress_indicator.dart';
import 'package:social_media_app/global_widgets/custom_app_bar.dart';
import 'package:social_media_app/global_widgets/custom_refresh_indicator.dart';
import 'package:social_media_app/global_widgets/primary_text_btn.dart';
import 'package:social_media_app/modules/home/controllers/notification_controller.dart';
import 'package:social_media_app/modules/home/views/widgets/notification_widget.dart';

class NotificationTabView extends StatelessWidget {
  const NotificationTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: NxRefreshIndicator(
        onRefresh: NotificationController.find.getNotifications,
        showProgress: false,
        triggerMode: NxRefreshIndicatorTriggerMode.anywhere,
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
              Dimens.boxHeight8,
              _buildNotificationBody(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationBody() {
    return GetBuilder<NotificationController>(
      builder: (logic) {
        if (logic.isLoading &&
            (logic.notificationData == null ||
                logic.notificationList.isEmpty)) {
          return const Expanded(
            child: Center(child: NxCircularProgressIndicator()),
          );
        }

        if (logic.notificationData == null || logic.notificationList.isEmpty) {
          return Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              padding: Dimens.edgeInsets0_16,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Dimens.boxHeight(Dimens.screenHeight * 0.25),
                  Text(
                    StringValues.noNotifications,
                    style: AppStyles.style32Bold.copyWith(
                      color: Theme.of(Get.context!).textTheme.subtitle1!.color,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Dimens.boxHeight16,
                ],
              ),
            ),
          );
        }

        return Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            child: Padding(
              padding: Dimens.edgeInsets0_16,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (logic.isLoading &&
                      (logic.notificationData != null ||
                          logic.notificationList.isNotEmpty))
                    const Center(child: NxCircularProgressIndicator()),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: logic.notificationList.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (ctx, index) {
                      var item = logic.notificationList[index];
                      var isSameDate = true;

                      final date = item.createdAt;

                      if (index == 0) {
                        isSameDate = false;
                      } else {
                        final previousDate =
                            logic.notificationList[index - 1].createdAt;
                        isSameDate = date.isSameDate(previousDate);
                      }

                      if (index == 0 || !isSameDate) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              date.formatDate(),
                              style: AppStyles.style12Bold.copyWith(
                                color: Theme.of(Get.context!)
                                    .textTheme
                                    .subtitle1!
                                    .color,
                              ),
                            ),
                            Dimens.boxHeight8,
                            NotificationWidget(
                              notification: item,
                              totalLength: logic.notificationList.length,
                              index: index,
                              isSameDay: isSameDate,
                            ),
                          ],
                        );
                      }

                      return NotificationWidget(
                        notification: item,
                        totalLength: logic.notificationList.length,
                        index: index,
                        isSameDay: isSameDate,
                      );
                    },
                  ),
                  if (logic.isMoreLoading ||
                      (logic.notificationData!.results != null &&
                          logic.notificationData!.hasNextPage!))
                    Dimens.boxHeight8,
                  if (logic.isMoreLoading)
                    const Center(child: NxCircularProgressIndicator()),
                  if (!logic.isMoreLoading &&
                      logic.notificationData!.results != null &&
                      logic.notificationData!.hasNextPage!)
                    Center(
                      child: NxTextButton(
                        label: 'Load more notifications',
                        onTap: logic.loadMore,
                        labelStyle: AppStyles.style14Bold.copyWith(
                          color: ColorValues.primaryLightColor,
                        ),
                        padding: Dimens.edgeInsets8_0,
                      ),
                    ),
                  Dimens.boxHeight16,
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
