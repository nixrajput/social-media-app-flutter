import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/modules/home/controllers/home_controller.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) => BottomNavigationBar(
        items: controller.tab!,
        currentIndex: controller.currentTab,
        onTap: (value) => controller.changeTab(value),
        elevation: 0.0,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.transparent,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: ColorValues.primaryColor,
      ),
    );
  }
}
