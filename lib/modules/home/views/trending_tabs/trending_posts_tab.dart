import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/app_widgets/circular_progress_indicator.dart';
import 'package:social_media_app/app_widgets/custom_refresh_indicator.dart';
import 'package:social_media_app/app_widgets/load_more_widget.dart';
import 'package:social_media_app/app_widgets/unfocus_widget.dart';
import 'package:social_media_app/modules/home/controllers/trending_post_controller.dart';
import 'package:social_media_app/modules/home/views/widgets/post_widget.dart';

class TrendingPostsTab extends StatelessWidget {
  const TrendingPostsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return UnFocusWidget(
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
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Dimens.boxHeight8,
                  _buildSearchField(logic, context),
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

  TextFormField _buildSearchField(
      TrendingPostController logic, BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Dimens.four),
          gapPadding: Dimens.zero,
          borderSide: BorderSide(
            color: Theme.of(context).dividerColor,
            width: Dimens.pointEight,
          ),
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
        color: Theme.of(Get.context!).textTheme.bodyLarge!.color,
      ),
      controller: logic.searchTextController,
      onChanged: (value) => logic.searchPosts(value),
    );
  }

  Widget _buildPosts(TrendingPostController logic) {
    if (logic.isLoading && (logic.postData == null || logic.postList.isEmpty)) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Center(child: NxCircularProgressIndicator()),
          Dimens.boxHeight8,
        ],
      );
    }
    if (logic.postData == null || logic.postList.isEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            StringValues.noData,
            style: AppStyles.style32Bold.copyWith(
              color: Theme.of(Get.context!).textTheme.titleMedium!.color,
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
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: logic.postList.length,
          itemBuilder: (context, index) {
            var post = logic.postList[index];
            return PostWidget(
              post: post,
              controller: logic,
            );
          },
        ),
        LoadMoreWidget(
          loadingCondition: logic.isMoreLoading,
          hasMoreCondition:
              logic.postData!.results != null && logic.postData!.hasNextPage!,
          loadMore: logic.loadMore,
        ),
      ],
    );
  }
}
