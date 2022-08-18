import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/global_widgets/primary_outlined_btn.dart';
import 'package:social_media_app/modules/home/views/widgets/user_widget.dart';
import 'package:social_media_app/modules/users/controllers/user_controller.dart';
import 'package:social_media_app/routes/route_management.dart';

class PeopleTab extends StatelessWidget {
  const PeopleTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(
      builder: (logic) {
        if (logic.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (logic.userList!.results == null ||
            logic.userList!.results!.isEmpty) {
          return Column(
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
          );
        }
        return Padding(
          padding: Dimens.edgeInsets8,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: logic.userList!.results!
                    .map(
                      (user) => UserWidget(
                        onTap: () =>
                            RouteManagement.goToUserProfileView(user.id),
                        user: user,
                        bottomMargin: Dimens.eight,
                      ),
                    )
                    .toList()),
          ),
        );
      },
    );
  }
}
