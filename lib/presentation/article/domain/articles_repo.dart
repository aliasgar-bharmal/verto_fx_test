import 'package:test_verto/presentation/article/domain/article_model.dart';
import 'package:test_verto/presentation/article/domain/articles_demo_data.dart';

class ArticlesRepo {
  Future<List<Article>> fetchArticles(int page, int limit) async {
    int start = page * limit;
    int end = start + limit;
    int length = articleData.length;
    await Future.delayed(const Duration(seconds: 2));

    if (start >= length) {
      throw Exception('No more data');
    }

    List<Map<String, dynamic>> articles = articleData.sublist(
      start,
      end > length ? length : end,
    );

    return articleFromJson(articles);
  }
}
