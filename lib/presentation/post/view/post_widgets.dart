import 'package:flutter/material.dart';
import 'package:test_verto/presentation/post/domain/post_model.dart';

class PostCard extends StatelessWidget {
  final Post post;
  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            post.title ?? "",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(post.body ?? ""),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Views :${post.views}",
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "Likes :${post.reactions!.likes}",
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "Dislike :${post.reactions!.dislikes}",
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
