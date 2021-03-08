import 'package:flutter/material.dart';
import 'package:pharmacy_aggregator/components/appBar.dart';
import 'package:pharmacy_aggregator/models/medication.dart';
import 'package:pharmacy_aggregator/pages/medication/medication_data.dart';

import 'package:pharmacy_aggregator/pages/medication/medication_item.dart';

class MedicationPage extends StatefulWidget {
  @override
  _MedicationPageState createState() => _MedicationPageState();
}

class _MedicationPageState extends State<MedicationPage> {

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  new GlobalKey<RefreshIndicatorState>();

  List<Medication> medicationList = [
   Medication(   "https://ksintez.ru/upload/resize_cache/iblock/2ee/880_750_1/Naftizin.jpg",
      "Berlin-Chemie","Мезим форте таб. п/о №80", "от 565 тг", false),
    Medication(   "https://ksintez.ru/upload/resize_cache/iblock/2ee/880_750_1/Naftizin.jpg",
        "Berlin-Chemie","Мезим форте таб. п/о №80", "от 565 тг", false),
    Medication(   "https://ksintez.ru/upload/resize_cache/iblock/2ee/880_750_1/Naftizin.jpg",
        "Berlin-Chemie","Мезим форте таб. п/о №80", "от 565 тг", true),
    Medication(   "https://ksintez.ru/upload/resize_cache/iblock/2ee/880_750_1/Naftizin.jpg",
        "Berlin-Chemie","Мезим форте таб. п/о №80", "от 565 тг", false),
    Medication(   "https://ksintez.ru/upload/resize_cache/iblock/2ee/880_750_1/Naftizin.jpg",
        "Berlin-Chemie","Мезим форте таб. п/о №80", "от 565 тг", true),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar('Лекарственные препараты'),
      backgroundColor: Colors.white,
      // backgroundColor: Colors.deepPurpleAccent[100],
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refresh,
        child: ListView.builder(
            itemCount: medicationList.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MedicationData()));
                  },
                  child: MedicationItem(item: medicationList[index]));
            }),
      )
    );
  }

  Future<Null> _refresh() async {
    return null;
  }
}
