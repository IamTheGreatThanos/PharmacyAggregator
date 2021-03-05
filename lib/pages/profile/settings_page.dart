import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:pharmacy_aggregator/components/appBar.dart';
import 'package:pharmacy_aggregator/core/constants.dart';
import 'package:pharmacy_aggregator/pages/authorization/sign_in_page.dart';
import 'package:pharmacy_aggregator/utils/utils.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  var menu = ['Авторизация','Редактировать профиль','Служба поддержки','Настройки','Выход'];
  TextEditingController nameController = TextEditingController();
  TextEditingController textController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
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
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                  child: Text('Подтверждение подписи:', style: TextStyle(color: Colors.black, fontSize: 18, fontFamily: 'Montserrat Regular', fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                  child: Text('Вход:', style: TextStyle(color: Colors.black, fontSize: 18, fontFamily: 'Montserrat Regular', fontWeight: FontWeight.bold)),
                ),
              ]
            )
          )
        ]
      ),
    );
  }
}