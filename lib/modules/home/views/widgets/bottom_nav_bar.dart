import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/modules/chat/controllers/chat_controller.dart';
import 'package:social_media_app/modules/home/controllers/home_controller.dart';
import 'package:social_media_app/modules/home/controllers/notification_controller.dart';
import 'package:social_media_app/modules/home/controllers/profile_controller.dart';
import 'package:social_media_app/modules/home/views/widgets/nav_icon_btn.dart';

class NxBottomNavBar extends StatelessWidget {
  const NxBottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (logic) {
        return Container(
          height: Dimens.fiftySix,
          width: Dimens.screenWidth,
          padding: Dimens.edgeInsetsHorizDefault,
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildHomeIconBtn(logic, context),
              _buildTrendingIconBtn(logic, context),
              _buildChatIconBtn(logic, context),
              _buildNotificationIconBtn(logic, context),
            ],
          ),
        );
      },
    );
  }

  GetBuilder<NotificationController> _buildNotificationIconBtn(
      HomeController logic, BuildContext context) {
    return GetBuilder<NotificationController>(
      builder: (con) {
        var isUnreadNotification =
            con.notificationList.map((e) => e.isRead).contains(false) ||
                con.followRequestController.followRequestList.isNotEmpty;

        return NavIconBtn(
          icon: logic.currentPageIndex == 3
              ? Icons.notifications
              : Icons.notifications_outlined,
          iconColor: logic.currentPageIndex == 3
              ? ColorValues.primaryColor
              : Theme.of(context).textTheme.bodyText1!.color,
          isActive: logic.currentPageIndex == 3,
          itemsCount: 4,
          onTap: () => logic.changePage(3),
          showBadge: isUnreadNotification ? true : false,
        );
      },
    );
  }

  GetBuilder<ChatController> _buildChatIconBtn(
      HomeController logic, BuildContext context) {
    return GetBuilder<ChatController>(
      builder: (con) {
        var isUnreadMessages = con.lastMessageList
            .map((e) =>
                e.receiverId ==
                    ProfileController.find.profileDetails!.user!.id &&
                e.seen == false)
            .contains(true);

        return NavIconBtn(
          icon:
              logic.currentPageIndex == 2 ? Icons.email : Icons.email_outlined,
          iconColor: logic.currentPageIndex == 2
              ? ColorValues.primaryColor
              : Theme.of(context).textTheme.bodyText1!.color,
          isActive: logic.currentPageIndex == 2,
          itemsCount: 4,
          onTap: () => logic.changePage(2),
          showBadge: isUnreadMessages ? true : false,
        );
      },
    );
  }

  NavIconBtn _buildTrendingIconBtn(HomeController logic, BuildContext context) {
    return NavIconBtn(
      icon:
          logic.currentPageIndex == 1 ? Icons.numbers : Icons.numbers_outlined,
      iconColor: logic.currentPageIndex == 1
          ? ColorValues.primaryColor
          : Theme.of(context).textTheme.bodyText1!.color,
      isActive: logic.currentPageIndex == 1,
      itemsCount: 5,
      onTap: () => logic.changePage(1),
    );
  }

  NavIconBtn _buildHomeIconBtn(HomeController logic, BuildContext context) {
    return NavIconBtn(
      icon: logic.currentPageIndex == 0 ? Icons.home : Icons.home_outlined,
      iconColor: logic.currentPageIndex == 0
          ? ColorValues.primaryColor
          : Theme.of(context).textTheme.bodyText1!.color,
      isActive: logic.currentPageIndex == 0,
      itemsCount: 5,
      onTap: () => logic.changePage(0),
    );
  }
}
