import 'package:flutter/material.dart';
import 'package:pharmacy_aggregator/components/appBar.dart';

class MedicationCount extends StatefulWidget {
  @override
  _MedicationCountState createState() => _MedicationCountState();
}

class _MedicationCountState extends State<MedicationCount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar("Мезим форте таб. п/о №80"),
      body: Container(),
    );
  }
}
