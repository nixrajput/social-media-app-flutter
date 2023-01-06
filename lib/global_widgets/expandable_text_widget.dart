import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/helpers/hashtag_linker.dart';
import 'package:social_media_app/helpers/mention_linker.dart';
import 'package:social_media_app/routes/route_management.dart';
import 'package:social_media_app/utils/utility.dart';
import 'package:url_launcher/url_launcher.dart';

class NxExpandableText extends StatefulWidget {
  const NxExpandableText({
    super.key,
    required this.text,
    this.textStyle,
    this.linkStyle,
  });

  final String text;
  final TextStyle? textStyle;
  final TextStyle? linkStyle;

  @override
  NxExpandableTextState createState() => NxExpandableTextState();
}

class NxExpandableTextState extends State<NxExpandableText> {
  String? text;
  bool canExpand = false;
  bool isExpand = false;

  @override
  Widget build(BuildContext context) {
    canExpand = widget.text.length >= 100;
    text = canExpand
        ? isExpand
            ? widget.text
            : '${widget.text.substring(0, 100)}...'
        : widget.text;

    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      child: _buildExpandableText(text!),
    );
  }

  Widget _buildExpandableText(String text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Linkify(
          text: text,
          linkifiers: const [
            UrlLinkifier(),
            EmailLinkifier(),
            HashTagLinker(),
            MentionLinker(),
          ],
          style: widget.textStyle ??
              AppStyles.style13Normal.copyWith(
                color: Theme.of(context).textTheme.bodyText1!.color,
                decoration: TextDecoration.none,
              ),
          linkStyle: widget.linkStyle ??
              AppStyles.style13Normal.copyWith(
                color: ColorValues.linkColor,
                decoration: TextDecoration.none,
              ),
          onOpen: (link) async {
            FocusManager.instance.primaryFocus!.unfocus();
            if (await canLaunchUrl(Uri.parse(link.url))) {
              await AppUtility.openUrl(Uri.parse(link.url));
            } else if (link.url.contains("#")) {
              AppUtility.printLog(link.text);
            } else if (link.url.contains("@")) {
              RouteManagement.goToUserProfileViewByUsername(
                  link.url.replaceAll('@', ''));
            } else {
              AppUtility.printLog(link);
              throw Exception('Could not open $link');
            }
          },
        ),
        if (canExpand) Dimens.boxHeight4,
        if (canExpand)
          InkWell(
            onTap: () {
              setState(() {
                isExpand = !isExpand;
              });
            },
            child: Text(
              isExpand ? 'show less' : 'show more',
              style: AppStyles.style14Bold.copyWith(
                color: ColorValues.primaryColor,
              ),
              textAlign: TextAlign.start,
            ),
          ),
      ],
    );
  }
}
