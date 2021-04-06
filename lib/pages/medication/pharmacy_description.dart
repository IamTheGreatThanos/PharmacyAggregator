import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy_aggregator/core/constants.dart';
import 'package:pharmacy_aggregator/models/medication.dart';
import 'package:pharmacy_aggregator/models/pharmacy.dart';
import 'package:pharmacy_aggregator/pages/medication/medication_detail/medication_composition.dart';
import 'package:pharmacy_aggregator/pages/medication/medication_detail/medication_count.dart';
import 'package:pharmacy_aggregator/pages/medication/medication_detail/medication_feature.dart';

// ignore: must_be_immutable
class PharmacyDescription extends StatefulWidget {
  Pharmacy pharmacy;
  PharmacyDescription(this.pharmacy);
  @override
  _PharmacyDescriptionState createState() => _PharmacyDescriptionState();
}

class _PharmacyDescriptionState extends State<PharmacyDescription> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Image.network(
                  widget.pharmacy.pharmacy['photo'],
                  width: MediaQuery.of(context).size.width / 3,
                  height: MediaQuery.of(context).size.width / 3,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, left: 4, right: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      getTitle("Название"),
                      getText(widget.pharmacy.pharmacy['name']),
                      getTitle("Город"),
                      getText(widget.pharmacy.pharmacy['city']),
                      getTitle("Адрес"),
                      getText(widget.pharmacy.pharmacy['address']),
                      getTitle("Телефон"),
                      getText(widget.pharmacy.pharmacy['phone']),
                      getTitle("Часы работы"),
                      getText(widget.pharmacy.pharmacy['working_hours']),
                    ],
                  ),
                ),
              ],
            ),
          ),
      ),
      
    );
  }

  Widget getTitle(String title) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(15, 5, 0, 0),
        child: Text(
          title,
          style: TextStyle(fontSize: 15, fontFamily: AppFonts.montesseratSemiBold,color: Colors.black),
        ));
  }

  Widget getText(String text) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 2, 15, 5),
      child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.black, width: 0.5))
            // borderRadius: BorderRadius.circular(8),
               ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 13, 0, 6),
            child:  Text(text, style: TextStyle(color: Colors.black45, fontSize: 14)),
          )),
    );
  }
}
