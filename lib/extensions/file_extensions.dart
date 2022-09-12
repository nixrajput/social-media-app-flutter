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
}
