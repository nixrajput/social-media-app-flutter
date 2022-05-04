import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:social_media_app/common/custom_app_bar.dart';
import 'package:social_media_app/common/primary_icon_btn.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/modules/home/controllers/post_controller.dart';
import 'package:social_media_app/modules/post/controllers/comment_controller.dart';
import 'package:social_media_app/modules/post/controllers/create_comment_controller.dart';
import 'package:social_media_app/modules/post/views/widgets/comment_widget.dart';
import 'package:social_media_app/modules/post/views/widgets/post_details_widget.dart';

class PostDetailsView extends StatelessWidget {
  const PostDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              SizedBox(
                width: Dimens.screenWidth,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const NxAppBar(title: StringValues.post),
                    _buildBody(),
                  ],
                ),
              ),
              GetBuilder<CreateCommentController>(
                builder: (con) => Positioned(
                  bottom: Dimens.zero,
                  left: Dimens.zero,
                  right: Dimens.zero,
                  child: Container(
                    color: Theme.of(Get.context!).dialogTheme.backgroundColor,
                    width: Dimens.screenWidth.w,
                    height: 48.h,
                    child: Row(
                      children: [
                        Dimens.boxWidth4,
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 4.r),
                            child: TextFormField(
                              controller: con.commentTextController,
                              decoration: const InputDecoration(
                                hintText: StringValues.addComment,
                                border: InputBorder.none,
                              ),
                              minLines: 1,
                              maxLines: 1,
                            ),
                          ),
                        ),
                        Dimens.boxWidth4,
                        NxIconButton(
                          icon: Icons.send,
                          iconColor: ColorValues.whiteColor,
                          height: 48.h,
                          width: 48.w,
                          bgColor: ColorValues.primaryColor,
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
    );
  }

  _buildBody() {
    return Expanded(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SizedBox(
          height: Dimens.screenHeight - 32.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GetBuilder<PostController>(
                builder: (postLogic) => PostDetailsWidget(
                  post: Get.arguments[1],
                ),
              ),
              Dimens.dividerWithHeight,
              GetBuilder<CommentController>(
                builder: (commentsLogic) {
                  if (commentsLogic.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: Dimens.edgeInsets0_8,
                        child: Text(
                          "Comments (${commentsLogic.commentsData.count})",
                          style: AppStyles.style16Bold,
                        ),
                      ),
                      if (commentsLogic.commentsData.comments != null)
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: commentsLogic.commentsData.comments!
                              .map((e) => InkWell(
                                    child: CommentWidget(comment: e),
                                    onLongPress: () =>
                                        commentsLogic.deleteComment(e.id),
                                  ))
                              .toList(),
                        ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
