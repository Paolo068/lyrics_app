import 'package:flutter/material.dart';
import 'package:lyrics_app/navigation/navigationHelper.dart';
import 'package:lyrics_app/ui/favourite/favouriteScreen.dart';
import 'package:lyrics_app/ui/favourite/frFavourite.dart';
import 'package:lyrics_app/widgets/customText.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
              decoration: const BoxDecoration(color: Colors.white),
              child: Image.asset(
                'assets/images/logo.png',
                fit: BoxFit.contain,
              )),
          ListTile(
            leading: const Icon(
              Icons.favorite_outlined,
              color: Colors.red,
            ),
            title: const CustomText(
                text: "English Favourite",
                textSize: 14,
                fontWeight: FontWeight.w500,
                textColor: Colors.black),
            onTap: () =>
                {NavigationHelper.pushRoute(context, const FavouriteScreen())},
          ),
          ListTile(
            leading: const Icon(
              Icons.favorite_outlined,
              color: Colors.red,
            ),
            title: const CustomText(
                text: "French Favourite",
                textSize: 14,
                fontWeight: FontWeight.w500,
                textColor: Colors.black),
            onTap: () =>
                {NavigationHelper.pushRoute(context, const FrFavourite())},
          ),
        ],
      ),
    );
  }
}
