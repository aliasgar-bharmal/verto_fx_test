part of 'posts_bloc.dart';

sealed class PostsState extends Equatable {
  const PostsState();

  @override
  List<Object> get props => [];
}

final class PostsInitial extends PostsState {}

final class PostsSuccess extends PostsState {
  final List<Post> posts;
  const PostsSuccess({required this.posts});
}

final class PostsLoadingMore extends PostsState {
  final List<Post> posts;
  const PostsLoadingMore({required this.posts});
}

final class PostsLoading extends PostsState {}

final class PostsError extends PostsState {
  final String error;
  const PostsError({required this.error});
}
