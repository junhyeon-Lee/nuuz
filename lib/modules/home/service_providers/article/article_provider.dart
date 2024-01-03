import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nuuz/models/nuuz_talk/article.dart';
import 'package:nuuz/modules/home/service_providers/article/repository/article_repository.dart';


final articleProvider =
    AsyncNotifierProvider<ArticleNotifier, List<Article>>(
        () => ArticleNotifier());

class ArticleNotifier extends AsyncNotifier<List<Article>> {
  final articleRepository = ArticleRepository();
  @override
  FutureOr<List<Article>> build() {
    return _fetchArticles();
  }

  _fetchArticles() {
    return articleRepository.getArticles();
  }  
}
