import 'dart:convert';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:lyrics_app/models/englishModel.dart';
import 'package:lyrics_app/widgets/customText.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EnLyrics extends StatefulWidget {
  final Song data;

  const EnLyrics({super.key, required this.data});

  @override
  _EnLyricsState createState() => _EnLyricsState();
}

class _EnLyricsState extends State<EnLyrics> {
  List<String>? favList = [];
  EnglishModel? songTitle;
  EnglishModel? id;
  List<String> audiosId = [];
  bool playing = false;

  _getFav() async {
    SharedPreferences mPref = await SharedPreferences.getInstance();
    favList = mPref.getStringList("myfav");
    setState(() {
      print(mPref.getStringList("myfav"));
    });
  }

  _getAllAudioFilePaths() async {
    List<String> audioPaths;
    final String manifestJson =
        await DefaultAssetBundle.of(context).loadString('AssetManifest.json');
    audioPaths = json
        .decode(manifestJson)
        .keys
        .where((String key) => key.startsWith('assets/songs'))
        .toList();
    print(audioPaths);
    return audioPaths;
  }

  _getAudioIdByPath() async {
    List<String> audioPaths = [];
    List<String> paths = [];
    audioPaths = await _getAllAudioFilePaths();

    for (var path in audioPaths) {
      paths.add(path.split('/').last);
    }

    for (var p in paths) {
      audiosId.add(p.split('.')[0]);
    }
    print(audiosId);
    return audiosId;
  }

  // This is because id are either of type string nor int

  @override
  void initState() {
    super.initState();
    print(widget.data.songTitle);
    print(widget.data.id);
    print(_getAudioIdByPath());
    print(_getAudioIdByPath());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        toolbarHeight: 80.0,
        elevation: 10,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CustomText(
                    text: '${widget.data.id.toString()}.',
                    textSize: 16,
                    fontWeight: FontWeight.bold,
                    textColor: Colors.white),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: CustomText(
                      text: widget.data.songTitle.toString(),
                      textSize: 16,
                      fontWeight: FontWeight.bold,
                      textColor: Colors.white),
                ),
              ],
            ),
            CustomText(
                text: widget.data.author.toString(),
                textSize: 14,
                fontWeight: FontWeight.w500,
                textColor: Colors.white),
            CustomText(
                text: widget.data.key.toString(),
                textSize: 12,
                fontWeight: FontWeight.normal,
                textColor: Colors.white),
          ],
        ),
        actions: [
          Center(
            child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.favorite_border_rounded,
                  color: Colors.white,
                )),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          for (var audioId in audiosId) {
            final assetsAudioPlayer =
                AssetsAudioPlayer.withId(widget.data.id.toString());
            if (widget.data.id.toString() == audioId.toString() && !playing) {
              assetsAudioPlayer.open(
                Audio("assets/songs/$audioId.Fr.mp3"),
                showNotification: true,
              );
            } else {
              assetsAudioPlayer.pause();
            }
          }
          setState(() {
            playing = !playing;
          });
        },
        backgroundColor: Colors.red,
        child: playing ? const Icon(Icons.pause) : const Icon(Icons.play_arrow),
      ),
      body: _getUI(context),
    );
  }

  Widget _getUI(BuildContext context) {
    return Column(
      children: [
        widget.data.chorus != ""
            ? Padding(
                padding: const EdgeInsets.all(25),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const CustomText(
                            text: 'Chorus:',
                            textSize: 18,
                            fontWeight: FontWeight.bold,
                            textColor: Colors.black),
                        const SizedBox(
                          height: 5,
                        ),
                        CustomText(
                            text: widget.data.chorus!,
                            textSize: 14,
                            fontWeight: FontWeight.normal,
                            fontStyle:  FontStyle.italic,
                            textColor: Colors.black),
                      ],
                    ),
                  ],
                ),
              )
            : Container(),
        Flexible(
          fit: FlexFit.tight,
          child: ListView.builder(
              itemCount: widget.data.enLyrics!.length,
              itemBuilder: (context, i) {
                return Container(
                  color: Colors.white,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Row(
                            children: [
                              CustomText(
                                  text: '${1 + i}',
                                  textSize: 14,
                                  fontWeight: FontWeight.bold,
                                  textColor: Colors.black),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: CustomText(
                                    text: widget.data.enLyrics![i],
                                    textSize: 14,
                                    fontWeight: FontWeight.w500,
                                    textColor:
                                        Colors.black.withOpacity(0.9)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ),
      ],
    );
  }
}
