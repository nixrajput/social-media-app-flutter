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
import 'package:social_media_app/modules/settings/controllers/login_info_controller.dart';
import 'package:social_media_app/modules/settings/views/widgets/login_info_widget.dart';

class LoginInfoHistoryView extends StatelessWidget {
  const LoginInfoHistoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: Dimens.screenWidth,
          height: Dimens.screenHeight,
          child: NxRefreshIndicator(
            onRefresh: LoginInfoController.find.getLoginHisory,
            showProgress: false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                NxAppBar(
                  title: StringValues.loginActivity,
                  padding: Dimens.edgeInsets8_16,
                ),
                Dimens.boxHeight8,
                _buildBody(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Expanded(
      child: Padding(
        padding: Dimens.edgeInsets0_16,
        child: GetBuilder<LoginInfoController>(
          builder: (logic) {
            if (logic.isLoading) {
              return const Center(child: NxCircularProgressIndicator());
            }

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: logic.loginInfoList.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (ctx, index) {
                      var item = logic.loginInfoList.elementAt(index);
                      return LoginInfoWidget(
                        item: item,
                        totalLength: logic.loginInfoList.length,
                        index: index,
                      );
                    },
                  ),
                  if (logic.isMoreLoading) Dimens.boxHeight8,
                  if (logic.isMoreLoading)
                    const Center(child: NxCircularProgressIndicator()),
                  if (!logic.isMoreLoading &&
                      logic.loginHistoryData!.results != null &&
                      logic.loginHistoryData!.hasNextPage!)
                    Center(
                      child: NxTextButton(
                        label: 'Load more',
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
            );
          },
        ),
      ),
    );
  }
}
