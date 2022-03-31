import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/modules/home/controllers/navbar_controller.dart';
import 'package:social_media_app/modules/home/views/tab_views/home_tab.dart';
import 'package:social_media_app/modules/home/views/tab_views/notification_tab.dart';
import 'package:social_media_app/modules/home/views/tab_views/profile_tab.dart';
import 'package:social_media_app/modules/home/views/tab_views/trending_tab.dart';
import 'package:social_media_app/modules/home/views/widgets/bottom_nav_bar.dart';
import 'package:social_media_app/modules/post/controllers/create_post_controller.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<NavBarController>(
        builder: (controller) => IndexedStack(
          index: controller.currentTab,
          children: const [
            HomeTabView(),
            TrendingTabView(),
            NotificationTabView(),
            ProfileTabView()
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
      floatingActionButton: GetBuilder<CreatePostController>(
        builder: (logic) => FloatingActionButton(
          elevation: 0.0,
          onPressed: logic.selectPostImages,
          backgroundColor: ColorValues.primaryColor,
          child: Icon(
            CupertinoIcons.add,
            color: ColorValues.whiteColor,
            size: Dimens.thirtyTwo,
          ),
          tooltip: StringValues.createNewPost,
        ),
      ),
    );
  }
}
