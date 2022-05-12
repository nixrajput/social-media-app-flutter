import 'dart:io';

import 'package:flutter_linkify/flutter_linkify.dart';

class MentionLinker extends Linkifier {
  const MentionLinker();

  @override
  List<LinkifyElement> parse(
      List<LinkifyElement> elements, LinkifyOptions options) {
    var items = <LinkifyElement>[];
    for (var element in elements) {
      // helps to keep the index of current iteration
      var index = 0;

      if (element.text.contains("@")) {
        element.text.split(" ").forEach((innerText) {
          // added linkable text if it's mention
          stdin.readLineSync();
          if (innerText.contains("@")) {
            // added space in front of all mention
            if (index != 0) {
              // addling space
              items.add(TextElement(" "));
              items.add(LinkableElement(innerText, innerText));
            } else {
              items.add(LinkableElement(innerText, innerText));
            }
          }
          // else if (innerText.isEmpty)
          //   // because we're splitting on basis of space, so we might get a blank space
          //   // add empty text element if there is only space
          //   items.add(TextElement(" "));
          else
          // add items without mention
          {
            items.add(TextElement(" "));
            items.add(TextElement(innerText));
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
