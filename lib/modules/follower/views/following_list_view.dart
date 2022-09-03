import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/global_widgets/custom_app_bar.dart';
import 'package:social_media_app/global_widgets/primary_outlined_btn.dart';
import 'package:social_media_app/global_widgets/primary_text_btn.dart';
import 'package:social_media_app/modules/follower/controllers/following_list_controller.dart';
import 'package:social_media_app/modules/home/views/widgets/user_widget.dart';

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
          if (logic.followingData == null || logic.followingList.isEmpty) {
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
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: Dimens.edgeInsets0_16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: logic.followingList.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (ctx, index) {
                      var item = logic.followingList.elementAt(index).user;
                      return UserWidget(
                        user: item,
                        totalLength: logic.followingList.length,
                        index: index,
                      );
                    },
                  ),
                  if (logic.isMoreLoading || logic.followingData!.hasNextPage!)
                    Dimens.boxHeight8,
                  if (logic.isMoreLoading)
                    const Center(child: CircularProgressIndicator()),
                  if (!logic.isMoreLoading && logic.followingData!.hasNextPage!)
                    Center(
                      child: NxTextButton(
                        label: 'Load more followings',
                        onTap: logic.loadMore,
                        labelStyle: AppStyles.style14Bold.copyWith(
                          color: ColorValues.primaryLightColor,
                        ),
                        padding: Dimens.edgeInsets8_0,
                      ),
                    ),
                  Dimens.boxHeight16,
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
