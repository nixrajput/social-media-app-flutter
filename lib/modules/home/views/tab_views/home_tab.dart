import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/global_widgets/elevated_card.dart';
import 'package:social_media_app/global_widgets/primary_icon_btn.dart';
import 'package:social_media_app/global_widgets/primary_outlined_btn.dart';
import 'package:social_media_app/global_widgets/primary_text_btn.dart';
import 'package:social_media_app/global_widgets/shimmer_loading.dart';
import 'package:social_media_app/global_widgets/sliver_app_bar.dart';
import 'package:social_media_app/helpers/utils.dart';
import 'package:social_media_app/modules/home/controllers/banner_controller.dart';
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
          onRefresh: () => PostController.find.fetchPosts(),
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              NxSliverAppBar(
                bgColor: Theme.of(context).scaffoldBackgroundColor,
                height: Dimens.fourtyEight,
                leading: AppUtils.buildAppLogo(),
                actions: GetBuilder<CreatePostController>(
                  builder: (con) => InkWell(
                    onTap: con.selectPostImages,
                    child: Icon(
                      CupertinoIcons.add_circled,
                      size: Dimens.twentyEight,
                      color: Theme.of(context).textTheme.bodyText1!.color,
                    ),
                  ),
                ),
              ),
              _buildBody(),
            ],
          ),
        ),
      ),
    );
  }

  _buildBody() {
    var currentItem = 0;
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
        if (logic.postData == null || logic.postList.isEmpty) {
          return SliverFillRemaining(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  StringValues.noPosts,
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
                  onTap: () => logic.fetchPosts(),
                )
              ],
            ),
          );
        }

        return SliverToBoxAdapter(
          child: ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              GetBuilder<BannerController>(
                builder: (logic) {
                  if (logic.bannerList.isNotEmpty) {
                    return StatefulBuilder(
                      builder: (context, setInnerState) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            FlutterCarousel(
                              items: logic.bannerList
                                  .map((media) => Container(
                                        width: Dimens.screenWidth,
                                        padding: Dimens.edgeInsets8,
                                        decoration: const BoxDecoration(
                                          color: ColorValues.primaryColor,
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: RichText(
                                                text: TextSpan(
                                                  text: media,
                                                  style: AppStyles.style13Normal
                                                      .copyWith(
                                                    color:
                                                        ColorValues.whiteColor,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Dimens.boxWidth2,
                                            NxIconButton(
                                              icon: Icons.clear_outlined,
                                              onTap: () => logic
                                                  .deleteBanner(currentItem),
                                              iconColor: ColorValues.whiteColor,
                                            ),
                                          ],
                                        ),
                                      ))
                                  .toList(),
                              options: CarouselOptions(
                                  height: Dimens.eighty,
                                  viewportFraction: 1.0,
                                  showIndicator: false,
                                  onPageChanged: (int index, reason) {
                                    setInnerState(() {
                                      currentItem = index;
                                    });
                                  }),
                            ),
                            if (logic.bannerList.length > 1) Dimens.boxHeight4,
                            if (logic.bannerList.length > 1)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: logic.bannerList.asMap().entries.map(
                                  (entry) {
                                    return Container(
                                      width: Dimens.eight,
                                      height: Dimens.eight,
                                      margin: EdgeInsets.symmetric(
                                        horizontal: Dimens.two,
                                      ),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: (Theme.of(context).brightness ==
                                                    Brightness.dark
                                                ? ColorValues.whiteColor
                                                : ColorValues.blackColor)
                                            .withOpacity(
                                                currentItem == entry.key
                                                    ? 0.9
                                                    : 0.4),
                                      ),
                                    );
                                  },
                                ).toList(),
                              ),
                          ],
                        );
                      },
                    );
                  }
                  return const SizedBox();
                },
              ),
              ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: logic.postList
                    .map((post) => PostWidget(post: post))
                    .toList(),
              ),
              if (logic.isMoreLoading) Dimens.boxHeight8,
              if (logic.isMoreLoading)
                const Center(child: CircularProgressIndicator()),
              if (!logic.isMoreLoading && logic.postData!.hasNextPage!)
                Center(
                  child: NxTextButton(
                    label: 'Load more posts',
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
        );
      },
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
}
