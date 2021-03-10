import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:pharmacy_aggregator/components/appBar.dart';
import 'package:pharmacy_aggregator/core/constants.dart';
import 'package:pharmacy_aggregator/pages/authorization/password_recovery_page.dart';
import 'package:pharmacy_aggregator/utils/utils.dart';

class SignUpPage extends StatefulWidget {

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController loginController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar('Регистрация'),
      backgroundColor: Colors.white,
      body: Container(child: 
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        Center(child: Image.asset('assets/images/Title.png', width: MediaQuery.of(context).size.width*0.9,)),
        SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(color: Colors.indigo[900], borderRadius: BorderRadius.circular(20)),
          width: MediaQuery.of(context).size.width*0.85,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                SizedBox(height: 20),
                Text('Добро пожаловать', style: TextStyle(color: Colors.white, fontSize: 22, fontFamily: 'Montserrat Regular'),),
                SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text('Login', style: TextStyle(color: Colors.white, fontSize: 16, fontFamily: 'Montserrat Regular')),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      controller: loginController,
                      decoration: InputDecoration(
                        filled: true, 
                        fillColor: Colors.white
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text('Email', style: TextStyle(color: Colors.white, fontSize: 16, fontFamily: 'Montserrat Regular')),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      controller: emailController,
                      decoration: InputDecoration(
                        filled: true, 
                        fillColor: Colors.white
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text('Password', style: TextStyle(color: Colors.white, fontSize: 16, fontFamily: 'Montserrat Regular')),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      controller: passwordController,
                      decoration: InputDecoration(
                        filled: true, 
                        fillColor: Colors.white
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
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
                                reg(loginController.text, emailController.text,
                                    passwordController.text.trim())
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
                          color: Colors.amber[300],
                          elevation: 3.0,
                          child: Text(
                            "SIGN UP",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],),
              ],
            )
          ),
          ),
      ],),),
    );
  }

  void reg(String login, String email, String password) async {
    String jsonString = await registration(
      login,
      email,
      password,
    );
    Map<String, dynamic> status = jsonDecode(jsonString);
    // print(status['status']);

    if (status['status'] == "ok") {
      // print("status ok");
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => SignUpPage()) //login, password ,
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

  Future<String> registration(String login,String email, String password) async {
    final response = await http.post(AppConstants.baseUrl + "users/register/",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'username': login,
          'email': email,
          'password': password,
        }));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception("Falied to registration");
    }
  }
}
