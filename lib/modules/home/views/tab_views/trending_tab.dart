import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/common/elevated_card.dart';
import 'package:social_media_app/common/primary_outlined_btn.dart';
import 'package:social_media_app/common/sliver_app_bar.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/modules/home/views/widgets/user_widget.dart';
import 'package:social_media_app/modules/user/controllers/user_controller.dart';

class TrendingTabView extends StatefulWidget {
  const TrendingTabView({Key? key}) : super(key: key);

  @override
  State<TrendingTabView> createState() => _TrendingTabViewState();
}

class _TrendingTabViewState extends State<TrendingTabView> {
  final _userCon = Get.put(UserController());

  @override
  void initState() {
    _userCon.getUsers();
    super.initState();
  }

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
            SliverFillRemaining(
              child: _buildSearchBody(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBody() => SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GetBuilder<UserController>(
              builder: (logic) {
                if (logic.isLoading) {
                  return const Center(
                    child: CupertinoActivityIndicator(),
                  );
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
                          color:
                              Theme.of(Get.context!).textTheme.subtitle1!.color,
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
                return NxElevatedCard(
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
                );
              },
            )
          ],
        ),
      );
}
