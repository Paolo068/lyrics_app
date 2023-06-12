import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:lyrics_app/ui/englishScreen.dart';
import 'package:lyrics_app/ui/frenchScreen.dart';
import 'package:lyrics_app/widgets/customText.dart';

import 'NavDrawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var filterList = [];

  bool isLoading = false;
  List<String>? favList = [];

  @override
  void initState() {
    super.initState();
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
            actions: [
              Center(
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  InkWell(
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
                          textColor: Colors.white)),
                  const SizedBox(
                    width: 30,
                    height: 10,
                  ),
                  InkWell(
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
                          textColor: Colors.white)),
                  const SizedBox(
                    width: 20,
                    height: 10,
                  ),
                  IconButton(
                      onPressed: () {}, icon: const Icon(Icons.favorite)),
                ]),
              ),
            ],
          ),
          body: Center(
            child: Image.asset(
              'assets/images/splash.png',
              fit: BoxFit.fitHeight,
            ),
          )),
    );
  }
}
