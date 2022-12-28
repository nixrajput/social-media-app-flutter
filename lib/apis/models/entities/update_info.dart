import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'update_info.g.dart';

@CopyWith()
@JsonSerializable()
class UpdateInfo {
  UpdateInfo({
    this.currentVersion,
    this.latestVersion,
    this.changelog,
    this.fileName,
    this.downloadUrl,
    this.publishedAt,
  });

  factory UpdateInfo.fromJson(Map<String, dynamic> json) =>
      _$UpdateInfoFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateInfoToJson(this);

  @JsonKey(name: 'currentVersion')
  final String? currentVersion;

  @JsonKey(name: 'latestVersion')
  final String? latestVersion;

  @JsonKey(name: 'changelog')
  final String? changelog;

  @JsonKey(name: 'fileName')
  final String? fileName;

  @JsonKey(name: 'downloadUrl')
  final String? downloadUrl;

  @JsonKey(name: 'publishedAt')
  final DateTime? publishedAt;
}
