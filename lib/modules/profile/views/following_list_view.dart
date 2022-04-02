import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/common/asset_image.dart';
import 'package:social_media_app/common/custom_app_bar.dart';
import 'package:social_media_app/common/primary_outlined_btn.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/modules/profile/controllers/following_list_controller.dart';
import 'package:social_media_app/modules/profile/widgets/follower_widget.dart';

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
              const NxAppBar(
                title: StringValues.following,
              ),
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
            return const Center(child: CupertinoActivityIndicator());
          }
          if (logic.followingList!.results == null ||
              logic.followingList!.results!.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                NxAssetImage(
                  imgAsset: AssetValues.error,
                  width: Dimens.hundred * 2,
                  height: Dimens.hundred * 2,
                ),
                Dimens.boxHeight8,
                Text(
                  StringValues.noData,
                  style: AppStyles.style20Normal.copyWith(
                    color: Theme.of(Get.context!).textTheme.subtitle1!.color,
                  ),
                  textAlign: TextAlign.center,
                ),
                Dimens.boxHeight16,
                NxOutlinedButton(
                  width: Dimens.hundred * 1.4,
                  padding: Dimens.edgeInsets8,
                  label: StringValues.refresh,
                  onTap: () => logic.getFollowersList(),
                )
              ],
            );
          }
          return Padding(
            padding: Dimens.edgeInsets8,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: logic.followingList!.results!.length,
              itemBuilder: (cxt, i) {
                var user = logic.followingList!.results!.elementAt(i);
                return FollowerWidget(
                  user: user,
                  bottomMargin: i == (logic.followingList!.results!.length - 1)
                      ? Dimens.zero
                      : Dimens.eight,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
