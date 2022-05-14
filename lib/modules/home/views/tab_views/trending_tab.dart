import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/modules/home/controllers/tab_controller.dart';

class TrendingTabView extends StatelessWidget {
  const TrendingTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: Dimens.screenWidth,
        height: Dimens.screenHeight,
        child: GetBuilder<TrendingTabController>(
          builder: (tab) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: Dimens.edgeInsets8,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: Dimens.fourty,
                        child: TextFormField(
                          decoration: InputDecoration(
                            contentPadding: Dimens.edgeInsets0_16,
                            hintText: StringValues.search,
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(Dimens.sixTeen),
                            ),
                          ),
                        ),
                      ),
                      TabBar(
                        controller: tab.controller,
                        tabs: tab.tabs,
                        unselectedLabelColor:
                            Theme.of(context).textTheme.subtitle1?.color,
                        labelColor:
                            Theme.of(context).textTheme.bodyText1?.color,
                        padding: Dimens.edgeInsets0,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: tab.controller,
                    children: tab.tabViews,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
