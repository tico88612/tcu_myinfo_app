import 'package:flutter/material.dart';

import 'package:tcu_myinfo_app/views/AppDrawer.dart';
import 'package:tcu_myinfo_app/views/EULADialog.dart';

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

  void _showMaterialDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return EULADialog();
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
      body: Center(
        child: _pageList[_tabIndex],
      ),
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
