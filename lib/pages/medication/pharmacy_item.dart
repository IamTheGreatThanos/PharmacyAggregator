import 'package:flutter/material.dart';
import 'package:pharmacy_aggregator/core/constants.dart';
import 'package:pharmacy_aggregator/models/pharmacy_search_model.dart';

class PharmacyItem extends StatelessWidget {
  final PharmacySearch item;

  PharmacyItem({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      height: MediaQuery.of(context).size.width / 3.2,

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            'https://ksintez.ru/upload/resize_cache/iblock/2ee/880_750_1/Naftizin.jpg',
            width: MediaQuery.of(context).size.width / 3,
            height: MediaQuery.of(context).size.width / 3,
          ),
          Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  item.name,
                  maxLines: 1,
                  style: TextStyle(
                      fontFamily: AppFonts.montesseratSemiBold, fontSize: 16),
                  overflow: TextOverflow.clip,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    item.address,
                    style: TextStyle(
                      fontFamily: AppFonts.montesseratMedium,
                    ),
                    softWrap: true,
                    maxLines: 3,
                    overflow: TextOverflow.clip,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(item.phone),
                      // Text(item.isHave ? "Есть в наличие" : "Нет в наличии",style: TextStyle(color: Colors.red),)
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),

    );
  }
}