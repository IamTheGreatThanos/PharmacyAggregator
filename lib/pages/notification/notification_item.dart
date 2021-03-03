import 'package:flutter/material.dart';
import 'package:pharmacy_aggregator/core/constants.dart';
import 'package:pharmacy_aggregator/model/notification.dart';

class NotificationItem extends StatelessWidget {

  final NotificationModel item;

  NotificationItem({Key key, this.item }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      height:  MediaQuery.of(context).size.width/3,
      child: Row(
        children: [
          Image.network(item.img, width: MediaQuery.of(context).size.width/3, height: MediaQuery.of(context).size.width/3,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item.title, style: TextStyle(fontFamily: AppFonts.montesseratSemiBold, fontSize: 16),overflow: TextOverflow.clip,),
              Flexible(
                child: Column(
                  children: [
                    Text(item.description,style: TextStyle(fontFamily: AppFonts.montesseratMedium,), softWrap: true,),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
