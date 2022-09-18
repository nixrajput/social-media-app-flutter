import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/global_widgets/circular_progress_indicator.dart';
import 'package:social_media_app/global_widgets/custom_app_bar.dart';
import 'package:social_media_app/global_widgets/custom_refresh_indicator.dart';
import 'package:social_media_app/modules/home/views/widgets/post_widget.dart';
import 'package:social_media_app/modules/post/controllers/post_details_controller.dart';

class PostDetailsView extends StatelessWidget {
  const PostDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: NxRefreshIndicator(
            onRefresh: PostDetailsController.find.fetchPostDetails,
            showProgress: false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                NxAppBar(
                  title: StringValues.post,
                  padding: Dimens.edgeInsets8_16,
                ),
                _buildBody(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildBody() {
    return Expanded(
      child: GetBuilder<PostDetailsController>(builder: (logic) {
        if (logic.isLoading) {
          return const Center(child: NxCircularProgressIndicator());
        }

        if (logic.postDetailsData == null ||
            logic.postDetailsData?.post == null) {
          return Center(
            child: Padding(
              padding: Dimens.edgeInsets0_16,
              child: Text(
                StringValues.postDetailsNotFound,
                style: AppStyles.style32Bold.copyWith(
                  color: Theme.of(Get.context!).textTheme.subtitle1!.color,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          );
        }

        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          padding: Dimens.edgeInsets0_16,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PostWidget(
                post: logic.postDetailsData!.post!,
                controller: logic,
              ),
              Dimens.boxHeight16,
            ],
          ),
        );
      }),
    );
  }
}
