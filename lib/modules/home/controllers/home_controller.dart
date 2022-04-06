import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:social_media_app/common/keep_alive_page.dart';
import 'package:social_media_app/constants/strings.dart';
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
    const BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.bell),
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
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInCubic,
    );
    update();
  }
}
