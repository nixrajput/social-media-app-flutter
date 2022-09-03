import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/global_widgets/primary_outlined_btn.dart';
import 'package:social_media_app/global_widgets/primary_text_btn.dart';
import 'package:social_media_app/modules/home/controllers/recommended_user_controller.dart';
import 'package:social_media_app/modules/home/views/widgets/user_widget.dart';
import 'package:social_media_app/routes/route_management.dart';

class PeopleTab extends StatelessWidget {
  const PeopleTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RecommendedUsersController>(
      builder: (logic) {
        if (logic.isLoading) {
          return const Center(child: CircularProgressIndicator());
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
              NxOutlinedButton(
                width: Dimens.hundred,
                height: Dimens.thirtySix,
                label: StringValues.refresh,
                onTap: () => logic.getUsers(),
              )
            ],
          );
        }
        return Padding(
          padding: EdgeInsets.only(
            top: Dimens.eight,
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
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
                    );
                  },
                ),
                if (logic.isMoreLoading ||
                    logic.recommendedUsersData!.hasNextPage!)
                  Dimens.boxHeight8,
                if (logic.isMoreLoading)
                  const Center(child: CircularProgressIndicator()),
                if (!logic.isMoreLoading &&
                    logic.recommendedUsersData!.hasNextPage!)
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
                Dimens.boxHeight16,
              ],
            ),
          ),
        );
      },
    );
  }
}
