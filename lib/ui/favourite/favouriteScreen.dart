import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lyrics_app/models/englishModel.dart';
import 'package:lyrics_app/widgets/customText.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../enLyrics.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  _FavouriteScreenState createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  List<String>? favList = [];
  List<Song>? title = [];
  List<String>? titleList = [];
  EnglishModel? songTitle; // = englishModelFromJson("");
  Future<String> getJson() {
    return rootBundle.loadString('assets/EN.json');
  }

  _getData() async {
    songTitle = englishModelFromJson(await getJson());
    setState(() {
      _filter();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getFav();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Favourite'),
        centerTitle: true,
      ),
      body: _getUI(context),
    );
  }

  Widget _getUI(BuildContext context) {
    return ListView.separated(
      itemCount: favList!.length,
      itemBuilder: (context, i) {
        return Container(
          height: 80,
          width: MediaQuery.of(context).size.width,
          color: const Color(0xffFFFFFF),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomText(
                        text: '${songTitle!.songs![i].id!}',
                        textSize: 10,
                        fontWeight: FontWeight.bold,
                        textColor: Colors.black),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EnLyrics(
                                        data: title![i],
                                      )));
                        },
                        child: CustomText(
                            text: title![i].songTitle!,
                            textSize: 13,
                            fontWeight: FontWeight.w500,
                            textColor: Colors.black.withOpacity(0.9)),
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        SharedPreferences mPref =
                            await SharedPreferences.getInstance();

                        if (mPref.containsKey("myfav")) {
                          List<String>? myList = mPref.getStringList("myfav");
                          if (favList!.contains(
                              songTitle!.songs![i].songId.toString())) {
                            myList!
                                .remove(songTitle!.songs![i].songId.toString());
                            mPref.setStringList("myfav", myList);
                            _getFav();
                          } else {
                            myList!.add(songTitle!.songs![i].songId.toString());
                            mPref.setStringList("myfav", myList);
                            _getFav();
                          }
                        } else {
                          List<String>? myList = [
                            songTitle!.songs![i].songId.toString()
                          ];
                          mPref.setStringList("myfav", myList);
                          _getFav();
                        }
                      },
                      icon: favList!
                              .contains(songTitle!.songs![i].songId.toString())
                          ? const Icon(
                              Icons.favorite_outlined,
                              color: Colors.red,
                            )
                          : const Icon(
                              Icons.favorite_border,
                              color: Colors.black,
                            ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(
          thickness: 1,
          indent: 15,
          endIndent: 15,
        );
      },
    );
  }

  _getFav() async {
    favList!.clear();
    SharedPreferences mPref = await SharedPreferences.getInstance();
    favList = mPref.getStringList("myfav");
    setState(() {
      print(mPref.getStringList("myfav"));
    });
  }

  _filter() {
    title!.clear();
    for (var item in songTitle!.songs!) {
      if (favList!.contains(item.songId.toString())) {
        title!.add(item);
        setState(() {});
      }
    }
  }
}
