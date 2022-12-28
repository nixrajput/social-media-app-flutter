import 'dart:io';

import 'package:copy_with_extension/copy_with_extension.dart';

part 'media_file_message.g.dart';

@CopyWith()
class MediaFileMessage {
  String? message;
  File file;

  MediaFileMessage({
    this.message,
    required this.file,
  });
}
