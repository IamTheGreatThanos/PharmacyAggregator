import 'package:flutter/material.dart';
import 'package:pharmacy_aggregator/components/appBar.dart';

class MedicationFeature extends StatefulWidget {
  @override
  _MedicationFeatureState createState() => _MedicationFeatureState();
}

class _MedicationFeatureState extends State<MedicationFeature> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar("Состав"),
      body: Container(),
    );
  }
}
