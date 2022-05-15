import 'package:json_annotation/json_annotation.dart';
import 'package:social_media_app/apis/models/entities/notification.dart';

part 'notification_response.g.dart';

@JsonSerializable()
class NotificationResponse {
  NotificationResponse({
    this.success,
    this.count,
    this.results,
  });

  factory NotificationResponse.fromJson(Map<String, dynamic> json) =>
      _$NotificationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationResponseToJson(this);

  @JsonKey(name: 'success')
  bool? success;

  @JsonKey(name: 'count')
  int? count;

  @JsonKey(name: 'results')
  List<ApiNotification>? results;
}
