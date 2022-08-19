import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/global_widgets/custom_app_bar.dart';
import 'package:social_media_app/global_widgets/primary_outlined_btn.dart';
import 'package:social_media_app/modules/home/views/widgets/user_widget.dart';
import 'package:social_media_app/modules/profile/controllers/following_list_controller.dart';

class FollowingListView extends StatelessWidget {
  const FollowingListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: Dimens.screenWidth,
          height: Dimens.screenHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              NxAppBar(
                title: StringValues.following,
                padding: Dimens.edgeInsets8_16,
              ),
              Dimens.boxHeight24,
              _buildBody(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Expanded(
      child: GetBuilder<FollowingListController>(
        builder: (logic) {
          if (logic.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (logic.followingList == null ||
              logic.followingList!.results!.isEmpty) {
            return Padding(
              padding: Dimens.edgeInsets0_16,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    StringValues.noFollowing,
                    style: AppStyles.style32Bold.copyWith(
                      color: Theme.of(Get.context!).textTheme.subtitle1!.color,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Dimens.boxHeight16,
                  NxOutlinedButton(
                    width: Dimens.hundred,
                    height: Dimens.thirtySix,
                    label: StringValues.refresh,
                    onTap: () => logic.getFollowingList(),
                  )
                ],
              ),
            );
          }
          return Padding(
            padding: Dimens.edgeInsets0_16,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: logic.followingList!.results!.length,
              itemBuilder: (cxt, i) {
                var user = logic.followingList!.results![i];
                return UserWidget(
                  user: user,
                  bottomMargin: i == (logic.followingList!.results!.length - 1)
                      ? Dimens.zero
                      : Dimens.sixTeen,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
