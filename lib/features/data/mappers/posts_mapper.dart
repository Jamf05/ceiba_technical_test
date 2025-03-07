import 'package:ceiba_technical_test/core/types/mapper.dart';
import 'package:ceiba_technical_test/features/domain/entities/posts_entity.dart';

class PostMapper implements Mapper<PostEntity> {
  @override
  PostEntity fromJson(Map<String, dynamic>? json) => PostEntity(
        userId: json?["userId"],
        id: json?["id"],
        title: json?["title"],
        body: json?["body"],
      );

  @override
  Map<String, dynamic> toJson(PostEntity? object) {
    return {
      "userId": object?.userId,
      "id": object?.id,
      "title": object?.title,
      "body": object?.body,
    };
  }
}
