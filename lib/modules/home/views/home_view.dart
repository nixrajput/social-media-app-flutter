import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/modules/home/controllers/home_controller.dart';
import 'package:social_media_app/modules/home/views/widgets/bottom_nav_bar.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var lastExitTime = DateTime.now();
    return GetBuilder<HomeController>(
      builder: (logic) {
        return WillPopScope(
          onWillPop: () async {
            logic.changePage(0);
            if (DateTime.now().difference(lastExitTime) >=
                const Duration(seconds: 2)) {
              lastExitTime = DateTime.now();

              return false;
            } else {
              return true;
            }
          },
          child: Scaffold(
            extendBody: true,
            resizeToAvoidBottomInset: false,
            body: SafeArea(
              child: SizedBox(
                width: Dimens.screenWidth,
                height: Dimens.screenHeight,
                child: _buildBody(logic),
              ),
            ),
            bottomNavigationBar: const NxBottomNavBar(),
          ),
        );
      },
    );
  }

  Widget _buildBody(HomeController logic) => _buildPageView(logic);

  Widget _buildPageView(HomeController logic) {
    return PageView(
      key: const PageStorageKey(StringValues.home),
      physics: const NeverScrollableScrollPhysics(),
      controller: logic.pageController,
      onPageChanged: (index) => logic.changeNavIndex(index),
      children: logic.buildPages(),
    );
  }
}
