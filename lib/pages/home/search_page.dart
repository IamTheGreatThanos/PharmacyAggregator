import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pharmacy_aggregator/components/appBar.dart';
import 'package:flutter/services.dart';
import 'package:pharmacy_aggregator/core/constants.dart';
import 'package:pharmacy_aggregator/models/medication.dart';
import 'package:pharmacy_aggregator/models/notification.dart';
import 'package:pharmacy_aggregator/models/pharmacy.dart';
import 'package:pharmacy_aggregator/models/pharmacy_search_model.dart';
import 'package:pharmacy_aggregator/pages/medication/medication_data.dart';
import 'package:pharmacy_aggregator/pages/medication/medication_item.dart';
import 'package:pharmacy_aggregator/pages/medication/pharmacy_item.dart';
import 'package:pharmacy_aggregator/pages/medication/pharmacy_page.dart';
import 'package:pharmacy_aggregator/pages/medication/pharmacy_search_page.dart';
import 'package:pharmacy_aggregator/pages/notification/notification_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = new TextEditingController();
  FocusNode focusNode;
  var isCheckMed = true;

  List<Medication> medicationList = [];
  List<PharmacySearch> pharmacyList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    focusNode = FocusNode();
    focusNode.requestFocus();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    focusNode.unfocus();
    focusNode.dispose();
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar('Поиск лекарств'),
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          children: [
            TextField(
              onSubmitted: (value) {
                if (!isCheckMed) {
                  getProjectDetails(value);
                } else {
                  getProjectDetailsApteca(value);
                }
              },
              focusNode: focusNode,
              controller: _searchController,
              cursorColor: Colors.indigo[300],
              decoration: InputDecoration(
                hintText: "Введите название лекарства",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hoverColor: Colors.indigo,
                suffixIcon: Icon(Icons.search),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0, horizontal: 8),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RaisedButton(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.1),
                    onPressed: () {
                      setState(() {
                        isCheckMed = false;
                      });
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Text(
                      "Лекарство",
                      style: TextStyle(
                          fontFamily: AppFonts.montesseratRegular,
                          color: isCheckMed ? Colors.black : Colors.white),
                    ),
                    color: isCheckMed ? Colors.white : Colors.indigo[900],
                  ),
                  RaisedButton(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.12),
                    onPressed: () {
                      setState(() {
                        isCheckMed = true;
                      });
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Text(
                      "Аптека",
                      style: TextStyle(
                          fontFamily: AppFonts.montesseratRegular,
                          color: isCheckMed ? Colors.white : Colors.black),
                    ),
                    color: isCheckMed ? Colors.indigo[900] : Colors.white,
                  ),
                ],
              ),
            ),
            Flexible(
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount:
                      isCheckMed ? pharmacyList.length : medicationList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => isCheckMed
                                      ? PharmacySearchPage(pharmacyList[index])
                                      : MedicationData(medicationList[index])));
                        },
                        child: isCheckMed
                            ? PharmacyItem(item: pharmacyList[index])
                            : MedicationItem(item: medicationList[index]));
                  }),
            )
          ],
        ),
      ),
    );
  }

  getProjectDetails(word) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('Token');
    await http.get(
      "${AppConstants.baseUrl}product/?search=$word",
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

      for (Object i in responseBody) {
        Map<String, dynamic> j = i;
        list.add(Medication(
            j['name'],
            j['manufacturer']['name'],
            'https://ksintez.ru/upload/resize_cache/iblock/2ee/880_750_1/Naftizin.jpg',
            j['description'],
            'от ' + j['available'][0]['price'].toString() + 'тг.',
            true,
            j['composition'],
            j['available']));
      }
      setState(() {
        medicationList = list;
      });
    }).catchError((error) => print(error));
  }

  getProjectDetailsApteca(word) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('Token');
    await http.get(
      "${AppConstants.baseUrl}product/pharmacy/?search=$word",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Accept": "application/json",
        "Authorization": "Token $token"
      },
    ).then((response) {
      print(response.statusCode);
      List<PharmacySearch> list = List<PharmacySearch>();
      var responseBody = jsonDecode(utf8.decode(response.body.codeUnits));
      print("asdasd");
      print(responseBody);
      for (Object i in responseBody) {
        var item = PharmacySearch.fromJson(i);
        print("aa");
        list.add(item);
      }

      print(list.length);
      setState(() {
        pharmacyList = list;
      });
    }).catchError((error) => print(error));
  }
}

// j['photo']
