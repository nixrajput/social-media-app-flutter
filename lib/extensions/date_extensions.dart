import 'package:intl/intl.dart';

const String dateFormatter = 'dd MMM';
const String timeFormatter = 'hh:mm a';
const String longDateFormatter = 'dd MMM yyyy';

extension DateHelper on DateTime {
  String formatDate() {
    var diff = DateTime.now().difference(this);

    if (diff > const Duration(days: 365)) {
      return DateFormat(longDateFormatter).format(this);
    } else if (isSameDate(DateTime.now()) && diff <= const Duration(days: 1)) {
      return 'Today';
    } else {
      return DateFormat(dateFormatter).format(this);
    }
  }

  String formatTime() {
    return DateFormat(timeFormatter).format(this);
  }

  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  int getDifferenceInDaysWithNow() {
    final now = DateTime.now();
    return now.difference(this).inDays;
  }
}
