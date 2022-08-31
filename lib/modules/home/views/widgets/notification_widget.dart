import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:social_media_app/apis/models/entities/notification.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/global_widgets/avatar_widget.dart';
import 'package:social_media_app/routes/route_management.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({Key? key, required this.notification})
      : super(key: key);

  final ApiNotification notification;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: Dimens.edgeInsetsOnlyBottom16,
      padding: Dimens.edgeInsets8,
      decoration: BoxDecoration(
        color: Theme.of(Get.context!).dialogBackgroundColor,
        borderRadius: BorderRadius.circular(Dimens.eight),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () =>
                RouteManagement.goToUserProfileView(notification.user.id),
            child: AvatarWidget(
              avatar: notification.user.avatar,
              size: Dimens.twenty,
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
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: notification.user.uname,
                        style: AppStyles.style14Bold.copyWith(
                          color:
                              Theme.of(Get.context!).textTheme.bodyText1!.color,
                        ),
                      ),
                      TextSpan(
                        text: " ${notification.body}",
                        style: AppStyles.style14Normal.copyWith(
                          color:
                              Theme.of(Get.context!).textTheme.bodyText1!.color,
                        ),
                      ),
                    ],
                  ),
                ),
                Dimens.boxHeight4,
                Text(
                  GetTimeAgo.parse(notification.createdAt),
                  style: AppStyles.style12Normal.copyWith(
                    color: Theme.of(Get.context!).textTheme.subtitle1!.color,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
