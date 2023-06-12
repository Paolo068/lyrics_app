import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:lyrics_app/models/frenchModel.dart';
import 'package:lyrics_app/widgets/customText.dart';

class FrLyrics extends StatefulWidget {
  final Song frData;

  const FrLyrics({super.key, required this.frData});

  @override
  _FrLyricsState createState() => _FrLyricsState();
}

class _FrLyricsState extends State<FrLyrics> {
  List<String> audiosId = [];
  bool playing = false;

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

  @override
  void initState() {
    super.initState();
    print(widget.frData.songTitle);
    print(widget.frData.id);
    // print(_getAllAudioFilePaths());
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
                        text: '${widget.frData.id.toString()}.',
                        textSize: 16,
                        fontWeight: FontWeight.bold,
                        textColor: Colors.white),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: CustomText(
                          text: widget.frData.songTitle.toString(),
                          textSize: 16,
                          fontWeight: FontWeight.bold,
                          textColor: Colors.white),
                    ),
                  ],
                ),
                CustomText(
                    text: widget.frData.author.toString(),
                    textSize: 14,
                    fontWeight: FontWeight.w500,
                    textColor: Colors.white),
                CustomText(
                    text: widget.frData.key.toString(),
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
            ]),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            for (var audioId in audiosId) {
              final assetsAudioPlayer =
                  AssetsAudioPlayer.withId(widget.frData.id.toString());
              if (widget.frData.id.toString() == audioId.toString() &&
                  !playing) {
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
          child:
              playing ? const Icon(Icons.pause) : const Icon(Icons.play_arrow),
        ),
        body: _getUI(context));
  }

  Widget _getUI(BuildContext context) {
    return Column(
      children: [
        widget.frData.chorus != ""
            ? Padding(
                padding: const EdgeInsets.all(25),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                            text: widget.frData.chorus,
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
            itemCount: widget.frData.enLyrics.length,
            itemBuilder: (context, i) {
              return Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: Column(
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
                                text: widget.frData.enLyrics[i],
                                textSize: 14,
                                fontWeight: FontWeight.w500,
                                textColor: Colors.black.withOpacity(0.9),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
