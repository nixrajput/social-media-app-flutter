import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:social_media_app/apis/models/entities/chat_message.dart';

part 'chat_message_response.g.dart';

@JsonSerializable()
class ChatMessageResponse extends Equatable {
  const ChatMessageResponse({
    this.success,
    this.message,
    this.data,
  });

  factory ChatMessageResponse.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ChatMessageResponseToJson(this);

  @JsonKey(name: 'success')
  final bool? success;

  @JsonKey(name: 'message')
  final String? message;

  @JsonKey(name: 'data')
  final ChatMessage? data;

  @override
  List<Object?> get props => <Object?>[
        success,
        message,
        data,
      ];
}
