// To parse this JSON data, do
//
//     final frenchSongs = frenchSongsFromJson(jsonString);

import 'dart:convert';

FrenchModel frenchSongsFromJson(String str) => FrenchModel.fromJson(json.decode(str));

String frenchSongsToJson(FrenchModel data) => json.encode(data.toJson());

class FrenchModel {
  FrenchModel({
    required this.songs,
  });

  List<Song> songs;

  factory FrenchModel.fromJson(Map<String, dynamic> json) => FrenchModel(
    songs: List<Song>.from(json["songs"].map((x) => Song.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "songs": List<dynamic>.from(songs.map((x) => x.toJson())),
  };
}

class Song {
  Song({
    required this.songTitle,
    required this.songId,
    required this.id,
    required this.chorus,
    required this.key,
    required this.author,
    required this.enLyrics,
  });

  String songTitle;
  int songId;
  dynamic id;
  String chorus;
  String key;
  String author;
  List<String> enLyrics;

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
    "id":id,
    "songId": songId,
    "chorus": chorus,
    "key": key,
    "author": author,
    "enLyrics": List<dynamic>.from(enLyrics.map((x) => x)),
  };
}
