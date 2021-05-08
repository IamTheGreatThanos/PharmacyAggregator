import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy_aggregator/core/constants.dart';
import 'package:pharmacy_aggregator/models/medication.dart';

class MedicationItem extends StatelessWidget {
  final Medication item;

  MedicationItem({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      height: MediaQuery.of(context).size.width / 3.2,

        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: item.img,
              imageBuilder: (context, imageProvider) => Container(
                width: MediaQuery.of(context).size.width / 3,
                height: MediaQuery.of(context).size.width / 3,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                      colorFilter:
                          ColorFilter.mode(Colors.red, BlendMode.colorBurn)),
                ),
              ),
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error, size: MediaQuery.of(context).size.width / 3,),
            ),
            // CachedNetworkImage(
            //   imageUrl: item.img,
            //   placeholder: (context, url) => new CircularProgressIndicator(),
            //   errorWidget: (context, url, error) => new Icon(Icons.error),
            //   width: MediaQuery.of(context).size.width / 3,
            //   height: MediaQuery.of(context).size.width / 3,
            // ),
            // Image.network(
            //   item.img,
            //   width: MediaQuery.of(context).size.width / 3,
            //   height: MediaQuery.of(context).size.width / 3,
            // ),
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
                      item.description,
                      style: TextStyle(
                        fontFamily: AppFonts.montesseratMedium,
                      ),
                      softWrap: true,
                      maxLines: 3,
                      overflow: TextOverflow.clip,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(item.price),
                        Text(item.isHave ? "Есть в наличие" : "Нет в наличии",style: TextStyle(color: Colors.red),)
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
