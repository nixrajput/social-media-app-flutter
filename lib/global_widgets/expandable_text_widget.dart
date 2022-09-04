import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/helpers/utils.dart';

class NxExpandableText extends StatefulWidget {
  const NxExpandableText({
    super.key,
    required this.text,
  });

  final String text;

  @override
  NxExpandableTextState createState() => NxExpandableTextState();
}

class NxExpandableTextState extends State<NxExpandableText> {
  String? text;
  bool canExpand = false;
  bool isExpand = false;

  @override
  Widget build(BuildContext context) {
    canExpand = widget.text.length >= 200;
    text = canExpand
        ? (isExpand ? widget.text : widget.text.substring(0, 200))
        : (widget.text);

    return AnimatedSize(
      duration: const Duration(milliseconds: 400),
      child: canExpand
          ? buildTextWithLinks(text!.trim())
          : RichText(
              text: TextSpan(
                text: text,
                style: AppStyles.style14Normal.copyWith(
                  color: Theme.of(context).textTheme.bodyText1!.color,
                  height: 1.25,
                ),
              ),
            ),
    );
  }

  Text buildTextWithLinks(String textToLink, {String? text}) => Text.rich(
        TextSpan(
          children: [
            ...linkify(textToLink),
            TextSpan(
              text: isExpand ? ' ...show less' : ' ...show more',
              style: AppStyles.style14Bold.copyWith(
                color: ColorValues.primaryColor,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  setState(() {
                    isExpand = !isExpand;
                  });
                },
            ),
          ],
          style: AppStyles.style14Normal.copyWith(
            color: Theme.of(context).textTheme.bodyText1!.color,
            height: 1.25,
          ),
        ),
      );
}

const String urlPattern =
    r"(https?|http)://([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?";
const String emailPattern = r'\S+@\S+';
const String phonePattern = r'[\d-]{9,}';
final RegExp linkRegExp = RegExp(
    '($urlPattern)|($emailPattern)|($phonePattern)',
    caseSensitive: false);

WidgetSpan buildLinkComponent(String text, String linkToOpen) => WidgetSpan(
      child: InkWell(
        child: Text(
          text,
          style: AppStyles.style14Normal.copyWith(
            color: ColorValues.primaryColor,
            decoration: TextDecoration.underline,
          ),
        ),
        onTap: () => AppUtils.openUrl(Uri.parse(linkToOpen)),
      ),
    );

List<InlineSpan> linkify(String text) {
  final list = <InlineSpan>[];
  final match = linkRegExp.firstMatch(text);
  if (match == null) {
    list.add(
      TextSpan(
        text: text,
        style: AppStyles.style14Normal.copyWith(
          color: Theme.of(Get.context!).textTheme.bodyText1!.color,
        ),
      ),
    );
    return list;
  }

  if (match.start > 0) {
    list.add(
      TextSpan(
        text: text.substring(0, match.start),
        style: AppStyles.style14Normal.copyWith(
          color: Theme.of(Get.context!).textTheme.bodyText1!.color,
        ),
      ),
    );
  }

  final linkText = match.group(0);
  if (linkText!.contains(RegExp(urlPattern, caseSensitive: false))) {
    list.add(buildLinkComponent(linkText, linkText));
  } else if (linkText.contains(RegExp(emailPattern, caseSensitive: false))) {
    list.add(buildLinkComponent(linkText, 'mailto:$linkText'));
  } else if (linkText.contains(RegExp(phonePattern, caseSensitive: false))) {
    list.add(buildLinkComponent(linkText, 'tel:$linkText'));
  } else {
    throw Exception('Unexpected match: $linkText');
  }

  list.addAll(linkify(text.substring(match.start + linkText.length)));

  return list;
}
