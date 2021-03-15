import 'package:flutter/material.dart';
import 'package:pharmacy_aggregator/core/constants.dart';
import 'package:pharmacy_aggregator/models/medication.dart';
import 'package:pharmacy_aggregator/pages/medication/medication_description.dart';
import 'package:pharmacy_aggregator/pages/medication/medication_review.dart';

class MedicationData extends StatefulWidget {
  Medication medication;
  MedicationData(this.medication);
  @override
  _MedicationDataState createState() => _MedicationDataState();
}

class _MedicationDataState extends State<MedicationData> {
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
                Tab(text: "Описание"),
                Tab(text: "Отзывы"),
              ]),
      ),
      body: new TabBarView(
        children: <Widget>[
          MedicationDescription(widget.medication),
          MedicationReview(widget.medication),
        ],
      ),
      ),
    );
  }
}