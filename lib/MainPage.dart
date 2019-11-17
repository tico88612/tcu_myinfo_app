import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tcu_myinfo_app/views/AppDrawer.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MainPageWidget();
  }
}

class MainPageWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MainPageState();
  }
}

class MainPageState extends State<MainPageWidget> {
  int _tabIndex = 0;
  var appBarTitles = ['首頁', '校園活動', '學期課表', '設定'];
  var _pageList;

  Text getTabTitle(int curIndex) {
    if (curIndex == _tabIndex) {
      return new Text(
        appBarTitles[curIndex],
      );
    } else {
      return new Text(
        appBarTitles[curIndex],
      );
    }
  }

  void initData() {
    _pageList = [
      new Text("首頁"),
      new Text("校園活動"),
      new Text("學期課表"),
      new Text("設定"),
    ];
  }

  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () {
        _showMaterialDialog();
      },
    );
  }

  void _dismissDialog() {
    Navigator.pop(context);
  }

  void _showMaterialDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('終端使用者協議 EULA'),
          content: Text('您必須同意終端使用者協議才能使用此 App'),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                // exit(0);
              },
              child: Text('不同意'),
            ),
            FlatButton(
              onPressed: () {
                _dismissDialog();
              },
              child: Text('同意'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    initData();
    return Scaffold(
      appBar: AppBar(
        title: Text("慈大查詢系統"),
        centerTitle: false,
      ),
      drawer: AppDrawer(),
      body: _pageList[_tabIndex],
      bottomNavigationBar: new BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          new BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: getTabTitle(0),
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.message),
            title: getTabTitle(1),
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.today),
            title: getTabTitle(2),
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: getTabTitle(3),
          ),
        ],
        type: BottomNavigationBarType.fixed,
        //預設選中首頁
        currentIndex: _tabIndex,
        iconSize: 24.0,
        //點選事件
        onTap: (index) {
          setState(
            () {
              _tabIndex = index;
            },
          );
        },
      ),
    );
  }
}
