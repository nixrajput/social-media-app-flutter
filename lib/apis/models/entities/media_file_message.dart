import 'dart:io';

class MediaFileMessage {
  String? message;
  File file;

  MediaFileMessage({
    this.message,
    required this.file,
  });
}
