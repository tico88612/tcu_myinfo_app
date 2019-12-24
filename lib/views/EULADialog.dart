import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EULADialog extends StatelessWidget {
  _launchURL() async {
    const url = 'https://tcumyinfo.tw';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('終端使用者協議 EULA'),
      content: Text('您必須同意終端使用者協議才能使用此 App'),
      actions: <Widget>[
        FlatButton(
          onPressed: _launchURL,
          child: Text('詳情'),
        ),
        FlatButton(
          onPressed: () {
            SystemChannels.platform.invokeMethod('SystemNavigator.pop');
            // exit(0);
          },
          child: Text('不同意'),
        ),
        FlatButton(
          onPressed: () {
            _pressAgree();
            Navigator.pop(context);
          },
          child: Text(
            '同意',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  _pressAgree() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isAgreed', true);
  }
}
