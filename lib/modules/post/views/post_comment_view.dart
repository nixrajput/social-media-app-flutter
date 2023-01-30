import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/global_widgets/custom_app_bar.dart';
import 'package:social_media_app/global_widgets/custom_refresh_indicator.dart';
import 'package:social_media_app/global_widgets/load_more_widget.dart';
import 'package:social_media_app/global_widgets/primary_icon_btn.dart';
import 'package:social_media_app/global_widgets/unfocus_widget.dart';
import 'package:social_media_app/modules/post/controllers/comment_controller.dart';
import 'package:social_media_app/modules/post/controllers/create_comment_controller.dart';
import 'package:social_media_app/modules/post/views/widgets/comment_widget.dart';

class PostCommentView extends StatelessWidget {
  const PostCommentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return UnFocusWidget(
      child: Scaffold(
        body: SafeArea(
          child: NxRefreshIndicator(
            onRefresh: CommentController.find.fetchComments,
            showProgress: false,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    NxAppBar(
                      title: StringValues.comments,
                      padding: Dimens.edgeInsetsDefault,
                    ),
                    _buildBody(context),
                  ],
                ),
                _buildCommentTextField(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Positioned _buildCommentTextField(BuildContext context) {
    return Positioned(
      bottom: Dimens.zero,
      left: Dimens.zero,
      right: Dimens.zero,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Dimens.divider,
          GetBuilder<CreateCommentController>(
            builder: (con) => Container(
              color: Theme.of(Get.context!).dialogTheme.backgroundColor,
              width: Dimens.screenWidth,
              height: Dimens.fourtyEight,
              padding: Dimens.edgeInsetsHorizDefault,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: con.commentTextController,
                      onChanged: (value) => con.onChangedText(value),
                      decoration: const InputDecoration(
                        hintText: StringValues.addComment,
                        border: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        focusedErrorBorder: InputBorder.none,
                      ),
                      minLines: 1,
                      maxLines: 1,
                      style: AppStyles.style14Normal.copyWith(
                        color: Theme.of(context).textTheme.bodyLarge!.color,
                      ),
                    ),
                  ),
                  Dimens.boxWidth4,
                  if (con.comment.isNotEmpty)
                    NxIconButton(
                      icon: Icons.send,
                      iconColor: ColorValues.primaryColor,
                      iconSize: Dimens.twentyFour,
                      onTap: con.createNewComment,
                    )
                ],
              ),
            ),
          ),
          Dimens.divider,
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: Dimens.edgeInsetsHorizDefault,
        child: GetBuilder<CommentController>(
          builder: (logic) {
            if (logic.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (logic.commentsData == null || logic.commentList.isEmpty) {
              return Padding(
                padding: Dimens.edgeInsetsHorizDefault,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Dimens.boxHeight8,
                    Text(
                      StringValues.noComments,
                      style: AppStyles.style32Bold.copyWith(
                        color:
                            Theme.of(Get.context!).textTheme.titleMedium!.color,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Dimens.boxHeight16,
                  ],
                ),
              );
            }

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildComments(logic),
                  LoadMoreWidget(
                    loadingCondition: logic.isMoreLoading,
                    hasMoreCondition: logic.commentsData!.results != null &&
                        logic.commentsData!.hasNextPage!,
                    loadMore: logic.loadMore,
                  ),
                  Dimens.boxHeight64,
                ],
              ),
            );
          },
        ),
      ),
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
