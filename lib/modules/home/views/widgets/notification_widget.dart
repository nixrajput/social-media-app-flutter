import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/apis/models/entities/notification.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/extensions/date_extensions.dart';
import 'package:social_media_app/global_widgets/avatar_widget.dart';
import 'package:social_media_app/global_widgets/primary_text_btn.dart';
import 'package:social_media_app/modules/home/controllers/notification_controller.dart';
import 'package:social_media_app/routes/route_management.dart';
import 'package:social_media_app/utils/utility.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({
    Key? key,
    required this.notification,
    required this.totalLength,
    required this.index,
  }) : super(key: key);

  final NotificationModel notification;
  final int totalLength;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (notification.type == "postLike" ||
            notification.type == "postComment" ||
            notification.type == "postMention") {
          NotificationController.find.goToPost(notification.refId!);
          return;
        } else if (notification.type == 'followRequest') {
          RouteManagement.goToFollowRequestsView();
          return;
        }
      },
      onLongPress: _showDeletePostOptions,
      child: Container(
        margin: index != (totalLength - 1)
            ? Dimens.edgeInsetsOnlyBottom16
            : Dimens.edgeInsets0,
        padding: Dimens.edgeInsetsHorizDefault,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () =>
                  RouteManagement.goToUserProfileView(notification.from.id),
              child: AvatarWidget(
                avatar: notification.from.avatar,
                size: Dimens.twentyFour,
              ),
            ),
            Dimens.boxWidth8,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  RichText(
                    maxLines: 2,
                    overflow: TextOverflow.clip,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: notification.from.uname,
                          style: AppStyles.style14Bold.copyWith(
                            color: Theme.of(Get.context!)
                                .textTheme
                                .bodyText1!
                                .color,
                          ),
                        ),
                        TextSpan(
                          text: " ${notification.body}",
                          style: AppStyles.style14Normal.copyWith(
                            color: Theme.of(Get.context!)
                                .textTheme
                                .bodyText1!
                                .color,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Dimens.boxHeight4,
                  Text(
                    notification.createdAt.getDateTime(),
                    style: AppStyles.style12Normal.copyWith(
                      color: Theme.of(Get.context!).textTheme.subtitle1!.color,
                    ),
                  ),
                ],
              ),
            ),
            Dimens.boxWidth16,
            if (!notification.isRead)
              InkWell(
                onTap: () => NotificationController.find
                    .markNotificationRead(notification.id),
                child: Text(
                  'Mark Read',
                  style: AppStyles.style13Bold.copyWith(
                    color: ColorValues.primaryColor,
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }

  Future<void> _showDeletePostOptions() async {
    AppUtility.showSimpleDialog(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Dimens.boxHeight8,
          Padding(
            padding: Dimens.edgeInsets0_16,
            child: Text(
              'Delete',
              style: AppStyles.style18Bold,
            ),
          ),
          Dimens.dividerWithHeight,
          Padding(
            padding: Dimens.edgeInsets0_16,
            child: Text(
              StringValues.deleteConfirmationText,
              style: AppStyles.style14Normal,
            ),
          ),
          Dimens.boxHeight8,
          Padding(
            padding: Dimens.edgeInsets0_16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                NxTextButton(
                  label: StringValues.no,
                  labelStyle: AppStyles.style16Bold.copyWith(
                    color: ColorValues.errorColor,
                  ),
                  onTap: AppUtility.closeDialog,
                  padding: Dimens.edgeInsets8,
                ),
                Dimens.boxWidth16,
                NxTextButton(
                  label: StringValues.yes,
                  labelStyle: AppStyles.style16Bold.copyWith(
                    color: ColorValues.successColor,
                  ),
                  onTap: () async {
                    AppUtility.closeDialog();
                    await NotificationController.find
                        .deleteNotification(notification.id);
                  },
                  padding: Dimens.edgeInsets8,
                ),
              ],
            ),
          ),
          Dimens.boxHeight8,
        ],
      ),
    );
  }
}
