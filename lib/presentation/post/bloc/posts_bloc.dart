import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_verto/presentation/post/domain/post_model.dart';
import 'package:test_verto/presentation/post/domain/posts_repo.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final PostsRepo _postsRepo = PostsRepo();
  int page = 0;
  int limit = 10;
  bool hasMore = true;
  List<Post> data = [];
  PostsBloc() : super(PostsInitial()) {
    on<PostsLoadDataEvent>(_fetchPosts);
  }

  Future<void> _fetchPosts(
      PostsLoadDataEvent event, Emitter<PostsState> emit) async {
    try {
      if (hasMore == false || state is PostsLoadingMore) {
        return;
      }
      if (page > 0) {
        emit(PostsLoadingMore(posts: data));
      } else {
        emit(PostsLoading());
      }
      List<Post> posts = await _postsRepo.fetchPost(page, limit);
      data.addAll(posts);
      page++;
      emit(PostsSuccess(posts: data));
    } catch (e) {
      if (e.toString() == "Exception: No more data") {
        hasMore = false;
        emit(PostsSuccess(posts: data));
      } else {
        emit(PostsError(error: e.toString()));
      }
    }
  }
}
