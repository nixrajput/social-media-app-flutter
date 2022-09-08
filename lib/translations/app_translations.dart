import 'package:get/get.dart';
import 'package:social_media_app/translations/en_US/en_us_translations.dart';
import 'package:social_media_app/translations/hi_IN/hi_in_translations.dart';

class AppTranslation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': enUs,
        'hi': hiIn,
      };
}
