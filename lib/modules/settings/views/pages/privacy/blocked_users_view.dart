import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/global_widgets/app_filled_btn.dart';
import 'package:social_media_app/global_widgets/avatar_widget.dart';
import 'package:social_media_app/global_widgets/circular_progress_indicator.dart';
import 'package:social_media_app/global_widgets/custom_app_bar.dart';
import 'package:social_media_app/global_widgets/custom_list_tile.dart';
import 'package:social_media_app/global_widgets/custom_refresh_indicator.dart';
import 'package:social_media_app/global_widgets/load_more_widget.dart';
import 'package:social_media_app/global_widgets/no_data_widget.dart';
import 'package:social_media_app/modules/home/controllers/profile_controller.dart';

class BlockedUsersView extends StatelessWidget {
  const BlockedUsersView({Key? key}) : super(key: key);

  Widget _buildBody(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: Dimens.edgeInsetsHorizDefault,
        child: GetBuilder<ProfileController>(
          builder: (logic) {
            if (logic.loadingBlockedUsers) {
              return const Center(child: NxCircularProgressIndicator());
            }

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              child: logic.blockedUsers.isEmpty
                  ? _buildBlockedUsersEmptyText(context)
                  : _buildBlockedUsersList(logic, context),
            );
          },
        ),
      ),
    );
  }

  Widget _buildBlockedUsersEmptyText(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Dimens.heightedBox(Dimens.screenHeight * 0.2),
        const NoDataWidget(
          message: StringValues.noBlockedUsers,
        ),
      ],
    );
  }

  Widget _buildBlockedUsersList(ProfileController logic, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Dimens.boxHeight8,
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: logic.blockedUsers.length,
          itemBuilder: (ctx, index) {
            var user = logic.blockedUsers[index];
            return NxListTile(
              padding: Dimens.edgeInsets12,
              bgColor: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(Dimens.four),
              leading: AvatarWidget(
                avatar: user.avatar,
                size: Dimens.twentyFour,
              ),
              title: Text(
                user.uname,
                style: AppStyles.style14Bold,
              ),
              subtitle: Text(
                user.email,
                style: AppStyles.style13Normal.copyWith(
                  color: Theme.of(context).textTheme.titleSmall!.color,
                ),
              ),
              trailing: NxFilledButton(
                label: StringValues.unblock,
                labelStyle: AppStyles.style12Bold,
                padding: Dimens.edgeInsets4_12,
                onTap: () => logic.unblockUser(user.id),
              ),
            );
          },
        ),
        LoadMoreWidget(
          loadingCondition: logic.loadingMoreBlockedUsers,
          hasMoreCondition: logic.blockedUsersResponse!.results != null &&
              logic.blockedUsersResponse!.hasNextPage!,
          loadMore: logic.loadMoreBlockedUsers,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: Dimens.screenWidth,
          height: Dimens.screenHeight,
          child: NxRefreshIndicator(
            onRefresh: () => ProfileController.find.fetchBlockedUsers(),
            showProgress: false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                NxAppBar(
                  title: StringValues.blockedUsers,
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
}
