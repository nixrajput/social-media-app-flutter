import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/modules/home/controllers/home_controller.dart';
import 'package:social_media_app/modules/home/views/widgets/bottom_nav_bar.dart';
import 'package:social_media_app/utils/utility.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var lastExitTime = DateTime.now();
    return GetBuilder<HomeController>(builder: (logic) {
      return WillPopScope(
        onWillPop: () async {
          logic.changePage(0);
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
          body: SizedBox(
            width: Dimens.screenWidth,
            height: Dimens.screenHeight,
            child: _buildBody(logic),
          ),
        ),
      );
    });
  }

  Widget _buildBody(HomeController logic) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPageView(logic),
          Dimens.divider,
          const NxBottomNavBar(),
          Dimens.divider,
        ],
      );

  Expanded _buildPageView(HomeController logic) {
    return Expanded(
      child: PageView(
        key: const PageStorageKey(StringValues.home),
        physics: const NeverScrollableScrollPhysics(),
        controller: logic.pageController,
        onPageChanged: (index) => logic.changeNavIndex(index),
        children: logic.buildPages(),
      ),
    );
  }
}
