import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/common/elevated_card.dart';
import 'package:social_media_app/common/primary_outlined_btn.dart';
import 'package:social_media_app/common/sliver_app_bar.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/modules/home/views/widgets/user_widget.dart';
import 'package:social_media_app/modules/users/controllers/user_controller.dart';
import 'package:social_media_app/routes/route_management.dart';

class TrendingTabView extends StatelessWidget {
  const TrendingTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: Dimens.screenWidth,
        height: Dimens.screenHeight,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            NxSliverAppBar(
              isFloating: false,
              isPinned: true,
              bgColor: Theme.of(context).scaffoldBackgroundColor,
              leading: Text(
                StringValues.trending,
                style: AppStyles.style18Bold,
              ),
            ),
            _buildSearchBody(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBody() => GetBuilder<UserController>(
        builder: (logic) {
          if (logic.isLoading) {
            return const SliverFillRemaining(
              child: Center(child: CircularProgressIndicator()),
            );
          }
          if (logic.userList!.results == null ||
              logic.userList!.results!.isEmpty) {
            return SliverFillRemaining(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    StringValues.noData,
                    style: AppStyles.style20Normal.copyWith(
                      color: Theme.of(Get.context!).textTheme.subtitle1!.color,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Dimens.boxHeight16,
                  NxOutlinedButton(
                    width: Dimens.hundred * 1.4,
                    padding: Dimens.edgeInsets8,
                    label: StringValues.refresh,
                    onTap: () => logic.getUsers(),
                  )
                ],
              ),
            );
          }
          return SliverFillRemaining(
            child: Column(
              children: [
                NxElevatedCard(
                  padding: Dimens.edgeInsets8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: logic.userList!.results!.length,
                        itemBuilder: (cxt, i) {
                          var user = logic.userList!.results!.elementAt(i);
                          return UserWidget(
                            onTap: () =>
                                RouteManagement.goToUserProfileView(user.id),
                            user: user,
                            bottomMargin:
                                i == (logic.userList!.results!.length - 1)
                                    ? Dimens.zero
                                    : Dimens.eight,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
}
