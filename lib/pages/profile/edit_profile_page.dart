import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:pharmacy_aggregator/components/appBar.dart';
import 'package:pharmacy_aggregator/core/constants.dart';
import 'package:pharmacy_aggregator/pages/authorization/sign_in_page.dart';
import 'package:pharmacy_aggregator/utils/utils.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController loginController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController adressController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar('Редактировать'),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(child: Image.asset('assets/images/_ 2.png', width: MediaQuery.of(context).size.width*0.4,)),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                  child: Text('Почта', style: TextStyle(color: Colors.black, fontSize: 18, fontFamily: 'Montserrat Regular', fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    controller: emailController,
                    decoration: InputDecoration(
                      filled: true, 
                      fillColor: Colors.black12
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                  child: Text('Логин', style: TextStyle(color: Colors.black, fontSize: 18, fontFamily: 'Montserrat Regular', fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    controller: loginController,
                    decoration: InputDecoration(
                      filled: true, 
                      fillColor: Colors.black12
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                  child: Text('Адрес', style: TextStyle(color: Colors.black, fontSize: 18, fontFamily: 'Montserrat Regular', fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    controller: adressController,
                    decoration: InputDecoration(
                      filled: true, 
                      fillColor: Colors.black12
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Center(
                      child: ButtonTheme(
                        minWidth: 200,
                        height: 50,
                        child:
                        RaisedButton(
                          onPressed: () {
                            var isConnected = checkInternetConnection();
                            isConnected.then((value) => {
                              if (value){
                                createAlertDialog(context),
                                change(loginController.text)
                              }
                              else{
                                showAlert(
                                  "Внимание",
                                  "У вас нет соединения с интернетом!",
                                  context)
                              }
                            });
                            FocusScopeNode currentFocus =
                                FocusScope.of(context);
                            if (!currentFocus.hasPrimaryFocus) {
                              currentFocus.unfocus();
                            }
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          textColor: Colors.white,
                          color: Colors.amber[600],
                          elevation: 3.0,
                          child: Text(
                            "Подтвердить",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              ]
            ),
          )
      ],)
    );
  }

  void change(String login) async {
    String jsonString = await changeProfile(
      login
    );
    Map<String, dynamic> status = jsonDecode(jsonString);
    // print(status['status']);

    if (status['status'] == "ok") {
      // print("status ok");
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => SignInPage()) //login, password ,
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

  Future<String> changeProfile(String login) async {
    final response = await http.post(AppConstants.baseUrl + "users/phone/",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'login': login,
        }));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception("Falied to registration");
    }
  }
}