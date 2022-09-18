import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/global_widgets/circular_progress_indicator.dart';
import 'package:social_media_app/global_widgets/custom_refresh_indicator.dart';
import 'package:social_media_app/global_widgets/primary_text_btn.dart';
import 'package:social_media_app/modules/home/controllers/trending_post_controller.dart';
import 'package:social_media_app/modules/home/views/widgets/post_widget.dart';

class TrendingPostsTab extends StatelessWidget {
  const TrendingPostsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: NxRefreshIndicator(
        onRefresh: TrendingPostController.find.fetchPosts,
        showProgress: false,
        child: GetBuilder<TrendingPostController>(
          builder: (logic) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              child: Column(
                children: [
                  Dimens.boxHeight8,
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Dimens.eight),
                        gapPadding: Dimens.zero,
                      ),
                      contentPadding: Dimens.edgeInsets4_8,
                      constraints: BoxConstraints(
                        maxWidth: Dimens.screenWidth,
                      ),
                      hintStyle: AppStyles.style14Normal.copyWith(
                        color: ColorValues.grayColor,
                      ),
                      hintText: StringValues.search,
                      prefixIcon: const Icon(
                        Icons.search,
                        color: ColorValues.grayColor,
                      ),
                    ),
                    keyboardType: TextInputType.text,
                    maxLines: 1,
                    style: AppStyles.style14Normal.copyWith(
                      color: Theme.of(Get.context!).textTheme.bodyText1!.color,
                    ),
                    controller: logic.searchTextController,
                    onChanged: (value) => logic.searchPosts(value),
                  ),
                  Dimens.boxHeight8,
                  _buildPosts(logic),
                  Dimens.boxHeight16,
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildPosts(TrendingPostController logic) {
    if (logic.isLoading && (logic.postData == null || logic.postList.isEmpty)) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const NxCircularProgressIndicator(),
          Dimens.boxHeight8,
        ],
      );
    } else if (logic.postData == null || logic.postList.isEmpty) {
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
        ],
      );
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if (logic.isLoading &&
            (logic.postData != null || logic.postList.isNotEmpty))
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const NxCircularProgressIndicator(),
              Dimens.boxHeight8,
            ],
          ),
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
          const Center(child: NxCircularProgressIndicator()),
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
      ],
    );
  }
}
