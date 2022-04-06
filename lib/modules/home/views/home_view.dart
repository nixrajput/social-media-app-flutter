import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/modules/home/controllers/home_controller.dart';
import 'package:social_media_app/modules/home/views/widgets/bottom_nav_bar.dart';
import 'package:social_media_app/modules/post/controllers/create_post_controller.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildPageView(),
      bottomNavigationBar: const BottomNavBar(),
      floatingActionButton: _buildFloatingAction(),
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

  _buildFloatingAction() => GetBuilder<CreatePostController>(
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
      );
}
