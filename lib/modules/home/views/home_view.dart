import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/modules/home/controllers/home_controller.dart';
import 'package:social_media_app/modules/home/views/widgets/bottom_nav_bar.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildPageView(),
      bottomNavigationBar: const BottomNavBar(),
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
