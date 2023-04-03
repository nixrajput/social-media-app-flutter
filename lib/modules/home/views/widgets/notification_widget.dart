import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/apis/models/entities/notification.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/extensions/date_extensions.dart';
import 'package:social_media_app/app_widgets/avatar_widget.dart';
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
      onLongPress: () => _showDeletePostOptions(context),
      child: Container(
        margin: Dimens.edgeInsets8_0,
        padding: Dimens.edgeInsets8,
        constraints: BoxConstraints(
          maxWidth: Dimens.screenWidth,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(Dimens.four),
          boxShadow: AppStyles.defaultShadow,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => RouteManagement.goToUserProfileDetailsViewByUserId(
                  notification.from.id),
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
                                .bodyLarge!
                                .color,
                          ),
                        ),
                        TextSpan(
                          text: " ${notification.body}",
                          style: AppStyles.style13Normal.copyWith(
                            color: Theme.of(Get.context!)
                                .textTheme
                                .bodyLarge!
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
                      color:
                          Theme.of(Get.context!).textTheme.titleMedium!.color,
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

  Future<void> _showDeletePostOptions(BuildContext context) async {
    AppUtility.showDeleteDialog(
      context,
      () async {
        AppUtility.closeDialog();
        await NotificationController.find.deleteNotification(notification.id);
      },
    );
  }
}
