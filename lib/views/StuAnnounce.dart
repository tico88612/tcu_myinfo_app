import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import 'package:http/http.dart' as http;

import 'package:tcu_myinfo_app/presentation/t_c_u_myinfo_icon_icons.dart';
import 'package:tcu_myinfo_app/views/AnnDetail.dart';

class StuAnnounceWidget extends StatefulWidget {
  StuAnnounceWidget({Key key, this.homeController}) : super(key: key);

  final ScrollController homeController;

  @override
  State<StatefulWidget> createState() {
    return StuAnnounceState();
  }
}

class StuAnnounceState extends State<StuAnnounceWidget> {
  var _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  List widgets = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  showLoadingDialog() {
    return widgets.length == 0;
  }

  getBody(BuildContext context) {
    if (showLoadingDialog()) {
      return getProgressDialog();
    } else {
      return getScaffold(context);
    }
  }

  getProgressDialog() {
    return Center(child: new CircularProgressIndicator());
  }

  Scaffold getScaffold(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        child: getListView(context),
        onRefresh: loadData,
      ),
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

  ListView getListView(BuildContext context) {
    return ListView.separated(
      controller: widget.homeController,
      itemCount: widgets.length,
      itemBuilder: (BuildContext context, int position) {
        return getRow(context, position);
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider(
          color: Colors.grey,
          height: 0.0,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return getBody(context);
  }

  Widget getRow(BuildContext context, int i) {
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
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AnnDetail(
            annId: widgets[i]["NewsID"],
          ),
        ),
      ),
    );
  }

  Future<Null> loadData() async {
    _refreshIndicatorKey.currentState?.show(atTop: false);
    String dataURL = "https://tcumyinfo.tw/api/ann.php?category=0";
    http.Response response = await http.get(dataURL);
    setState(() {
      widgets = json.decode(response.body);
    });
    return null;
  }
}
