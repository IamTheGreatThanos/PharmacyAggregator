import 'package:flutter/material.dart';
import 'package:pharmacy_aggregator/components/appBar.dart';

class PharmacyPage extends StatefulWidget {
  @override
  _PharmacyPageState createState() => _PharmacyPageState();
}

class _PharmacyPageState extends State<PharmacyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar("Аптека"),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          child: Column(),
        ),
      ),
    );
    }
}
