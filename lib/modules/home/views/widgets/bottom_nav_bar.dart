import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/modules/chat/controllers/chat_controller.dart';
import 'package:social_media_app/modules/home/controllers/home_controller.dart';
import 'package:social_media_app/modules/home/controllers/notification_controller.dart';
import 'package:social_media_app/modules/home/controllers/profile_controller.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) => StyleProvider(
        style: _BottomNavStyle(),
        child: ConvexAppBar.badge(
          {
            2: _buildChatBadge(),
            3: _buildNotificationBadge(),
          },
          badgeMargin: Dimens.edgeInsets0.copyWith(
            bottom: Dimens.thirtyTwo,
          ),
          badgePadding: Dimens.edgeInsets0,
          style: TabStyle.reactCircle,
          height: Dimens.fiftySix,
          items: controller.buildBottomNavItems(),
          initialActiveIndex: 0,
          color: Theme.of(context).textTheme.bodyText1!.color!,
          activeColor: Theme.of(context).textTheme.bodyText1!.color!,
          disableDefaultTabController: true,
          onTap: (index) => controller.bottomNavTapped(index),
          elevation: Dimens.eight,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          shadowColor: Theme.of(context).shadowColor,
          top: -Dimens.sixTeen,
          cornerRadius: Dimens.zero,
          curve: Curves.easeInOut,
        ),
      ),
    );
  }

  Widget _buildChatBadge() {
    return GetBuilder<ChatController>(
      builder: (logic) => logic.lastMessageList
              .map((e) =>
                  e.receiverId ==
                      ProfileController.find.profileDetails!.user!.id &&
                  e.seen == false)
              .contains(true)
          ? Container(
              width: Dimens.eight,
              height: Dimens.eight,
              decoration: const BoxDecoration(
                color: ColorValues.primaryColor,
                shape: BoxShape.circle,
              ),
            )
          : Dimens.shrinkedBox,
    );
  }

  Widget _buildNotificationBadge() {
    return GetBuilder<NotificationController>(
      builder: (logic) =>
          (logic.notificationList.map((e) => e.isRead).contains(false) ||
                  logic.followRequestController.followRequestList.isNotEmpty)
              ? Container(
                  width: Dimens.eight,
                  height: Dimens.eight,
                  decoration: const BoxDecoration(
                    color: ColorValues.primaryColor,
                    shape: BoxShape.circle,
                  ),
                )
              : Dimens.shrinkedBox,
    );
  }
}

class _BottomNavStyle extends StyleHook {
  @override
  double get activeIconMargin => Dimens.twelve;

  @override
  double get activeIconSize => Dimens.twentyEight;

  @override
  double? get iconSize => Dimens.twentyFour;

  @override
  TextStyle textStyle(Color color, String? fontFamily) {
    return AppStyles.style16Bold;
  }
}
