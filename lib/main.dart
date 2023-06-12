import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lyrics_app/ui/englishScreen.dart';
import 'package:lyrics_app/ui/frenchScreen.dart';
import 'package:lyrics_app/ui/homeScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  showPageByLang(){
    Locale deviceLocale = window.locale;
    String langCode = deviceLocale.languageCode;
    if (langCode =='en'){
      return const EnglishScreen();
    } else {
      return const FrenchScreen();
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lyrics App',
      theme: ThemeData(fontFamily: GoogleFonts.poppins().fontFamily),
      home: const HomeScreen(), //HomeScreen(),
    );
  }
}
