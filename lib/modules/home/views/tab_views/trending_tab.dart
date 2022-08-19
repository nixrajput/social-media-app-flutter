import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
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
              return Padding(
                padding: Dimens.edgeInsets8_16,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: Dimens.fiftySix,
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: StringValues.search,
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(Dimens.eight),
                                borderSide: BorderSide(
                                  width: Dimens.one * 0.5,
                                ),
                              ),
                              hintStyle: AppStyles.style14Normal.copyWith(
                                color: ColorValues.grayColor,
                              ),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            maxLines: 1,
                            style: AppStyles.style14Normal.copyWith(
                              color: Theme.of(Get.context!)
                                  .textTheme
                                  .bodyText1!
                                  .color,
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
                          indicatorColor: ColorValues.primaryColor,
                        ),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: tab.controller,
                        children: tab.tabViews,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
