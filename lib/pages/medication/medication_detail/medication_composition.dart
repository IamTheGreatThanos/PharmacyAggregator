import 'package:flutter/material.dart';
import 'package:pharmacy_aggregator/components/appBar.dart';
import 'package:pharmacy_aggregator/core/constants.dart';

class MedicationComposition extends StatefulWidget {
  @override
  _MedicationCompositionState createState() => _MedicationCompositionState();
}

class _MedicationCompositionState extends State<MedicationComposition> {

  String word = "Одна таблетка содержит активное вещество - панкреатин** (с минимальной активностью липазы 3 500 ЕД ЕФ, амилазы 4 200 ЕД ЕФ, с минимальной общей активностью протеазы 250 ЕД ЕФ)   вспомогательные вещества: целлюлоза микрокристаллическая, натрия крахмала гликолят (тип А), кремния диоксид коллоидный безводный, магния стеарат,   состав оболочки: полиакрилата 30 % дисперсия в пересчете на сухое вещество, тальк, гипромеллоза, азорубиновый лак (Е 122), эмульсия симетикона, титана диоксид (Е 171), макрогол 6000.   ** - панкреатин (порошок поджелудочных желез)";
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
              Text(word,
                style: TextStyle(fontFamily: AppFonts.montesseratRegular, fontSize: 16),),
            ],
          ),
        ),
      ),
    );
  }
}


