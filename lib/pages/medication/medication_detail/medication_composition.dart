import 'package:flutter/material.dart';
import 'package:pharmacy_aggregator/components/appBar.dart';

class MedicationComposition extends StatefulWidget {
  @override
  _MedicationCompositionState createState() => _MedicationCompositionState();
}

class _MedicationCompositionState extends State<MedicationComposition> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar("Описание"),
      body: Container(),
    );
  }
}
