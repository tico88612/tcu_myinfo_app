import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:url_launcher/url_launcher.dart';
import 'package:tcu_myinfo_app/presentation/t_c_u_myinfo_icon_icons.dart';

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
  List<Map<String, dynamic>> attachment;
  List<Map<String, dynamic>> link;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return _getBody(context);
  }

  Widget _getBody(BuildContext context) {
    if (annDetails == null) {
      return _getProgressDialog();
    } else {
      return _getScaffold(context);
    }
  }

  Scaffold _getProgressDialog() {
    return Scaffold(
      appBar: AppBar(
        title: Text("載入中..."),
        centerTitle: true,
      ),
      body: Center(child: new CircularProgressIndicator()),
    );
  }

  Scaffold _getScaffold(BuildContext context) {
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
            children: _getContext(),
          ),
        ),
      ),
    );
  }

  List<Widget> _getContext() {
    return <Widget>[
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
                    color: Color.fromARGB(
                        255, 100, 100, 100), // TODO: Darker mode Text Color
                  ),
                );
            }
          }
          return baseStyle;
        },
      ),
      _getAttachments(),
      _getLinks(),
    ];
  }

  Column _getAttachments() {
    attachment = List<Map<String, dynamic>>.from(annDetails["Attachments"]);
    if (attachment.length == 0) return Column();
    return Column(
      children: <Widget>[
        ListTile(
          leading: Icon(TCUMyinfoIcon.attach_file),
          title: Text(
            "附加檔案",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ListView.builder(
          itemCount: attachment.length,
          itemBuilder: (BuildContext context, int position) {
            return _getEachAttachment(context, position);
          },
          shrinkWrap: true,
          primary: false,
        )
      ],
    );
  }

  Widget _getEachAttachment(BuildContext context, int i) {
    return ListTileTheme(
      iconColor: Color.fromARGB(255, 38, 166, 154),
      textColor: Color.fromARGB(255, 38, 166, 154),
      child: ListTile(
        leading: _getEachAttachmentIcon(attachment[i]["FileLink"]),
        title: Text(
          "${attachment[i]["FileName"]}",
          softWrap: true,
          overflow: TextOverflow.ellipsis,
        ),
        onTap: () {
          _launchURL(attachment[i]["FileLink"]);
        },
      ),
    );
  }

  Icon _getEachAttachmentIcon(String extension) {
    final alphanumeric =
        RegExp(r'\.([0-9a-z]+)(?:[\?#]|$)', caseSensitive: true);
    final match = alphanumeric.firstMatch(extension);
    extension = match.group(1);
    switch (extension) {
      case "pdf":
        return Icon(TCUMyinfoIcon.file_pdf);
      case "jpg":
      case "gif":
      case "png":
        return Icon(TCUMyinfoIcon.picture);
      case "doc":
      case "docx":
        return Icon(TCUMyinfoIcon.file_word);
      case "xls":
      case "xlsx":
        return Icon(TCUMyinfoIcon.file_excel);
      case "ppt":
      case "pptx":
        return Icon(TCUMyinfoIcon.file_powerpoint);
      default:
        return Icon(TCUMyinfoIcon.doc_text);
    }
  }

  Column _getLinks() {
    link = List<Map<String, dynamic>>.from(annDetails["Links"]);
    if (link.length == 0) return Column();
    return Column(
      children: <Widget>[
        ListTile(
          leading: Icon(TCUMyinfoIcon.link),
          title: Text(
            "相關連結",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ListView.builder(
          itemCount: link.length,
          itemBuilder: (BuildContext context, int position) {
            return _getEachLink(context, position);
          },
          shrinkWrap: true,
          primary: false,
        )
      ],
    );
  }

  Widget _getEachLink(BuildContext context, int i) {
    return ListTileTheme(
      iconColor: Color.fromARGB(255, 38, 166, 154),
      textColor: Color.fromARGB(255, 38, 166, 154),
      child: ListTile(
        title: Text(
          "${link[i]["LinkName"]}",
          softWrap: true,
          overflow: TextOverflow.ellipsis,
        ),
        onTap: () {
          _launchURL(link[i]["Hyperlink"]);
        },
      ),
    );
  }

  _launchURL(String url) async {
    url = Uri.encodeFull(url);
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
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
