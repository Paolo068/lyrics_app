import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:lyrics_app/models/englishModel.dart';
import 'package:lyrics_app/ui/frenchScreen.dart';
import 'package:lyrics_app/ui/enLyrics.dart';
import 'package:lyrics_app/ui/homeScreen.dart';
import 'package:lyrics_app/widgets/customText.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:shared_preferences/shared_preferences.dart';

import 'NavDrawer.dart';

class EnglishScreen extends StatefulWidget {
  const EnglishScreen({Key? key}) : super(key: key);

  @override
  _EnglishScreenState createState() => _EnglishScreenState();
}

class _EnglishScreenState extends State<EnglishScreen> {
  @override
  List<String>? favList = [];
  var filterList = [];

  Future<String> getJson() {
    return rootBundle.loadString('assets/EN.json');
  }

  final TextEditingController _search = TextEditingController();

  EnglishModel? songTitle; // = englishModelFromJson("");
  bool isLoading = true;
  final filteredData = [];

  _getData() async {
    songTitle = englishModelFromJson(await getJson());
    isLoading = false;
    setState(() {
      // makeLoadingFalse();
    });
  }

  @override
  void initState() {
    super.initState();
    makeLoadingTrue();
    _getData();
    //_getFav();
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
          title: TextField(
            controller: _search,
            cursorColor: Colors.white,
            onChanged: (name) {
              print('name $name');
              _filter(name);
              setState(() {});
            },
            decoration: const InputDecoration(
              hintText: "Search ...",
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
                              builder: (context) => const FrenchScreen()));
                    },
                    child: const CustomText(
                        text: 'FR',
                        textSize: 14,
                        fontWeight: FontWeight.bold,
                        textColor: Colors.white))),
            const SizedBox(
              width: 20,
              height: 10,
            )
          ],
        ),
        body: songTitle == null ? Center(child: Container()) : _getUI(context),
      ),
    );
  }

  Widget _getUI(BuildContext context) {
    return ListView.separated(
      itemCount: songTitle!.songs!.length,
      itemBuilder: (context, i) {
        return Container(
          color: const Color(0xffFFFFFF),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomText(
                    text: '${songTitle!.songs![i].id!}', //SongTitle
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
                                    data: songTitle!.songs![i],
                                  )));
                    },
                    child: CustomText(
                        text: songTitle!.songs![i].songTitle!,
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
                        if (favList!
                            .contains(songTitle!.songs![i].songId.toString())) {
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
                          ))
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

  _filter(String name) {
    filterList.clear();
    for (var item in songTitle!.songs!) {
      var title = item.songTitle!.toString().toLowerCase();
      if (title.toLowerCase().toString().contains(name.toString())) {
        print(item.toString());
        filterList.add(item);
        setState(() {});
      }
    }
  }

  makeLoadingTrue() {
    isLoading = true;
    setState(() {});
  }

  makeLoadingFalse() {
    isLoading = false;
    setState(() {});
  }

  _getFav() async {
    SharedPreferences mPref = await SharedPreferences.getInstance();
    favList = mPref.getStringList("myfav");
    setState(() {
      print(mPref.getStringList("myfav"));
    });
  }
}
