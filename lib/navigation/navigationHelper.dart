import 'package:flutter/material.dart';

class NavigationHelper{
  static pushRoute(BuildContext context , Widget targetClass){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>targetClass));
  }
  static pushReplacement(BuildContext context , Widget targetClass){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>targetClass));
  }
}