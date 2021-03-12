import 'package:flutter/material.dart';
import 'package:pharmacy_aggregator/core/constants.dart';
import 'package:pharmacy_aggregator/models/pharmacy.dart';
import 'package:pharmacy_aggregator/pages/medication/medication_description.dart';
import 'package:pharmacy_aggregator/pages/medication/medication_review.dart';
import 'package:pharmacy_aggregator/pages/medication/pharmacy_description.dart';

class PharmacyPage extends StatefulWidget {
  Pharmacy pharmacy;
  PharmacyPage(this.pharmacy);
  @override
  _PharmacyPageState createState() => _PharmacyPageState();
}

class _PharmacyPageState extends State<PharmacyPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 2, child: Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title:  Text("Заказы",
            style: TextStyle(
                color: Colors.black,
                fontFamily: 'Montserrat Regular',
                fontSize: 18)),
        brightness: Brightness.light,
        automaticallyImplyLeading: true,
        backgroundColor: Colors.white,
        shadowColor: Colors.white,

        bottomOpacity: 1,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
          bottom:
          TabBar(
              labelColor: Colors.black45,
              tabs: [
                Tab(text: "Описание", ),
                Tab(text:  "Отзывы"),

              ]),
      ),
      body: new TabBarView(
        children: <Widget>[
          PharmacyDescription(widget.pharmacy),
          MedicationReview() ,
        ],
      ),
      ),
    );
  }
}