import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy_aggregator/components/appBar.dart';
import 'package:pharmacy_aggregator/core/constants.dart';
import 'package:pharmacy_aggregator/models/pharmacy_model.dart';
import 'package:pharmacy_aggregator/pages/authorization/sign_in_page.dart';
import 'package:pharmacy_aggregator/pages/home/home_page.dart';
import 'package:pharmacy_aggregator/pages/profile/settings_page.dart';
import 'package:pharmacy_aggregator/pages/profile/support_page.dart';
import 'package:pharmacy_aggregator/pages/record/create_pharmacy.dart';
import 'package:pharmacy_aggregator/pages/record/pharmacy_page.dart';
import 'package:pharmacy_aggregator/pages/record/record_page.dart';
import 'package:pharmacy_aggregator/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'edit_profile_page.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var menu = [
    'Зайти в аптеку',
    'Редактировать профиль',
    'Служба поддержки',
    'Настройки',
    'Выход'
  ];
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var imgURL = "";

  @override
  void initState() {
    getProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width / 3.7;

    return Scaffold(
      appBar: buildAppBar('Мой профиль'),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                  child: Image.asset(
                'assets/images/Title.png',
                width: MediaQuery.of(context).size.width * 0.8,
              )),
              Center(child: Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Image.network(imgURL,
                    height: 100,
                    width: MediaQuery.of(context).size.width * 0.3),
              ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.indigo[900],
                    borderRadius: BorderRadius.circular(20)),
                width: MediaQuery.of(context).size.width * 0.85,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 5,
                      itemBuilder: (_, index) {
                        return Container(
                          margin: EdgeInsets.only(bottom: 2.5),
                          child: ListTile(
                            title: Text(menu[index],
                                style:
                                    TextStyle(fontSize: 18, color: Colors.white)),
                            trailing: Icon(
                              Icons.keyboard_arrow_right_outlined,
                              color: Colors.white,
                            ),
                            // tileColor: Colors.white,
                            onTap: () async {
                              // if (isReg == true) {
                              if (index == 0) {
                                checkFramCreated();
                              } else if (index == 1) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EditProfilePage()));
                              } else if (index == 2) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SupportPage()));
                              } else if (index == 3) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SettingsPage()));
                              } else if (index == 4) {
                                quit();
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => SignInPage()),
                                    (Route<dynamic> route) => false);
                              }
                            },
                          ),
                        );
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> isHaveFarm() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool isHave = sharedPreferences.getBool(AppConstants.isHaveFarm);
    if (isHave == null) {
      return false;
    }
    return isHave;
  }

  quit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    // prefs.setBool('isReg', false);
  }

  void getProfile() async {
    var token = await getToken();
    var response =
        await http.get(AppConstants.baseUrl + "product/pharmacy/get", headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      "Accept": "application/json",
      "Authorization": "Token $token"
    });

    if (response.statusCode == 200) {
      var model = PharmacyModel.fromJson(jsonDecode(response.body));
    // print("asdlkamsmdjlaskdjlaks");
      setState(() {
        imgURL = AppConstants.baseUrl + model.photo;
        // print(imgURL);
      });
    } else {
      print(response.statusCode);
      //     Navigator.pop(context);
      // _scaffoldKey.currentState.showSnackBar(SnackBar(
      //     content: Text(
      //   'Проверьте соединения с интернетом или попробуйте позже!',
      // )));
    }
  }

  void checkFramCreated() async {
    var token = await getToken();
    var response = await http
        .get(AppConstants.baseUrl + "product/pharmacy/check", headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      "Accept": "application/json",
      "Authorization": "Token $token"
    });

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (json["status"] == "true") {
        print("status true");
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => RecordPage()));
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => CreatePharmacy()));
      }
    } else {
      print(response.statusCode);
      //     Navigator.pop(context);
      // _scaffoldKey.currentState.showSnackBar(SnackBar(
      //     content: Text(
      //   'Проверьте соединения с интернетом или попробуйте позже!',
      // )));
    }
  }
}
