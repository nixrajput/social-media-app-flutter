import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/global_widgets/circular_progress_indicator.dart';
import 'package:social_media_app/global_widgets/custom_refresh_indicator.dart';
import 'package:social_media_app/global_widgets/primary_text_btn.dart';
import 'package:social_media_app/modules/home/controllers/recommended_user_controller.dart';
import 'package:social_media_app/modules/home/views/widgets/user_widget.dart';
import 'package:social_media_app/routes/route_management.dart';

class PeopleTab extends StatelessWidget {
  const PeopleTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: NxRefreshIndicator(
        onRefresh: RecommendedUsersController.find.getUsers,
        showProgress: false,
        child: GetBuilder<RecommendedUsersController>(
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
                    onChanged: (value) => logic.searchUsers(value),
                  ),
                  Dimens.boxHeight16,
                  _buildUsers(logic),
                  Dimens.boxHeight16,
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildUsers(RecommendedUsersController logic) {
    if (logic.isLoading &&
        (logic.recommendedUsersData == null ||
            logic.recommendedUsersList.isEmpty)) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const NxCircularProgressIndicator(),
          Dimens.boxHeight16,
        ],
      );
    }
    if (logic.recommendedUsersData == null ||
        logic.recommendedUsersList.isEmpty) {
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
            (logic.recommendedUsersData != null ||
                logic.recommendedUsersList.isNotEmpty))
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const NxCircularProgressIndicator(),
              Dimens.boxHeight16,
            ],
          ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: logic.recommendedUsersList.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (ctx, index) {
            var item = logic.recommendedUsersList.elementAt(index);
            return UserWidget(
              user: item,
              totalLength: logic.recommendedUsersList.length,
              index: index,
              onTap: () => RouteManagement.goToUserProfileView(item.id),
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
        if (logic.isMoreLoading || logic.recommendedUsersData!.hasNextPage!)
          Dimens.boxHeight8,
        if (logic.isMoreLoading)
          const Center(child: NxCircularProgressIndicator()),
        if (!logic.isMoreLoading && logic.recommendedUsersData!.hasNextPage!)
          Center(
            child: NxTextButton(
              label: 'Load more people',
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
