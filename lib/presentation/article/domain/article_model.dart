import 'dart:convert';

List<Article> articleFromJson(List<Map<String, dynamic>> article) =>
    List<Article>.from(article.map((e) => Article.fromJson(e)).toList());

String articleToJson(List<Article> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Article {
  int? id;
  String? quote;
  String? author;

  Article({
    this.id,
    this.quote,
    this.author,
  });

  factory Article.fromJson(Map<String, dynamic> json) => Article(
        id: json["id"],
        quote: json["quote"],
        author: json["author"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "quote": quote,
        "author": author,
      };
}
