import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/global_widgets/circular_progress_indicator.dart';
import 'package:social_media_app/global_widgets/custom_app_bar.dart';
import 'package:social_media_app/global_widgets/custom_refresh_indicator.dart';
import 'package:social_media_app/global_widgets/primary_text_btn.dart';
import 'package:social_media_app/global_widgets/unfocus_widget.dart';
import 'package:social_media_app/modules/follow_request/follow_request_controller.dart';
import 'package:social_media_app/modules/home/controllers/notification_controller.dart';
import 'package:social_media_app/modules/home/views/widgets/notification_widget.dart';
import 'package:social_media_app/routes/route_management.dart';

class NotificationTabView extends StatelessWidget {
  const NotificationTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return UnFocusWidget(
      child: SafeArea(
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
                  padding: Dimens.edgeInsetsDefault,
                  showBackBtn: false,
                ),
                _buildBody(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
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
              padding: Dimens.edgeInsetsHorizDefault,
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
            //padding: Dimens.edgeInsetsHorizDefault,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (logic.isLoading &&
                    (logic.notificationData != null ||
                        logic.notificationList.isNotEmpty))
                  const Center(child: NxCircularProgressIndicator()),
                Dimens.boxHeight8,
                _buildFollowRequestBtn(context),
                Dimens.boxHeight16,
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: logic.notificationList.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (ctx, index) {
                    var item = logic.notificationList[index];

                    return NotificationWidget(
                      notification: item,
                      totalLength: logic.notificationList.length,
                      index: index,
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
        );
      },
    );
  }

  GetBuilder<FollowRequestController> _buildFollowRequestBtn(
      BuildContext context) {
    return GetBuilder<FollowRequestController>(
      builder: (logic) => InkWell(
        onTap: RouteManagement.goToFollowRequestsView,
        child: Container(
          padding: Dimens.edgeInsetsDefault,
          margin: Dimens.edgeInsetsHorizDefault,
          decoration: BoxDecoration(
            color: Theme.of(context).bottomAppBarColor,
            borderRadius: BorderRadius.circular(Dimens.four),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.person_add_alt_rounded,
                        size: Dimens.twenty,
                        color: Theme.of(context).textTheme.bodyText1!.color,
                      ),
                      Dimens.boxWidth8,
                      Text(
                        StringValues.followRequests,
                        style: AppStyles.style14Bold.copyWith(
                          color: Theme.of(context).textTheme.bodyText1!.color,
                        ),
                      ),
                    ],
                  ),
                  Container(
                      width: Dimens.thirtyTwo,
                      height: Dimens.thirtyTwo,
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          logic.followRequestList.length.toString(),
                          style: AppStyles.style12Bold.copyWith(
                            color: Theme.of(context).textTheme.bodyText1!.color,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
