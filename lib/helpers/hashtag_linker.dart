import 'package:flutter_linkify/flutter_linkify.dart';

class HashTagLinker extends Linkifier {
  const HashTagLinker();

  @override
  List<LinkifyElement> parse(
      List<LinkifyElement> elements, LinkifyOptions options) {
    var items = <LinkifyElement>[];
    // var newElement="Hey there testing the hashtag issue, \n I hope this gets fixed soon. #bug #mobileapp #dukhiKarDitta #FixHoJaHun".split("").map((e) => TextElement(e));
    // get all items
    for (var element in elements) {
      // check if it's contains hashtags
      if (element.text.contains("#")) {
        // helps to keep the index of current iteration
        var index = 0;

        //  remove spaced from beginning and end
        element.text.trim().split(" ").forEach((innerText) {
          // added linkable text if it's hashtag
          if (innerText.contains("#")) {
            // added space in front of all hashtags
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
          else {
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
