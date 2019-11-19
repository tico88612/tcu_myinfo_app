import 'package:flutter/material.dart';
import 'package:tcu_myinfo_app/presentation/t_c_u_myinfo_icon_icons.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppDrawerWidget();
  }
}

class AppDrawerWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AppDrawerState();
  }
}

class AppDrawerState extends State<AppDrawerWidget> {
  bool haslogin = false;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.grey,
            ),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 12.0),
                    child: SizedBox(
                      width: 60.0,
                      height: 60.0,
                      child: CircleAvatar(
                        child: Icon(TCUMyinfoIcon.user),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 6.0),
                    child: Text(
                      '106316119',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Text(
                    '醫學資訊學系 楊承昊',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            child: ListTile(
              leading: Icon(TCUMyinfoIcon.login),
              title: Text('登入'),
              onTap: () {
                // Do Something
                Navigator.pop(context);
                setState(
                      () {
                    haslogin = false;
                  },
                );
              },
            ),
            replacement: ListTile(
              leading: Icon(TCUMyinfoIcon.logout),
              title: Text('登出'),
              onTap: () {
                // Do Something
                Navigator.pop(context);
                setState(
                  () {
                    haslogin = true;
                  },
                );
              },
            ),
            visible: haslogin,
          ),
          ListTile(
            leading: Icon(TCUMyinfoIcon.pencil),
            title: Text('外宿申請'),
            onTap: () {
              // Do Something
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(TCUMyinfoIcon.calendar_check_o),
            title: Text('外宿預約申請'),
            onTap: () {
              // Do Something
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(TCUMyinfoIcon.cog),
            title: Text('設定'),
            onTap: () {
              // Do Something
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(TCUMyinfoIcon.facebook_squared),
            title: Text('FaceBook 專頁'),
            onTap: () {
              // Do Something
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(TCUMyinfoIcon.info_circled),
            title: Text('關於我們'),
            onTap: () {
              // Do Something
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
