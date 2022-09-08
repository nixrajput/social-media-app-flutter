abstract class Validators {
  static const String urlPattern =
      r"(https?|http)://([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?";
  static const String emailPattern = r'\S+@\S+';
  static const String phonePattern = r'[\d-]{9,}';

  static bool isValidUrl(String url) {
    if (RegExp(urlPattern, caseSensitive: false).hasMatch(url)) {
      return true;
    }
    return false;
  }
}
