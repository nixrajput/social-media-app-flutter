import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/global_widgets/circular_network_image.dart';
import 'package:social_media_app/global_widgets/keep_alive_page.dart';
import 'package:social_media_app/modules/home/controllers/notification_controller.dart';
import 'package:social_media_app/modules/home/controllers/profile_controller.dart';
import 'package:social_media_app/modules/home/views/tab_views/home_tab.dart';
import 'package:social_media_app/modules/home/views/tab_views/notification_tab.dart';
import 'package:social_media_app/modules/home/views/tab_views/profile_tab.dart';
import 'package:social_media_app/modules/home/views/tab_views/trending_tab.dart';

class HomeController extends GetxController {
  static HomeController get find => Get.find();

  final _currentPageIndex = 0.obs;

  int get currentPageIndex => _currentPageIndex.value;

  final pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  List<Widget> buildPages() {
    return [
      const KeepAlivePage(child: HomeTabView()),
      const KeepAlivePage(child: TrendingTabView()),
      const KeepAlivePage(child: NotificationTabView()),
      const KeepAlivePage(child: ProfileTabView()),
    ];
  }

  List<BottomNavigationBarItem> buildBottomNavItems() {
    return [
      const BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: StringValues.home,
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.numbers),
        label: StringValues.search,
      ),
      BottomNavigationBarItem(
        icon: GetBuilder<NotificationController>(
          builder: (logic) => Stack(
            children: [
              const Icon(Icons.notifications),
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
                  color: currentPageIndex == 3
                      ? ColorValues.primaryColor
                      : Colors.transparent,
                  width: currentPageIndex == 3 ? Dimens.two : Dimens.zero,
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
    _currentPageIndex.value = index;
    update();
  }

  void bottomNavTapped(int index) {
    _currentPageIndex.value = index;
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutCirc,
    );
    update();
  }
}
