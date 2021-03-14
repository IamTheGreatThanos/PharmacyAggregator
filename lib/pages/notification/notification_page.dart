import 'package:flutter/material.dart';
import 'package:pharmacy_aggregator/components/appBar.dart';
import 'package:pharmacy_aggregator/core/constants.dart';
import 'package:pharmacy_aggregator/models/notification.dart';
import 'package:pharmacy_aggregator/pages/notification/notification_item.dart';
import 'notification_description_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {

  @override
  void initState() {
    super.initState();
    getNotifications();
  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  List<NotificationModel> notificationList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar('Уведомления'),
        backgroundColor: Colors.white,  
        body: RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: _refresh,
          child: ListView.builder(
              itemCount: notificationList.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => NotificationDescriptionPage(item: notificationList[index])));
                    },
                    child: NotificationItem(item: notificationList[index]));
              }),
        ));
  }

  Future<Null> _refresh() async {
    await getNotifications();
    return null;
  }

  getNotifications() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('Token');
    await http.get(
      "${AppConstants.baseUrl}message/",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Accept": "application/json",
          "Authorization": "Token $token"
        },
      ).then((response) {
        print(response.statusCode);
        List<NotificationModel> list = List<NotificationModel>();
        var responseBody = jsonDecode(utf8.decode(response.body.codeUnits));
        print(responseBody);
        for (Object i in responseBody){
          Map<String,dynamic> j = i;
          list.add(NotificationModel('https://ksintez.ru/upload/resize_cache/iblock/2ee/880_750_1/Naftizin.jpg', j['text'], j['title']));
        }
        setState(() {
          notificationList = list;
        });
      }).catchError((error) => print(error));
  }
}
