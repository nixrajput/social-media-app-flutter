import 'dart:io';

extension FileUtils on File {
  double sizeToKb() {
    var sizeInBytes = lengthSync();
    var sizeInKb = sizeInBytes / 1024;
    return sizeInKb;
  }
}
