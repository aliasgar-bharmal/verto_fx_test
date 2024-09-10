import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_verto/presentation/article/domain/article_model.dart';
import 'package:test_verto/presentation/article/domain/articles_repo.dart';

part 'article_event.dart';
part 'article_state.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  final ArticlesRepo _articleRepo = ArticlesRepo();
  int page = 0;
  int limit = 10;
  bool hasMore = true;
  List<Article> data = [];

  ArticleBloc() : super(ArticleInitial()) {
    on<ArticlesLoadDataEvent>(_fetchArticle);
  }
  Future<void> _fetchArticle(
      ArticlesLoadDataEvent event, Emitter<ArticleState> emit) async {
    try {
      if (hasMore == false || state is ArticlesLoadingMore) {
        return;
      }
      if (page > 0) {
        emit(ArticlesLoadingMore(articles: data));
      } else {
        emit(ArticlesLoading());
      }
      List<Article> articles = await _articleRepo.fetchArticles(page, limit);
      data.addAll(articles);
      page++;
      emit(ArticlesSuccess(articles: data));
    } catch (e) {
      if (e.toString() == "Exception: No more data") {
        hasMore = false;
        emit(ArticlesSuccess(articles: data));
      } else {
        emit(ArticlesError(error: e.toString()));
      }
    }
  }
}
