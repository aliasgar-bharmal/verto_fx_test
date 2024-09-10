import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_verto/presentation/article/bloc/article_bloc.dart';
import 'package:test_verto/presentation/article/domain/article_model.dart';
import 'package:test_verto/presentation/article/view/articles_widgets.dart';

class ArticlesView extends StatefulWidget {
  const ArticlesView({super.key});

  @override
  State<ArticlesView> createState() => _ArticlesViewState();
}

class _ArticlesViewState extends State<ArticlesView> {
  late final ArticleBloc _articlesBloc;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _articlesBloc = ArticleBloc()..add(ArticlesLoadDataEvent());
    _scrollController.addListener(() {
      if ((_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent * 0.75)) {
        _articlesBloc.add(ArticlesLoadDataEvent());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Article"),
      ),
      body: BlocProvider(
        create: (_) => _articlesBloc,
        child: BlocBuilder<ArticleBloc, ArticleState>(
          bloc: _articlesBloc,
          buildWhen: (previous, current) => previous != current,
          builder: (context, state) {
            if (state is ArticlesLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ArticlesSuccess ||
                state is ArticlesLoadingMore) {
              List<Article> articles = [];
              if (state is ArticlesSuccess) {
                articles = state.articles;
              } else if (state is ArticlesLoadingMore) {
                articles = state.articles;
              }
              return ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 20),
                controller: _scrollController,
                itemCount: state is ArticlesLoadingMore
                    ? articles.length + 1
                    : articles.length,
                itemBuilder: (context, index) {
                  if (state is ArticlesLoadingMore &&
                      index == articles.length) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return ArticlesCard(
                      article: articles[index],
                    );
                  }
                },
              );
            } else if (state is ArticlesError) {
              return Center(child: Text('No data available. ${state.error}'));
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _articlesBloc.close();
    super.dispose();
  }
}
