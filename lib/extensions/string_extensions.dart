extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';

  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}

extension StringToLargeNumberExtension on String {
  String toCountingFormat() {
    var str = this;
    var number = int.parse(this);

    var oneThousand = 1000;
    var oneLac = 100 * oneThousand;
    var oneMillion = 10 * oneLac;
    var oneBillion = 1000 * oneMillion;
    var oneTrillion = 1000 * oneBillion;

    if (number > 999 && number < oneLac) {
      var res = number / oneThousand;
      str = '${res.toStringAsFixed(1)}K';
    }

    if (number >= oneLac && number < oneMillion) {
      var res = number / oneLac;
      str = '${res.toStringAsFixed(1)}L';
    }

    if (number >= oneMillion && number < oneBillion) {
      var res = number / oneMillion;
      str = '${res.toStringAsFixed(1)}M';
    }

    if (number >= oneBillion && number < oneTrillion) {
      var res = number / oneBillion;
      str = '${res.toStringAsFixed(1)}B';
    }

    if (number >= oneTrillion) {
      var res = number / oneTrillion;
      str = '${res.toStringAsFixed(1)}T';
    }

    return str;
  }
}
