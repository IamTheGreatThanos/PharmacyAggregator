import 'package:flutter/material.dart';
import 'package:pharmacy_aggregator/components/appBar.dart';
import 'package:pharmacy_aggregator/core/constants.dart';

class MedicationComposition extends StatefulWidget {
  String compo;
  MedicationComposition(this.compo);
  @override
  _MedicationCompositionState createState() => _MedicationCompositionState();
}

class _MedicationCompositionState extends State<MedicationComposition> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar("Состав"),
      body:SingleChildScrollView(
        child: Container(
          padding:EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.compo,
                style: TextStyle(fontFamily: AppFonts.montesseratRegular, fontSize: 16),),
            ],
          ),
        ),
      ),
    );
  }
}


