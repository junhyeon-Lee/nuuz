
import 'package:freezed_annotation/freezed_annotation.dart';

part 'article.freezed.dart';
part 'article.g.dart';

@freezed
class Article with _$Article {
  factory Article({
    String? id,
    required String description,
    required String imageUrl,
  }) = _Article;
	
  factory Article.fromJson(Map<String, dynamic> json) =>
			_$ArticleFromJson(json);
}
