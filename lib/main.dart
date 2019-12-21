import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tcu_myinfo_app/MainPage.dart';

void main() {
//  debugPaintSizeEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "慈大查詢系統 —— TCU Myinfo",
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.green[900],
      ),
      home: MainPage(),
    );
  }
}
