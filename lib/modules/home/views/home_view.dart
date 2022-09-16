import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/modules/home/controllers/home_controller.dart';
import 'package:social_media_app/modules/home/views/widgets/bottom_nav_bar.dart';
import 'package:social_media_app/utils/utility.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var lastExitTime = DateTime.now();
    return WillPopScope(
      onWillPop: () async {
        if (DateTime.now().difference(lastExitTime) >=
            const Duration(seconds: 2)) {
          AppUtility.showSnackBar(
            'Press the back button again to exit the app',
            '',
            duration: 2,
          );
          lastExitTime = DateTime.now();

          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        body: _buildPageView(),
        bottomNavigationBar: const BottomNavBar(),
      ),
    );
  }

  _buildPageView() => GetBuilder<HomeController>(
        builder: (controller) => PageView(
          key: const PageStorageKey('posts'),
          physics: const NeverScrollableScrollPhysics(),
          controller: controller.pageController,
          onPageChanged: (index) => controller.changePage(index),
          children: controller.pages,
        ),
      );
}
