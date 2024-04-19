import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zenlist/screens/android/shopping_list_android.dart';
import 'dart:io' show Platform;

import 'package:zenlist/screens/ios/shopping_list_ios.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoApp(
        title: 'Flutter Demo',
        home: ShoppingListIOS()
      );
    } else {
      return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: ShoppingListAndroid()
      );
    }
  }
}

