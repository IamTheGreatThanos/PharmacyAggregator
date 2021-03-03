import 'package:flutter/material.dart';
import 'package:pharmacy_aggregator/components/appBar.dart';
import 'package:pharmacy_aggregator/model/notification.dart';
import 'package:pharmacy_aggregator/pages/notification/notification_item.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  List<NotificationModel> notificationList = [
    NotificationModel(
        "https://ksintez.ru/upload/resize_cache/iblock/2ee/880_750_1/Naftizin.jpg",
        "У вас заканчивается количество лекарств. Необходимо закупить лекарства из этого списка.",
        "Необходимость закупки лекарств")
  ];

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
                return NotificationItem(item: notificationList[index]);
              }),
        ));
  }

  Future<Null> _refresh() async {
    return null;
  }
}
