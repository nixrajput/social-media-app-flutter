import 'package:flutter/material.dart';
import 'package:social_media_app/apis/models/entities/poll_option.dart';
import 'package:social_media_app/apis/models/entities/post.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/styles.dart';

class PollOptionWidget extends StatelessWidget {
  const PollOptionWidget({
    super.key,
    required this.option,
    required this.isExpired,
    required this.greatestPercentageId,
    required this.onTap,
    required this.post,
  });

  final Post post;
  final PollOption option;
  final bool isExpired;
  final String greatestPercentageId;
  final VoidCallback onTap;

  Color _buildPollOptionColor(Post post, bool isExpired, PollOption option,
      String greatestPercentageId, BuildContext context) {
    if (isExpired && option.id == greatestPercentageId) {
      return ColorValues.primaryColor.withOpacity(0.8);
    }

    return Theme.of(context).scaffoldBackgroundColor.withOpacity(0.75);
  }

  double _buildPollOptionWidth(
      Post post, bool isExpired, PollOption option, double percentage) {
    if (isExpired || post.isVoted == true) {
      return Dimens.screenWidth * (percentage / 100.0);
    }

    return Dimens.screenWidth;
  }

  @override
  Widget build(BuildContext context) {
    final percentage =
        post.totalVotes! > 0 ? (option.votes! / post.totalVotes!) * 100 : 0.0;
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: Dimens.edgeInsets8,
        child: Stack(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              width: _buildPollOptionWidth(post, isExpired, option, percentage),
              height: Dimens.fourtyEight,
              decoration: BoxDecoration(
                color: _buildPollOptionColor(
                    post, isExpired, option, greatestPercentageId, context),
                borderRadius: BorderRadius.circular(Dimens.four),
              ),
            ),
            Positioned.fill(
              child: Container(
                width: Dimens.screenWidth,
                padding: Dimens.edgeInsets8,
                decoration: BoxDecoration(
                  color: ColorValues.transparent,
                  borderRadius: BorderRadius.circular(Dimens.four),
                  border: Border.all(
                    color: _buildPollOptionColor(
                        post, isExpired, option, greatestPercentageId, context),
                    width: Dimens.one,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: post.isVoted!
                      ? MainAxisAlignment.spaceBetween
                      : MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      option.option!,
                      style: AppStyles.style14Normal.copyWith(
                        color: Theme.of(context).textTheme.bodyText1!.color,
                      ),
                    ),
                    if (isExpired || post.isVoted!) Dimens.boxWidth4,
                    Row(
                      children: [
                        if (isExpired || post.isVoted!)
                          Text(
                            '${percentage.toStringAsFixed(0)}%',
                            style: AppStyles.style14Normal.copyWith(
                              color:
                                  Theme.of(context).textTheme.bodyText1!.color,
                            ),
                          ),
                        if (post.isVoted! && option.id == post.votedOption)
                          Dimens.boxWidth8,
                        if (post.isVoted! && option.id == post.votedOption)
                          Icon(
                            Icons.check_circle_outline,
                            size: Dimens.twenty,
                            color: Theme.of(context).textTheme.bodyText1!.color,
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
