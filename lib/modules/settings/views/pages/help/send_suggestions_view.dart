import 'package:flutter/material.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/global_widgets/custom_app_bar.dart';

class SendSuggestionsView extends StatelessWidget {
  const SendSuggestionsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: Dimens.screenWidth,
          height: Dimens.screenHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NxAppBar(
                title: StringValues.sendUsSuggestions,
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

  Widget _buildBody() {
    return Expanded(
      child: Padding(
        padding: Dimens.edgeInsets0_16,
        child: SingleChildScrollView(
          child: Column(),
        ),
      ),
    );
  }
}
