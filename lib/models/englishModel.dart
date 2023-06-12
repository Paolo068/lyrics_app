// To parse this JSON data, do
//
//     final englishModel = englishModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

EnglishModel englishModelFromJson(String str) =>
    EnglishModel.fromJson(json.decode(str));

String englishModelToJson(EnglishModel data) => json.encode(data.toJson());

class EnglishModel {
  EnglishModel({
    @required this.songs,
  });

  List<Song>? songs;

  factory EnglishModel.fromJson(Map<String, dynamic> json) => EnglishModel(
        songs: List<Song>.from(json["songs"].map((x) => Song.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "songs": List<dynamic>.from(songs!.map((x) => x.toJson())),
      };
}

class Song {
  Song({
    @required this.songTitle,
    @required this.songId,
    @required this.id,
    @required this.chorus,
    @required this.key,
    @required this.author,
    @required this.enLyrics,
  });

  String? songTitle;
  int? songId;
  dynamic id;
  String? chorus;
  String? key;
  String? author;
  List<String>? enLyrics;

  factory Song.fromJson(Map<String, dynamic> json) => Song(
        songTitle: json["songTitle"],
        songId: json["songId"],
        id: json["id"],
        chorus: json["chorus"],
        key: json["key"],
        author: json["author"],
        enLyrics: List<String>.from(json["enLyrics"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "songTitle": songTitle,
        "songId": songId,
        "id": id,
        "chorus": chorus,
        "key": key,
        "author": author,
        "enLyrics": List<dynamic>.from(enLyrics!.map((x) => x)),
      };
}
