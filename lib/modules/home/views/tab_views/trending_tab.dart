import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/modules/home/controllers/tab_controller.dart';

class TrendingTabView extends StatelessWidget {
  const TrendingTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: SafeArea(
        child: SizedBox(
          width: Dimens.screenWidth,
          height: Dimens.screenHeight,
          child: GetBuilder<TrendingTabController>(
            builder: (tab) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TabBar(
                    controller: tab.controller,
                    tabs: tab.tabs,
                    indicatorWeight: Dimens.four,
                    indicatorSize: TabBarIndicatorSize.tab,
                    unselectedLabelColor:
                        Theme.of(context).textTheme.subtitle1!.color,
                    labelColor: ColorValues.primaryColor,
                    labelStyle: AppStyles.style16Bold.copyWith(
                      color: ColorValues.primaryColor,
                    ),
                    unselectedLabelStyle: AppStyles.style16Bold.copyWith(
                      color: ColorValues.grayColor,
                    ),
                    labelPadding: Dimens.edgeInsets0,
                    padding: Dimens.edgeInsets0_16,
                    indicatorPadding: Dimens.edgeInsets0,
                    indicatorColor: ColorValues.primaryColor,
                  ),
                  Dimens.boxHeight8,
                  Expanded(
                    child: Padding(
                      padding: Dimens.edgeInsets0_16,
                      child: TabBarView(
                        controller: tab.controller,
                        children: tab.tabViews,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
