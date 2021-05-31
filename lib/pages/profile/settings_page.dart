import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:pharmacy_aggregator/components/appBar.dart';
import 'package:pharmacy_aggregator/core/constants.dart';
import 'package:pharmacy_aggregator/pages/authorization/sign_in_page.dart';
import 'package:pharmacy_aggregator/utils/utils.dart';
import 'package:app_settings/app_settings.dart';
// import 'package:permission_handler/permission_handler.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  var menu = ['Авторизация','Редактировать профиль','Служба поддержки','Настройки','Выход'];
  TextEditingController nameController = TextEditingController();
  TextEditingController textController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool isSwitched = false;
  bool isSwitched2 = false;

  @override
  void initState() {
    // check();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar('Настройки'),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(child: Image.asset('assets/images/_ 2.png', width: MediaQuery.of(context).size.width*0.4,)),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical:10),
                  child: Row(children: [
                    Text('Отпечаток пальцев:', style: TextStyle(color: Colors.black, fontSize: 18, fontFamily: 'Montserrat Regular', fontWeight: FontWeight.bold)),
                    Switch(
                      value: isSwitched,
                      onChanged: (value) {
                        setState(() {
                          isSwitched = value;
                        });
                      },
                      activeTrackColor: Colors.red,
                      activeColor: Colors.redAccent,
                    ),
                  ],),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(children: [
                    Text('Уведомления:', style: TextStyle(color: Colors.black, fontSize: 18, fontFamily: 'Montserrat Regular', fontWeight: FontWeight.bold)),
                    Switch(
                      value: isSwitched2,
                      onChanged: (value) {
                        AppSettings.openNotificationSettings();
                        setState(() {
                          isSwitched2 = value;
                        });
                      },
                      activeTrackColor: Colors.red,
                      activeColor: Colors.redAccent,
                    ),
                  ],),
                )
              ]
            )
          )
        ]
      ),
    );
  }

  // void check() async {
  //   print("asdasdasd");
  //   var status = await Permission.notification.status;
  //   if (status.isGranted) {
  //     print("asdasd");
  //     setState(() {
  //       isSwitched2 = true;
  //     });
  //
  //   }
  //   else {
  //     setState(() {
  //       isSwitched = false;
  //     });
  //
  //   }
  // }
}