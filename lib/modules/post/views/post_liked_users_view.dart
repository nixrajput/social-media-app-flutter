import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/global_widgets/circular_progress_indicator.dart';
import 'package:social_media_app/global_widgets/custom_app_bar.dart';
import 'package:social_media_app/global_widgets/custom_refresh_indicator.dart';
import 'package:social_media_app/global_widgets/primary_text_btn.dart';
import 'package:social_media_app/modules/home/views/widgets/user_widget.dart';
import 'package:social_media_app/modules/post/controllers/post_liked_users_controller.dart';
import 'package:social_media_app/routes/route_management.dart';

class PostLikedUsersView extends StatelessWidget {
  const PostLikedUsersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: NxRefreshIndicator(
          onRefresh: PostLikedUsersController.find.fetchPostLikedUsers,
          showProgress: false,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              NxAppBar(
                title: StringValues.likes,
                padding: Dimens.edgeInsets8_16,
              ),
              Dimens.boxHeight16,
              _buildBody(),
            ],
          ),
        ),
      ),
    );
  }

  _buildBody() {
    return Expanded(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        child: Padding(
          padding: Dimens.edgeInsets0_16,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GetBuilder<PostLikedUsersController>(
                builder: (logic) {
                  if (logic.isLoading) {
                    return const Center(
                      child: NxCircularProgressIndicator(),
                    );
                  }
                  if (logic.postLikedUsersList.isEmpty) {
                    return const SizedBox();
                  }
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: logic.postLikedUsersList.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (ctx, index) {
                          var item =
                              logic.postLikedUsersList.elementAt(index).likedBy;
                          return UserWidget(
                            user: item!,
                            totalLength: logic.postLikedUsersList.length,
                            index: index,
                            onTap: () =>
                                RouteManagement.goToUserProfileView(item.id),
                            onActionTap: () {
                              if (item.followingStatus == "requested") {
                                logic.cancelFollowRequest(item);
                                return;
                              }
                              logic.followUnfollowUser(item);
                            },
                          );
                        },
                      ),
                      if (logic.isMoreLoading) Dimens.boxHeight8,
                      if (logic.isMoreLoading)
                        const Center(child: NxCircularProgressIndicator()),
                      if (!logic.isMoreLoading &&
                          logic.postLikedUsersData.hasNextPage!)
                        NxTextButton(
                          label: 'View more',
                          onTap: logic.loadMore,
                          labelStyle: AppStyles.style14Bold.copyWith(
                            color: ColorValues.primaryLightColor,
                          ),
                          padding: Dimens.edgeInsets8_0,
                        ),
                      Dimens.boxHeight16,
                    ],
                  );
                },
              ),
              Dimens.boxHeight64,
            ],
          ),
        ),
      ),
    );
  }
}
