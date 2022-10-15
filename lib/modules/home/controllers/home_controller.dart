import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/global_widgets/circular_network_image.dart';
import 'package:social_media_app/global_widgets/keep_alive_page.dart';
import 'package:social_media_app/modules/chat/controllers/chat_controller.dart';
import 'package:social_media_app/modules/home/controllers/notification_controller.dart';
import 'package:social_media_app/modules/home/controllers/profile_controller.dart';
import 'package:social_media_app/modules/home/views/tab_views/chats_tab.dart';
import 'package:social_media_app/modules/home/views/tab_views/home_tab.dart';
import 'package:social_media_app/modules/home/views/tab_views/notification_tab.dart';
import 'package:social_media_app/modules/home/views/tab_views/profile_tab.dart';
import 'package:social_media_app/modules/home/views/tab_views/trending_tab.dart';

class HomeController extends GetxController {
  static HomeController get find => Get.find();

  int _currentPageIndex = 0;

  int get currentPageIndex => _currentPageIndex;

  final pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  List<Widget> buildPages() {
    return [
      const KeepAlivePage(child: HomeTabView()),
      const KeepAlivePage(child: TrendingTabView()),
      const KeepAlivePage(child: NotificationTabView()),
      const KeepAlivePage(child: ChatsTabView()),
      const KeepAlivePage(child: ProfileTabView()),
    ];
  }

  List<BottomNavigationBarItem> buildBottomNavItems() {
    return [
      BottomNavigationBarItem(
        icon: _currentPageIndex == 0
            ? const Icon(Icons.home)
            : const Icon(Icons.home_outlined),
        label: StringValues.home,
      ),
      BottomNavigationBarItem(
        icon: _currentPageIndex == 1
            ? const Icon(Icons.numbers)
            : const Icon(Icons.numbers_outlined),
        label: StringValues.search,
      ),
      BottomNavigationBarItem(
        icon: GetBuilder<NotificationController>(
          builder: (logic) => Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (logic.notificationList.map((e) => e.isRead).contains(false))
                Container(
                  width: Dimens.six,
                  height: Dimens.six,
                  decoration: const BoxDecoration(
                    color: ColorValues.errorColor,
                    shape: BoxShape.circle,
                  ),
                ),
              _currentPageIndex == 2
                  ? const Icon(Icons.notifications)
                  : const Icon(Icons.notifications_outlined),
            ],
          ),
        ),
        label: StringValues.notifications,
      ),
      BottomNavigationBarItem(
        icon: GetBuilder<ChatController>(
          builder: (logic) => Column(
            children: [
              if (logic.lastMessageList
                  .map((e) =>
                      e.receiverId ==
                          ProfileController.find.profileDetails!.user!.id &&
                      e.seen == false)
                  .contains(true))
                Container(
                  width: Dimens.six,
                  height: Dimens.six,
                  decoration: const BoxDecoration(
                    color: ColorValues.errorColor,
                    shape: BoxShape.circle,
                  ),
                ),
              _currentPageIndex == 3
                  ? const Icon(Icons.email)
                  : const Icon(Icons.email_outlined)
            ],
          ),
        ),
        label: StringValues.message,
      ),
      BottomNavigationBarItem(
        icon: GetBuilder<ProfileController>(
          builder: (logic) {
            if (logic.profileDetails == null ||
                logic.profileDetails!.user == null ||
                logic.profileDetails!.user!.avatar == null ||
                logic.profileDetails!.user!.avatar!.url == null) {
              return const Icon(Icons.person);
            }
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  Dimens.fourtyEight * 2,
                ),
                border: Border.all(
                  color: currentPageIndex == 4
                      ? ColorValues.primaryColor
                      : Colors.transparent,
                  width: currentPageIndex == 4 ? Dimens.two : Dimens.zero,
                ),
              ),
              child: NxCircleNetworkImage(
                imageUrl: logic.profileDetails!.user!.avatar!.url!,
                radius: Dimens.ten,
                borderWidth: Dimens.one / 2,
              ),
            );
          },
        ),
        label: StringValues.profile,
      ),
    ];
  }

  void changePage(int index) {
    _currentPageIndex = index;
    update();
  }

  void bottomNavTapped(int index) {
    _currentPageIndex = index;
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutCirc,
    );
    update();
  }
}
