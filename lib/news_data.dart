import 'dart:convert';

List<NewsData> dataFromJson(String str) => List<NewsData>.from(json.decode(str).map((x) => NewsData.fromJson(x)));

String dataToJson(List<NewsData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NewsData {
  NewsData({
    required this.id,
    this.name,
    this.header,
    this.text,
    this.likes,
    this.subscription = false,
    this.comments,
    this.image,
    this.date,
    this.isTopic = false
  });

  final String? id;
  final String? name;
  final String? header;
  final String? text;
  int? likes;
  final String? image;
  int? comments;
  bool? subscription;
  final DateTime? date;
  final bool isTopic;

  factory NewsData.fromJson(Map<String, dynamic> json) => NewsData(
    id: json["id"] == null ? "" : json["id"],
    name: json["name"] == null ? null : json["name"],
    header: json["header"] == null ? '' : json["header"],
    text: json["text"] == null ? '' : json["text"],
    likes: json["likes"] == null ? 0 : json["likes"],
    comments: json["comments"] == null ? 0 : json["comments"],
    subscription: json["subscription"] == null ? false : json["subscription"],
    image: json["image"] == null ? null : json["image"],
    date: json["date"] == null ? DateTime.now() : DateTime.fromMillisecondsSinceEpoch(json["date"]),
    isTopic: json["isTopic"] == null ? false : json["isTopic"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "image": image == null ? null : image,
    "likes": likes == null ? null : likes,
  };

}

