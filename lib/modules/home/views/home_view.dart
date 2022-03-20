import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/modules/home/controllers/home_controller.dart';
import 'package:social_media_app/modules/home/views/tab_views/home_tab.dart';
import 'package:social_media_app/modules/home/views/tab_views/notification_tab.dart';
import 'package:social_media_app/modules/home/views/tab_views/profile_tab.dart';
import 'package:social_media_app/modules/home/views/tab_views/search_tab.dart';
import 'package:social_media_app/modules/home/widgets/bottom_nav_bar.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<HomeController>(
        builder: (controller) => IndexedStack(
          index: controller.currentTab,
          children: const [
            HomeTabView(),
            SearchTabView(),
            NotificationTabView(),
            ProfileTabView()
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
