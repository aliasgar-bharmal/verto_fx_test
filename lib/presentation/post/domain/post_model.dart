import 'dart:convert';
// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

List<Post> postsFromJson(List<Map<String, dynamic>> posts) =>
    List<Post>.from(posts.map((e) => Post.fromJson(e)).toList());

String postToJson(List<Post> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Post {
  int? id;
  String? title;
  String? body;
  List<String>? tags;
  Reactions? reactions;
  int? views;
  int? userId;

  Post({
    this.id,
    this.title,
    this.body,
    this.tags,
    this.reactions,
    this.views,
    this.userId,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["id"],
        title: json["title"],
        body: json["body"],
        tags: json["tags"] == null
            ? []
            : List<String>.from(json["tags"]!.map((x) => x)),
        reactions: json["reactions"] == null
            ? null
            : Reactions.fromJson(json["reactions"]),
        views: json["views"],
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "body": body,
        "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
        "reactions": reactions?.toJson(),
        "views": views,
        "userId": userId,
      };
}

class Reactions {
  int? likes;
  int? dislikes;

  Reactions({
    this.likes,
    this.dislikes,
  });

  factory Reactions.fromJson(Map<String, dynamic> json) => Reactions(
        likes: json["likes"],
        dislikes: json["dislikes"],
      );

  Map<String, dynamic> toJson() => {
        "likes": likes,
        "dislikes": dislikes,
      };
}
