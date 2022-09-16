import 'package:flutter_linkify/flutter_linkify.dart';

class HashTagLinker extends Linkifier {
  const HashTagLinker();

  @override
  List<LinkifyElement> parse(
      List<LinkifyElement> elements, LinkifyOptions options) {
    var items = <LinkifyElement>[];
    for (var element in elements) {
      if (element.text.contains("#")) {
        var index = 0;
        element.text.trim().split(" ").forEach((innerText) {
          if (innerText.contains("#")) {
            if (index != 0) {
              items.add(LinkableElement("$innerText ", innerText));
            } else {
              items.add(LinkableElement("$innerText ", innerText));
            }
          } else {
            items.add(TextElement("$innerText "));
          }
          index = index + 1;
        });
      } else {
        items.add(element);
      }
    }
    return items;
  }
}
