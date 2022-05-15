import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:social_media_app/apis/models/entities/notification.dart';
import 'package:social_media_app/apis/models/entities/user.dart';
import 'package:social_media_app/common/circular_asset_image.dart';
import 'package:social_media_app/common/circular_network_image.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({Key? key, required this.notification})
      : super(key: key);

  final ApiNotification notification;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: Dimens.edgeInsetsOnlyBottom16,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildProfileImage(notification.user),
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
                        style: AppStyles.style14Bold,
                      ),
                      TextSpan(
                        text: " ${notification.body}",
                        style: AppStyles.style14Normal,
                      ),
                    ],
                  ),
                ),
                Dimens.boxHeight4,
                Text(
                  GetTimeAgo.parse(notification.createdAt),
                  style: TextStyle(
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

  Widget _buildProfileImage(User? user) {
    if (user != null && user.avatar != null && user.avatar?.url != null) {
      return NxCircleNetworkImage(
        imageUrl: user.avatar!.url!,
        radius: Dimens.twentyFour,
      );
    }
    return NxCircleAssetImage(
      imgAsset: AssetValues.avatar,
      radius: Dimens.twentyFour,
    );
  }
}
