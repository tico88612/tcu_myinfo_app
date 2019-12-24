import 'package:flutter/material.dart';
import 'package:tcu_myinfo_app/presentation/t_c_u_myinfo_icon_icons.dart';

class StuLoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StuLoginPageState();
  }
}

class _StuLoginPageState extends State<StuLoginPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("登入"),
        centerTitle: true,
      ),
      body: Form(
        // TODO: key??
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: '學號 Student ID',
                    icon: const Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: const Icon(TCUMyinfoIcon.user),
                    ),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: '密碼 Password',
                    icon: const Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: const Icon(TCUMyinfoIcon.lock),
                    ),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  obscureText: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
