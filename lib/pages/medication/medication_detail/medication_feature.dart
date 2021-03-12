import 'package:flutter/material.dart';
import 'package:pharmacy_aggregator/components/appBar.dart';
import 'package:pharmacy_aggregator/core/constants.dart';
import 'package:pharmacy_aggregator/models/medication.dart';

class MedicationFeature extends StatefulWidget {
  String desc;
  MedicationFeature(this.desc);
  @override
  _MedicationFeatureState createState() => _MedicationFeatureState();
}

class _MedicationFeatureState extends State<MedicationFeature> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar("Описание"),
      body: SingleChildScrollView(
        child: Container(
          padding:EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Характеристика", style: TextStyle(fontFamily: AppFonts.montesseratSemiBold, fontSize: 18),),
              Padding(
                padding: EdgeInsets.symmetric( vertical: 15),
                child: Text(widget.desc,
                style: TextStyle(fontFamily: AppFonts.montesseratRegular, fontSize: 16),),
              ),
              Text("Срок хранения", style: TextStyle(fontFamily: AppFonts.montesseratSemiBold, fontSize: 18),),
              Padding(
                padding: EdgeInsets.symmetric( vertical: 15),
                child: Text("3 года Не применять по истечении срока годности",
                  style: TextStyle(fontFamily: AppFonts.montesseratRegular, fontSize: 16),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
