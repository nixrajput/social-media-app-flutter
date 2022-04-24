import 'package:flutter/cupertino.dart';
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
                    color: Theme.of(Get.context!).scaffoldBackgroundColor,
                    width: Dimens.screenWidth.w,
                    height: 40.h,
                    child: Row(
                      children: [
                        Dimens.boxWidth4,
                        Expanded(
                          child: TextFormField(
                            controller: con.commentTextController,
                            decoration: const InputDecoration(
                              hintText: StringValues.addComment,
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        Dimens.boxWidth4,
                        NxIconButton(
                          icon: CupertinoIcons.arrow_right,
                          iconColor: ColorValues.whiteColor,
                          height: 40.h,
                          width: 40.w,
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
          height: Dimens.screenHeight - 40.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GetBuilder<PostController>(
                builder: (postLogic) => PostDetailsWidget(
                  post: postLogic.postList.singleWhere(
                    (element) => element.id == Get.arguments,
                  ),
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
                              .map((e) => CommentWidget(comment: e))
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
