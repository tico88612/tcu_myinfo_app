import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;

class AnnDetail extends StatefulWidget {
  AnnDetail({Key key, this.annId}) : super(key: key);

  final String annId;

  @override
  State<StatefulWidget> createState() {
    return AnnDetailState();
  }
}

class AnnDetailState extends State<AnnDetail> {
  Map<String, dynamic> annDetails;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  showLoadingDialog() {
    return annDetails?.isEmpty;
  }

  getBody(BuildContext context) {
    if (annDetails == null) {
      return getProgressDialog();
    } else {
      return getScaffold(context);
    }
  }

  Scaffold getScaffold(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "慈大查詢系統",
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(30.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: Text(
                  annDetails["Title"],
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Html(
                data: annDetails["Context"],
                customTextStyle: (dom.Node node, TextStyle baseStyle) {
                  if (node is dom.Element) {
                    switch (node.localName) {
                      default:
                        return baseStyle.merge(
                          TextStyle(
                            height: 1.5,
                            fontSize: 18,
                            color: Color.fromARGB(255, 100, 100, 100),
                          ),
                        );
                    }
                  }
                  return baseStyle;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  getProgressDialog() {
    return Scaffold(
      appBar: AppBar(
        title: Text("載入中..."),
        centerTitle: true,
      ),
      body: Center(child: new CircularProgressIndicator()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return getBody(context);
  }

  loadData() async {
    String dataURL =
        "https://tcumyinfo.tw/api/ann_detail.php?annId=" + widget.annId;
    http.Response response = await http.get(dataURL);
    setState(() {
      annDetails = json.decode(response.body);
    });
  }
}
