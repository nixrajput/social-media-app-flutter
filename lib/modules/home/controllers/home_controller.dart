import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/global_widgets/keep_alive_page.dart';
import 'package:social_media_app/modules/home/views/tab_views/chats_tab.dart';
import 'package:social_media_app/modules/home/views/tab_views/home_tab.dart';
import 'package:social_media_app/modules/home/views/tab_views/notification_tab.dart';
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
      const KeepAlivePage(child: ChatsTabView()),
      const KeepAlivePage(child: NotificationTabView()),
    ];
  }

  List<TabItem<dynamic>> buildBottomNavItems() {
    return [
      const TabItem(
        icon: Icons.home_outlined,
        activeIcon: Icons.home,
      ),
      const TabItem(
        icon: Icons.numbers_outlined,
        activeIcon: Icons.numbers,
      ),
      const TabItem(
        icon: Icons.messenger_outline_rounded,
        activeIcon: Icons.messenger_rounded,
      ),
      const TabItem(
        icon: Icons.notifications_outlined,
        activeIcon: Icons.notifications,
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
