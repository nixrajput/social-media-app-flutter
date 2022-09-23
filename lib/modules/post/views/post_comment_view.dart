import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/global_widgets/custom_app_bar.dart';
import 'package:social_media_app/global_widgets/custom_refresh_indicator.dart';
import 'package:social_media_app/global_widgets/primary_icon_btn.dart';
import 'package:social_media_app/global_widgets/primary_text_btn.dart';
import 'package:social_media_app/modules/post/controllers/comment_controller.dart';
import 'package:social_media_app/modules/post/controllers/create_comment_controller.dart';
import 'package:social_media_app/modules/post/views/widgets/comment_widget.dart';

class PostCommentView extends StatelessWidget {
  const PostCommentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
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
                      padding: Dimens.edgeInsets8_16,
                    ),
                    Dimens.boxHeight8,
                    _buildBody(),
                  ],
                ),
                Positioned(
                  bottom: Dimens.zero,
                  left: Dimens.zero,
                  right: Dimens.zero,
                  child: GetBuilder<CreateCommentController>(
                    builder: (con) => Container(
                      color: Theme.of(Get.context!).dialogTheme.backgroundColor,
                      width: Dimens.screenWidth,
                      height: Dimens.fourtyEight,
                      padding: Dimens.edgeInsets0_8,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          NxIconButton(
                            icon: Icons.emoji_emotions_outlined,
                            iconSize: Dimens.twentyFour,
                            onTap: () {},
                          ),
                          Dimens.boxWidth8,
                          Expanded(
                            child: TextFormField(
                              controller: con.commentTextController,
                              onChanged: (value) => con.onChangedText(value),
                              decoration: const InputDecoration(
                                hintText: StringValues.addComment,
                                border: InputBorder.none,
                              ),
                              minLines: 1,
                              maxLines: 1,
                              style: AppStyles.style14Normal.copyWith(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color,
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildBody() {
    return Expanded(
      child: Padding(
        padding: Dimens.edgeInsets0_16,
        child: GetBuilder<CommentController>(
          builder: (commentsLogic) {
            if (commentsLogic.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (commentsLogic.commentsData == null ||
                commentsLogic.commentList.isEmpty) {
              return Padding(
                padding: Dimens.edgeInsets0_16,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Dimens.boxHeight8,
                    Text(
                      StringValues.noComments,
                      style: AppStyles.style32Bold.copyWith(
                        color:
                            Theme.of(Get.context!).textTheme.subtitle1!.color,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Dimens.boxHeight16,
                    Dimens.boxHeight64,
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
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: commentsLogic.commentList
                        .map((e) => InkWell(
                              child: CommentWidget(comment: e),
                              onLongPress: () =>
                                  commentsLogic.showDeleteCommentOptions(e.id),
                            ))
                        .toList(),
                  ),
                  if (commentsLogic.isMoreLoading) Dimens.boxHeight8,
                  if (commentsLogic.isMoreLoading)
                    const Center(child: CircularProgressIndicator()),
                  if (!commentsLogic.isMoreLoading &&
                      commentsLogic.commentsData!.hasNextPage!)
                    NxTextButton(
                      label: 'View more comments',
                      onTap: commentsLogic.loadMore,
                      labelStyle: AppStyles.style14Bold.copyWith(
                        color: ColorValues.primaryLightColor,
                      ),
                      padding: Dimens.edgeInsets8_0,
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
}
