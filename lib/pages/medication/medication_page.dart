import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pharmacy_aggregator/components/appBar.dart';
import 'package:pharmacy_aggregator/core/constants.dart';
import 'package:pharmacy_aggregator/models/medication.dart';
import 'package:pharmacy_aggregator/pages/medication/medication_data.dart';
import 'package:http/http.dart' as http;
import 'package:pharmacy_aggregator/pages/medication/medication_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MedicationPage extends StatefulWidget {
  final int index;
  MedicationPage(this.index);
  @override
  _MedicationPageState createState() => _MedicationPageState();
}

class _MedicationPageState extends State<MedicationPage> {

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  new GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    getProducts();
  }

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
    await getProducts();
    return null;
  }

  getProducts() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('Token');
    await http.get(
      "${AppConstants.baseUrl}product/?category=${widget.index}",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Accept": "application/json",
          "Authorization": "Token $token"
        },
      ).then((response) {
        print(response.statusCode);
        List<Medication> list = List<Medication>();
        var responseBody = jsonDecode(utf8.decode(response.body.codeUnits));
        print(responseBody);
        for (Object i in responseBody){
          Map<String,dynamic> j = i;
          list.add(Medication(j['photo'], j['manufacturer']['name'], j['name'],'от ' + j['available'][0]['price'].toString() + 'тг.', true));
        }
        setState(() {
          medicationList = list;
        });
      }).catchError((error) => print(error));
  }
}
