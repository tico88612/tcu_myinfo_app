import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
      return getListView();
    }
  }

  getProgressDialog() {
    return new Center(child: new CircularProgressIndicator());
  }

  final string =
      'Lorem ipsum dolor sit amet, fringilla tincidunt, ullamcorper nulla lacinia gravida, tortor nam';

  ListView getListView() => new ListView.separated(
        controller: widget.homeController,
        itemCount: widgets.length,
        itemBuilder: (BuildContext context, int position) {
          return getRow(position);
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            color: Colors.grey,
          );
        },
      );
  @override
  Widget build(BuildContext context) {
    return getBody();
  }

  Widget getRow(int i) {
    return ListTile(
      title: Text("${widgets[i]["Title"]}"),
      subtitle: Text("${widgets[i]["Dept"]}．${widgets[i]["Date"]}"),
      onTap: () => Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text(
            widgets[i]["Dept"],
          ),
        ),
      ),
    );
  }

  loadData() async {
    String dataURL = "https://tcumyinfo.tw/api/ann.php";
    http.Response response = await http.get(dataURL);
    setState(() {
      widgets = json.decode(response.body);
    });
  }
}
