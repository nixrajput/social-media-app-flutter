import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:social_media_app/apis/models/entities/notification.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/global_widgets/avatar_widget.dart';
import 'package:social_media_app/global_widgets/primary_outlined_btn.dart';
import 'package:social_media_app/modules/home/controllers/notification_controller.dart';
import 'package:social_media_app/routes/route_management.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget(
      {Key? key,
      required this.notification,
      required this.totalLength,
      required this.index})
      : super(key: key);

  final ApiNotification notification;
  final int totalLength;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (notification.type == "like" || notification.type == "comment") {
          NotificationController.find.goToPost(notification.refId!);
          return;
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: Dimens.edgeInsets8,
            decoration: BoxDecoration(
              color: Theme.of(Get.context!).dialogBackgroundColor,
              borderRadius: (index == 0 || index == totalLength - 1)
                  ? BorderRadius.only(
                      topLeft: Radius.circular(
                          index == 0 ? Dimens.eight : Dimens.zero),
                      topRight: Radius.circular(
                          index == 0 ? Dimens.eight : Dimens.zero),
                      bottomLeft: Radius.circular(index == totalLength - 1
                          ? Dimens.eight
                          : Dimens.zero),
                      bottomRight: Radius.circular(index == totalLength - 1
                          ? Dimens.eight
                          : Dimens.zero),
                    )
                  : const BorderRadius.all(Radius.zero),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () =>
                      RouteManagement.goToUserProfileView(notification.user.id),
                  child: AvatarWidget(
                    avatar: notification.user.avatar,
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
                              text: notification.user.uname,
                              style: AppStyles.style14Bold.copyWith(
                                color: Theme.of(Get.context!)
                                    .textTheme
                                    .bodyText1!
                                    .color,
                                height: 1.25,
                              ),
                            ),
                            TextSpan(
                              text: " ${notification.body}",
                              style: AppStyles.style14Normal.copyWith(
                                color: Theme.of(Get.context!)
                                    .textTheme
                                    .bodyText1!
                                    .color,
                                height: 1.25,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Dimens.boxHeight4,
                      Text(
                        GetTimeAgo.parse(notification.createdAt),
                        style: AppStyles.style12Normal.copyWith(
                          color:
                              Theme.of(Get.context!).textTheme.subtitle1!.color,
                        ),
                      ),
                    ],
                  ),
                ),
                Dimens.boxWidth16,
                if (notification.type != "followRequest" &&
                    !notification.isRead)
                  InkWell(
                    onTap: () => NotificationController.find
                        .markNotificationRead(notification.id),
                    child: Text(
                      'Mark Read',
                      style: AppStyles.style12Bold.copyWith(
                        color: ColorValues.primaryColor,
                      ),
                    ),
                  )
                // else if (notification.type == 'followRequestAccepted')
                //   NxOutlinedButton(
                //     label: StringValues.remove,
                //     bgColor: ColorValues.errorColor,
                //     borderColor: Colors.transparent,
                //     borderStyle: BorderStyle.none,
                //     onTap: () => NotificationController.find
                //         .removeFollowRequest(notification.id),
                //     padding: Dimens.edgeInsets0_8,
                //     borderWidth: Dimens.one,
                //     height: Dimens.thirty,
                //     borderRadius: Dimens.eight,
                //     labelStyle: AppStyles.style13Normal.copyWith(
                //       color: ColorValues.whiteColor,
                //     ),
                //   )
                else if (notification.type == "followRequest")
                  Row(
                    children: [
                      NxOutlinedButton(
                        label: StringValues.accept,
                        bgColor: ColorValues.successColor,
                        borderColor: Colors.transparent,
                        borderStyle: BorderStyle.none,
                        onTap: () => NotificationController.find
                            .acceptFollowRequest(notification.id),
                        padding: Dimens.edgeInsets0_8,
                        borderWidth: Dimens.one,
                        height: Dimens.thirty,
                        borderRadius: Dimens.eight,
                        labelStyle: AppStyles.style13Normal.copyWith(
                          color: ColorValues.whiteColor,
                        ),
                      ),
                      Dimens.boxWidth8,
                      NxOutlinedButton(
                        label: StringValues.remove,
                        bgColor: ColorValues.errorColor,
                        borderColor: Colors.transparent,
                        borderStyle: BorderStyle.none,
                        onTap: () => NotificationController.find
                            .removeFollowRequest(notification.id),
                        padding: Dimens.edgeInsets0_8,
                        borderWidth: Dimens.one,
                        height: Dimens.thirty,
                        borderRadius: Dimens.eight,
                        labelStyle: AppStyles.style13Normal.copyWith(
                          color: ColorValues.whiteColor,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
          if (index != totalLength - 1) Dimens.divider,
        ],
      ),
    );
  }
}
