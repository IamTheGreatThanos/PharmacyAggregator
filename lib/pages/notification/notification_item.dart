import 'package:flutter/material.dart';
import 'package:pharmacy_aggregator/core/constants.dart';
import 'package:pharmacy_aggregator/models/notification.dart';

class NotificationItem extends StatelessWidget {
  final NotificationModel item;

  NotificationItem({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      height: MediaQuery.of(context).size.width / 3,
      // child: Flexible(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              item.img,
              width: MediaQuery.of(context).size.width / 3,
              height: MediaQuery.of(context).size.width / 3,
            ),
            Flexible(
               // fit: FlexFit.tight,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    item.title,
                    style: TextStyle(
                        fontFamily: AppFonts.montesseratSemiBold, fontSize: 16),
                    overflow: TextOverflow.clip,
                  ),
                  Text(
                    item.description,
                    style: TextStyle(
                      fontFamily: AppFonts.montesseratMedium,
                    ),
                    softWrap: true,
                    maxLines: 3,
                    overflow: TextOverflow.clip,
                  ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.end,
                    //   children: [
                    //     Padding(
                    //       padding: const EdgeInsets.only(right: 16,top: 6),
                    //       child: RaisedButton(onPressed: () {},color: AppColors.mainColor,
                    //         shape: Shap,
                    //       child: Text("подробнее", style: TextStyle(color: Colors.white),),),
                    //     ),
                    //   ],
                    // )

                ],
              ),
            )
          ],
        ),
      // ),
    );
  }
}
