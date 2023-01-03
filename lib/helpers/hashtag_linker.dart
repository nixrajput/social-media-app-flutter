import 'package:flutter_linkify/flutter_linkify.dart';

class HashTagLinker extends Linkifier {
  const HashTagLinker();

  @override
  List<LinkifyElement> parse(elements, options) {
    var items = <LinkifyElement>[];

    for (var element in elements) {
      if (element is TextElement) {
        var text = element.text;
        var hashTag = RegExp(r"#\w+");
        var matches = hashTag.allMatches(text);

        if (matches.isNotEmpty) {
          var start = 0;
          for (var match in matches) {
            var end = match.start;
            var hashTag = match.group(0);

            if (start != end) {
              items.add(TextElement(text.substring(start, end)));
            }

            items.add(LinkableElement(hashTag!, hashTag));
            start = match.end;
          }

          if (start != text.length) {
            items.add(TextElement(text.substring(start)));
          }
        } else {
          items.add(element);
        }
      } else {
        items.add(element);
      }
    }
    return items;
  }
}
