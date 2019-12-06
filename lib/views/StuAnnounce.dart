import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import 'package:tcu_myinfo_app/presentation/t_c_u_myinfo_icon_icons.dart';

//class StuAnnounce extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return StuAnnounceWidget();
//  }
//}

class StuAnnounceWidget extends StatefulWidget {
  StuAnnounceWidget({Key key, this.homeController}) : super(key: key);

  final ScrollController homeController;

  @override
  State<StatefulWidget> createState() {
    return StuAnnounceState();
  }
}

class StuAnnounceState extends State<StuAnnounceWidget> {
  List widgets = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  showLoadingDialog() {
    return widgets.length == 0;
  }

  getBody() {
    if (showLoadingDialog()) {
      return getProgressDialog();
    } else {
      return getScaffold();
    }
  }

  getProgressDialog() {
    return new Center(child: new CircularProgressIndicator());
  }

  Scaffold getScaffold() {
    return Scaffold(
      body: getListView(),
      floatingActionButton: SpeedDial(
        // both default to 16
        marginRight: 18,
        marginBottom: 20,
        animatedIconTheme: IconThemeData(size: 22.0),
        // this is ignored if animatedIcon is non null
        child: Icon(TCUMyinfoIcon.search),
        visible: true,
        // If true user is forced to close dial manually
        // by tapping main button and overlay is not rendered.
        closeManually: false,
        curve: Curves.bounceIn,
        overlayColor: Colors.black,
        overlayOpacity: 0.5,
        tooltip: 'Speed Dial',
        elevation: 8.0,
        shape: CircleBorder(),
        children: [
          SpeedDialChild(
              child: Icon(TCUMyinfoIcon.font),
              backgroundColor: Colors.red,
              label: '標題',
              labelStyle: TextStyle(fontSize: 18.0),
              onTap: () => print('FIRST CHILD')),
          SpeedDialChild(
            child: Icon(TCUMyinfoIcon.location),
            backgroundColor: Colors.yellow[800],
            label: '單位',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () => print('SECOND CHILD'),
          ),
          SpeedDialChild(
            child: Icon(TCUMyinfoIcon.calendar),
            backgroundColor: Colors.blue,
            label: '日期',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () => print('THIRD CHILD'),
          ),
        ],
      ),
    );
  }

  ListView getListView() => new ListView.separated(
        controller: widget.homeController,
        itemCount: widgets.length,
        itemBuilder: (BuildContext context, int position) {
          return getRow(position);
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            color: Colors.grey,
            height: 0.0,
          );
        },
      );
  @override
  Widget build(BuildContext context) {
    return getBody();
  }

  Widget getRow(int i) {
    return ListTile(
      title: Text(
        "${widgets[i]["Title"]}",
        softWrap: true,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        "${widgets[i]["Dept"]}．${widgets[i]["Date"]}",
        softWrap: true,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: () => Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text(
            widgets[i]["Dept"],
          ),
          duration: Duration(seconds: 1),
        ),
      ),
    );
  }

  loadData() async {
    String dataURL = "https://tcumyinfo.tw/api/ann.php?category=0";
    http.Response response = await http.get(dataURL);
    setState(() {
      widgets = json.decode(response.body);
    });
  }
}
