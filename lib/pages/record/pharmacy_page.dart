import 'package:flutter/material.dart';
import 'package:pharmacy_aggregator/components/appBar.dart';
import 'package:pharmacy_aggregator/pages/record/create_medicine.dart';
import 'package:pharmacy_aggregator/pages/record/create_pharmacy.dart';
import 'package:pharmacy_aggregator/pages/record/record_page.dart';

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
      body:
         Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: Center(
                  child: ButtonTheme(
                    minWidth: 200,
                    height: 50,
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                            builder: (context) => RecordPage()));
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      textColor: Colors.white,
                      color: Colors.indigo[600],
                      elevation: 3.0,
                      child: Text(
                        "Учет",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Center(
                  child: ButtonTheme(
                    minWidth: 200,
                    height: 50,
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CreateMedicine()));
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      textColor: Colors.white,
                      color: Colors.indigo[600],
                      elevation: 3.0,
                      child: Text(
                        "Создать товары",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
          ),
        ),

    );
    }

}
