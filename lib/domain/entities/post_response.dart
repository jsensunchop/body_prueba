import 'package:json_annotation/json_annotation.dart';

part 'post_response.g.dart';

///PODO ApiResponse
///
//Post model

@JsonSerializable()
class PostResponse {

  final int userId;
  final int id;
  final String title;
  final String body;


  PostResponse(this.title, this.id, this.body, this.userId);

  factory PostResponse.fromJson(Map<String, dynamic> json) => _$PostResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PostResponseToJson(this);
}