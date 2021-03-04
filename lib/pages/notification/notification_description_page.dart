import 'package:flutter/material.dart';
import 'package:pharmacy_aggregator/components/appBar.dart';
import 'package:pharmacy_aggregator/core/constants.dart';
import 'package:pharmacy_aggregator/model/notification.dart';

class NotificationDescriptionPage extends StatelessWidget {

  final NotificationModel item;

  NotificationDescriptionPage({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar('Описание'),
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(item.img),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(item.title, style: TextStyle(fontFamily: AppFonts.montesseratSemiBold, fontSize: 16),),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(item.description, textAlign: TextAlign.center, style: TextStyle(fontSize: 14),),
            )
          ],
        ),
      ),
    );
  }
}
