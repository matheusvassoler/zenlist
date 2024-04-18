import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zenlist/components/shopping_item.dart';
import 'package:zenlist/screens/add_product.dart';
import 'package:zenlist/screens/shopping_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ShoppingList()
    );
  }
}

