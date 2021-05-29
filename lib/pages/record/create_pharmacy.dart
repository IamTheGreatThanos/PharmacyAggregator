import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pharmacy_aggregator/components/appBar.dart';
import 'package:pharmacy_aggregator/core/constants.dart';
import 'package:pharmacy_aggregator/pages/record/pharmacy_page.dart';
import 'package:pharmacy_aggregator/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CreatePharmacy extends StatefulWidget {
  @override
  _CreatePharmacyState createState() => _CreatePharmacyState();
}

class _CreatePharmacyState extends State<CreatePharmacy> {
  TextEditingController nameController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController workingHoursController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar('Создать аптеку'),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(top: 30, left: 5, right: 5),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    controller: nameController,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.black12,
                        hintText: "Название аптеки"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    controller: addressController,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.black12,
                        hintText: "Адрес"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    controller: cityController,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.black12,
                        hintText: "Город"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    controller: phoneController,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.black12,
                        hintText: "Контакт"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    controller: workingHoursController,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.black12,
                        hintText: "Время работы"),
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
                          var isConnected = checkInternetConnection();
                          isConnected.then((value) => {
                                if (value)
                                  {
                                    if (nameController.text.isNotEmpty &&
                                        cityController.text.isNotEmpty &&
                                        addressController.text.isNotEmpty &&
                                        workingHoursController
                                            .text.isNotEmpty &&
                                        phoneController.text.isNotEmpty)
                                      {
                                        create(
                                            nameController.text,
                                            cityController.text,
                                            addressController.text,
                                            workingHoursController.text,
                                            phoneController.text),
                                        createAlertDialog(context)
                                      }
                                    else
                                      {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content:
                                                    Text('Заполните все поля!'))),
                                      }
                                  }
                                else
                                  {
                                    showAlert(
                                        "Внимание",
                                        "У вас нет соединения с интернетом!",
                                        context)
                                  }
                              });
                          FocusScopeNode currentFocus = FocusScope.of(context);

                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        textColor: Colors.white,
                        color: Colors.amber[600],
                        elevation: 3.0,
                        child: Text(
                          "Отправить",
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
        ));
  }

  void create(String name, String city, String address, String workingHours,
      String phone) async {
    String jsonString =
        await createPharm(name, city, address, workingHours, phone);
    Map<String, dynamic> status = jsonDecode(jsonString);
    // print(status['status']);

    if (status['status'] == "ok") {
      print("status ok");
      Navigator.pop(context);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) =>
                  PharmacyPage()) //login, password ,
          );
    } else {
      Navigator.pop(context);
      _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text(
        'Проверьте соединения с интернетом или попробуйте позже!',
      )));
      // print("status no ok");
    }
  }


  Future<String> createPharm(String name, String city, String address,
      String workingHours, String phone) async {
    var sharedPreferences=await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('Token');
    final response =
        await http.post(AppConstants.baseUrl + "/product/pharmacy/create/",
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              "Accept": "application/json",
              "Authorization": "Token $token"
            },
            body: jsonEncode(<String, String>{
              'name': name,
              "address": address,
              "city": city,
              "phone": phone,
              "working_hours": workingHours
            }));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception("Falied to create pharmacy");
    }
  }
}
