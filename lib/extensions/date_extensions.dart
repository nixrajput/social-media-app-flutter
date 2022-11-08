import 'package:intl/intl.dart';

const String dateFormatter = 'dd MMM';
const String timeFormatter = 'hh:mm a';
const String longDateFormatter = 'dd MMM yyyy';

extension DateHelper on DateTime {
  String formatDate() {
    var diff = DateTime.now().toLocal().difference(toLocal());

    if (diff > const Duration(days: 365)) {
      return DateFormat(longDateFormatter).format(toLocal());
    } else if (isSameDate(DateTime.now()) && diff <= const Duration(days: 1)) {
      return 'Today';
    } else {
      return DateFormat(dateFormatter).format(toLocal());
    }
  }

  String getTime({bool is24Hour = false, bool showSeconds = false}) {
    var toLocal = this.toLocal();
    var hr = toLocal.hour;
    var min = toLocal.minute;
    var sec = toLocal.second;

    var hrStr = hr < 10 ? '0$hr' : '$hr';
    var minStr = min < 10 ? '0$min' : '$min';
    var secStr = sec < 10 ? '0$sec' : '$sec';

    var time = '$hrStr:$minStr';

    if (!is24Hour) {
      if (hr >= 13) {
        hr -= 12;
      }
      if (hr == 0) {
        hr = 12;
      }
      time = '$hr:$minStr';
      time += ' ${hr >= 12 ? 'PM' : 'AM'}';
    }

    if (showSeconds) {
      time += ':$secStr';
    }

    return time;
  }

  bool isSameDate(DateTime other) {
    return toLocal().year == other.toLocal().year &&
        toLocal().month == other.toLocal().month &&
        toLocal().day == other.toLocal().day;
  }

  int getDifferenceInDaysWithNow() {
    final now = DateTime.now().toLocal();
    return now.difference(toLocal()).inDays;
  }
}
