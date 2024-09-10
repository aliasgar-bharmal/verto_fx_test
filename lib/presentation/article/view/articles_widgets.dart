import 'package:flutter/material.dart';
import 'package:test_verto/presentation/article/domain/article_model.dart';

class ArticlesCard extends StatelessWidget {
  final Article article;
  const ArticlesCard({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            article.quote ?? "",
          ),
          const SizedBox(height: 12),
          Text(
            "By: ${article.author}",
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
