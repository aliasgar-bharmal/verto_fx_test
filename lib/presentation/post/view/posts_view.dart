import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_verto/presentation/post/bloc/posts_bloc.dart';
import 'package:test_verto/presentation/post/view/post_widgets.dart';
import 'package:test_verto/presentation/post/domain/post_model.dart';

class PostsView extends StatefulWidget {
  const PostsView({super.key});

  @override
  State<PostsView> createState() => _PostsViewState();
}

class _PostsViewState extends State<PostsView> {
  late final PostsBloc _postsBloc;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _postsBloc = PostsBloc()..add(PostsLoadDataEvent());
    _scrollController.addListener(() {
      if ((_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent * 0.75)) {
        _postsBloc.add(PostsLoadDataEvent());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Posts"),
      ),
      body: BlocProvider(
        create: (_) => _postsBloc,
        child: BlocBuilder<PostsBloc, PostsState>(
          bloc: _postsBloc,
          buildWhen: (previous, current) =>
              previous != current || current is! PostsError,
          builder: (context, state) {
            if (state is PostsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PostsSuccess || state is PostsLoadingMore) {
              List<Post> posts = [];
              if (state is PostsSuccess) {
                posts = state.posts;
              } else if (state is PostsLoadingMore) {
                posts = state.posts;
              }
              return ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 20),
                controller: _scrollController,
                itemCount:
                    state is PostsLoadingMore ? posts.length + 1 : posts.length,
                itemBuilder: (context, index) {
                  if (state is PostsLoadingMore && index == posts.length) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return PostCard(post: posts[index]);
                  }
                },
              );
            } else if (state is PostsError) {
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
    _postsBloc.close();
    super.dispose();
  }
}
