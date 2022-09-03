import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/global_widgets/keep_alive_page.dart';
import 'package:social_media_app/modules/home/controllers/notification_controller.dart';
import 'package:social_media_app/modules/home/views/tab_views/home_tab.dart';
import 'package:social_media_app/modules/home/views/tab_views/notification_tab.dart';
import 'package:social_media_app/modules/home/views/tab_views/profile_tab.dart';
import 'package:social_media_app/modules/home/views/tab_views/trending_tab.dart';

class HomeController extends GetxController {
  static HomeController get find => Get.find();

  int currentPageIndex = 0;
  final pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  final pages = [
    const KeepAlivePage(child: HomeTabView()),
    const KeepAlivePage(child: TrendingTabView()),
    const KeepAlivePage(child: NotificationTabView()),
    const KeepAlivePage(child: ProfileTabView()),
  ];

  List<BottomNavigationBarItem>? bottomNavItems = [
    const BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.home),
      label: StringValues.home,
    ),
    const BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.number),
      label: StringValues.search,
    ),
    BottomNavigationBarItem(
      icon: GetBuilder<NotificationController>(
        builder: (logic) => Stack(
          children: [
            const Icon(CupertinoIcons.bell),
            if (logic.notificationList.map((e) => e.isRead).contains(false))
              Positioned(
                right: Dimens.two,
                top: Dimens.zero,
                child: Container(
                  width: Dimens.eight,
                  height: Dimens.eight,
                  decoration: const BoxDecoration(
                    color: ColorValues.errorColor,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
      ),
      label: StringValues.notifications,
    ),
    const BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.person),
      label: StringValues.profile,
    ),
  ];

  void changePage(int index) {
    currentPageIndex = index;
    update();
  }

  void bottomNavTapped(int index) {
    currentPageIndex = index;
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutCirc,
    );
    update();
  }
}
