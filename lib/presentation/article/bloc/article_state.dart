part of 'article_bloc.dart';

sealed class ArticleState extends Equatable {
  const ArticleState();

  @override
  List<Object> get props => [];
}

final class ArticleInitial extends ArticleState {}

final class ArticlesInitial extends ArticleState {}

final class ArticlesSuccess extends ArticleState {
  final List<Article> articles;
  const ArticlesSuccess({required this.articles});
}

final class ArticlesLoadingMore extends ArticleState {
  final List<Article> articles;
  const ArticlesLoadingMore({required this.articles});
}

final class ArticlesLoading extends ArticleState {}

final class ArticlesError extends ArticleState {
  final String error;
  const ArticlesError({required this.error});
}
