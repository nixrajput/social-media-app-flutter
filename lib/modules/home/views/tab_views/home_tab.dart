import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constants/assets.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/global_widgets/asset_image.dart';
import 'package:social_media_app/global_widgets/elevated_card.dart';
import 'package:social_media_app/global_widgets/primary_outlined_btn.dart';
import 'package:social_media_app/global_widgets/shimmer_loading.dart';
import 'package:social_media_app/global_widgets/sliver_app_bar.dart';
import 'package:social_media_app/modules/home/controllers/post_controller.dart';
import 'package:social_media_app/modules/home/views/widgets/post_widget.dart';
import 'package:social_media_app/modules/post/controllers/create_post_controller.dart';

class HomeTabView extends StatelessWidget {
  const HomeTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: Dimens.screenWidth,
        height: Dimens.screenHeight,
        child: RefreshIndicator(
          onRefresh: () => PostController.find.fetchAllPosts(),
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              NxSliverAppBar(
                bgColor: Theme.of(context).scaffoldBackgroundColor,
                leading: Row(
                  children: [
                    NxAssetImage(
                      imgAsset: AssetValues.appName,
                      width: Dimens.seventy,
                      height: Dimens.sixty,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
                actions: GetBuilder<CreatePostController>(
                    builder: (con) => InkWell(
                          onTap: con.selectPostImages,
                          child: Icon(
                            CupertinoIcons.add_circled,
                            size: Dimens.twentyEight,
                            color: ColorValues.primaryColor,
                          ),
                        )),
              ),
              _buildBody(),
            ],
          ),
        ),
      ),
    );
  }

  _buildPostLoadingWidget() {
    return NxElevatedCard(
      bgColor: ColorValues.grayColor.withOpacity(0.1),
      padding: Dimens.edgeInsets8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: Dimens.twenty,
                backgroundColor: ColorValues.grayColor.withOpacity(0.25),
              ),
              Dimens.boxWidth8,
              Column(
                children: [
                  ShimmerLoading(
                    width: Dimens.hundred,
                    height: Dimens.fourteen,
                  ),
                  Dimens.boxHeight4,
                  ShimmerLoading(
                    width: Dimens.hundred,
                    height: Dimens.ten,
                  ),
                ],
              ),
            ],
          ),
          Dimens.boxHeight8,
          ShimmerLoading(
            height: Dimens.screenWidth * 0.8,
          ),
          Dimens.boxHeight8,
          Row(
            children: [
              ShimmerLoading(
                width: Dimens.eighty,
                height: Dimens.twenty,
              ),
              Dimens.boxWidth8,
              ShimmerLoading(
                width: Dimens.eighty,
                height: Dimens.twenty,
              ),
            ],
          ),
          Dimens.boxHeight8,
          ShimmerLoading(
            width: Dimens.screenWidth * 0.75,
            height: Dimens.sixTeen,
          ),
          Dimens.boxHeight8,
          ShimmerLoading(
            width: Dimens.screenWidth * 0.75,
            height: Dimens.sixTeen,
          ),
        ],
      ),
    );
  }

  _buildBody() {
    return GetBuilder<PostController>(
      builder: (logic) {
        if (logic.isLoading) {
          return SliverFillRemaining(
            child: ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildPostLoadingWidget(),
                _buildPostLoadingWidget(),
              ],
            ),
          );
        }
        if (logic.postData == null || logic.postData!.results!.isEmpty) {
          return SliverFillRemaining(
            child: Column(
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
                  StringValues.noPosts,
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
                  onTap: () => logic.fetchAllPosts(),
                )
              ],
            ),
          );
        }

        return SliverToBoxAdapter(
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: logic.postData!.results!.length,
            itemBuilder: (__, i) {
              var post = logic.postData!.results![i];
              return PostWidget(post: post);
            },
          ),
        );
      },
    );
  }
}
