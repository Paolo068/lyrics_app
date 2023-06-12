import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:loading_overlay/loading_overlay.dart';
import 'package:lyrics_app/models/frenchModel.dart';
import 'package:lyrics_app/ui/englishScreen.dart';
import 'package:lyrics_app/ui/frLyrics.dart';
import 'package:lyrics_app/ui/homeScreen.dart';
import 'package:lyrics_app/widgets/customText.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'NavDrawer.dart';

class FrenchScreen extends StatefulWidget {
  const FrenchScreen({Key? key}) : super(key: key);

  @override
  _FrenchScreenState createState() => _FrenchScreenState();
}

class _FrenchScreenState extends State<FrenchScreen> {
  

  List<String>? favList = [];

  Future<String> getJson() {
    return rootBundle.loadString('assets/FR.json');
  }

  FrenchModel? songTitle; // = englishModelFromJson("");
  bool isLoading = true;

  _getData() async {
    songTitle = frenchSongsFromJson(await getJson());
    isLoading = false;
    setState(() {});
  }
@override
  void initState() {
    super.initState();
    _getData();
  }
  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: isLoading,
      progressIndicator: const CircularProgressIndicator(),
      color: Colors.black,
      opacity: 0.3,
      child: Scaffold(
        drawer: const NavDrawer(),
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.black,
          toolbarHeight: 60.0,
          elevation: 10,
          title: const TextField(
            cursorColor: Colors.white,
            decoration: InputDecoration(
              hintText: "Recherche ...",
              border: InputBorder.none,
              hintStyle:
                  TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
            ),
            style: const TextStyle(color: Colors.grey, fontSize: 15.0),
          ),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
            IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen()));
                },
                icon: const Icon(Icons.home)),
            const SizedBox(
              width: 20,
              height: 10,
            ),
            Center(
                child: InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const EnglishScreen()));
                    },
                    child: const CustomText(
                        text: 'EN',
                        textSize: 14,
                        fontWeight: FontWeight.bold,
                        textColor: Colors.white))),
            const SizedBox(
              width: 20,
              height: 10,
            ),
          ],
        ),
        body: songTitle == null ? Center(child: Container()) : _getUI(context),
      ),
    );
  }

  Widget _getUI(BuildContext context) {
    return ListView.separated(
      itemCount: songTitle!.songs.length,
      itemBuilder: (context, i) {
        return Container(
          color: const Color(0xffFFFFFF),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomText(
                    text: '${songTitle!.songs[i].id!}',
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
                              builder: (context) => FrLyrics(
                                    frData: songTitle!.songs[i],
                                  )));
                    },
                    child: CustomText(
                        text: songTitle!.songs[i].songTitle,
                        textSize: 13,
                        fontWeight: FontWeight.w500,
                        textColor: Colors.black.withOpacity(0.9)),
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    SharedPreferences mPref =
                        await SharedPreferences.getInstance();

                    if (mPref.containsKey("FRfav")) {
                      List<String>? myList = mPref.getStringList("FRfav");
                      if (favList!
                          .contains(songTitle!.songs[i].songId.toString())) {
                        myList!.remove(songTitle!.songs[i].songId.toString());
                        mPref.setStringList("FRfav", myList);
                        _getFav();
                      } else {
                        myList!.add(songTitle!.songs[i].songId.toString());
                        mPref.setStringList("FRfav", myList);
                        _getFav();
                      }
                    } else {
                      List<String>? myList = [
                        songTitle!.songs[i].songId.toString()
                      ];
                      mPref.setStringList("FRfav", myList);
                      _getFav();
                    }
                  },
                  icon: favList!.contains(songTitle!.songs[i].songId.toString())
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
        );
      },
      separatorBuilder: (context, index) {
        return const Divider(
          thickness: 1,
          indent: 15,
          endIndent: 15,
        );
      },
    );
  }

  _getFav() async {
    SharedPreferences mPref = await SharedPreferences.getInstance();
    favList = mPref.getStringList("FRfav");
    setState(() {
      print(mPref.getStringList("FRfav"));
    });
  }
}
