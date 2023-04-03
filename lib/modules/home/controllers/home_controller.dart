import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/app_widgets/keep_alive_page.dart';
import 'package:social_media_app/modules/home/views/tab_views/chats_tab.dart';
import 'package:social_media_app/modules/home/views/tab_views/home_tab.dart';
import 'package:social_media_app/modules/home/views/tab_views/notification_tab.dart';
import 'package:social_media_app/modules/home/views/tab_views/trending_tab.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
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

  void changeNavIndex(int index) {
    if (_currentPageIndex == index) return;
    _currentPageIndex = index;
    update();
  }

  void changePage(int index) {
    if (_currentPageIndex == index) return;

    _currentPageIndex = index;
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.fastOutSlowIn,
    );
    update();
  }
}
