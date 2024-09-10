import 'package:test_verto/presentation/post/domain/post_model.dart';
import 'package:test_verto/presentation/post/domain/posts_demo_data.dart';

class PostsRepo {
  Future<List<Post>> fetchPost(int page, int limit) async {
    int start = page * limit;
    int end = start + limit;
    int length = postData.length;
    await Future.delayed(const Duration(seconds: 2));

    if (start >= length) {
      throw Exception('No more data');
    }

    List<Map<String, dynamic>> posts = postData.sublist(
      start,
      end > length ? length : end,
    );

    return postsFromJson(posts);
  }
}
