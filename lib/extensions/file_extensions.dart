import 'dart:io';

extension FileUtils on File {
  int sizeToKb() {
    var sizeInBytes = lengthSync();
    var sizeInKb = sizeInBytes ~/ 1024;
    return sizeInKb;
  }

  int sizeToMb() {
    var sizeInBytes = lengthSync();
    var sizeInKb = sizeInBytes ~/ 1048576;
    return sizeInKb;
  }

  String getSize() {
    var sizeInBytes = lengthSync();
    var sizeInKb = sizeInBytes ~/ 1024;
    var sizeInMb = sizeInBytes ~/ 1048576;
    if (sizeInMb > 0) {
      return '$sizeInMb MB';
    } else if (sizeInKb > 0) {
      return '$sizeInKb KB';
    } else {
      return '$sizeInBytes Bytes';
    }
  }
}
