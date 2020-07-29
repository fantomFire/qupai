import 'package:json_annotation/json_annotation.dart';

part 'message_detail_bean_entity.g.dart';
@JsonSerializable()
class MessageEntity {
  var id;
  String user_nickname;
  var user_id;
  String user_img;
  String cs_image;
  String cs_nickname;
  String conetent;
  var create_time;
  var chat_type;
	var sender;
	MessageEntity();
	factory MessageEntity.fromJson(Map<String, dynamic> json) => _$MessageEntityFromJson(json);

	Map<String, dynamic> toJson() => _$MessageEntityToJson(this);

  
}
