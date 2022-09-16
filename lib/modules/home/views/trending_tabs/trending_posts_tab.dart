import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/global_widgets/circular_progress_indicator.dart';
import 'package:social_media_app/global_widgets/custom_refresh_indicator.dart';
import 'package:social_media_app/global_widgets/primary_outlined_btn.dart';
import 'package:social_media_app/global_widgets/primary_text_btn.dart';
import 'package:social_media_app/modules/home/controllers/trending_post_controller.dart';
import 'package:social_media_app/modules/home/views/widgets/post_widget.dart';

class TrendingPostsTab extends StatelessWidget {
  const TrendingPostsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NxRefreshIndicator(
      onRefresh: TrendingPostController.find.fetchPosts,
      showProgress: false,
      child: GetBuilder<TrendingPostController>(
        builder: (logic) {
          if (logic.isLoading) {
            return const Center(child: NxCircularProgressIndicator());
          }
          if (logic.postData == null || logic.postList.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  StringValues.noData,
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
            );
          }
          return Padding(
            padding: EdgeInsets.only(
              top: Dimens.eight,
            ),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: logic.postList
                        .map((post) => PostWidget(
                              post: post,
                              controller: logic,
                            ))
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
            ),
          );
        },
      ),
    );
  }
}
