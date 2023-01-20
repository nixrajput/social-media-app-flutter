import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/global_widgets/circular_progress_indicator.dart';
import 'package:social_media_app/global_widgets/custom_app_bar.dart';
import 'package:social_media_app/global_widgets/custom_refresh_indicator.dart';
import 'package:social_media_app/global_widgets/load_more_widget.dart';
import 'package:social_media_app/global_widgets/unfocus_widget.dart';
import 'package:social_media_app/modules/post/controllers/comment_controller.dart';
import 'package:social_media_app/modules/post/controllers/post_details_controller.dart';
import 'package:social_media_app/modules/post/views/widgets/comment_widget.dart';
import 'package:social_media_app/modules/post/views/widgets/post_details_widget.dart';

class PostDetailsView extends StatelessWidget {
  const PostDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return UnFocusWidget(
      child: Scaffold(
        body: SafeArea(
          child: NxRefreshIndicator(
            onRefresh: PostDetailsController.find.fetchPostDetails,
            showProgress: false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                NxAppBar(
                  title: StringValues.post,
                  padding: Dimens.edgeInsetsDefault,
                ),
                _buildBody(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Expanded(
      child: GetBuilder<PostDetailsController>(
        builder: (logic) {
          if (logic.isLoading) {
            return const Center(child: NxCircularProgressIndicator());
          }

          if (logic.postDetailsData == null ||
              logic.postDetailsData!.post == null) {
            return Center(
              child: Padding(
                padding: Dimens.edgeInsetsHorizDefault,
                child: Text(
                  StringValues.postDetailsNotFound,
                  style: AppStyles.style32Bold.copyWith(
                    color: Theme.of(context).textTheme.subtitle1!.color,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            padding: Dimens.edgeInsetsHorizDefault,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PostDetailsWidget(
                  post: logic.postDetailsData!.post!,
                  controller: logic,
                ),
                Dimens.boxHeight12,
                _buildPostComments(context, logic.postDetailsData!.post!.id!),
                Dimens.boxHeight16,
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildPostComments(BuildContext context, String postId) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          StringValues.comments,
          style: AppStyles.style18Bold.copyWith(
            color: Theme.of(context).textTheme.bodyText1!.color,
          ),
        ),
        GetBuilder<CommentController>(
          init: CommentController(postId: postId),
          builder: (logic) {
            if (logic.isLoading) {
              return const Center(child: NxCircularProgressIndicator());
            }

            if (logic.commentsData == null || logic.commentList.isEmpty) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Dimens.boxHeight8,
                  Text(
                    StringValues.noComments,
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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Dimens.boxHeight8,
                _buildComments(logic),
                LoadMoreWidget(
                  loadingCondition: logic.isMoreLoading,
                  hasMoreCondition: logic.commentsData!.results != null &&
                      logic.commentsData!.hasNextPage!,
                  loadMore: logic.loadMore,
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  ListView _buildComments(CommentController commentsLogic) {
    return ListView.builder(
      itemBuilder: (context, index) {
        var comment = commentsLogic.commentList[index];
        return CommentWidget(comment: comment);
      },
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: commentsLogic.commentList.length,
    );
  }
}
