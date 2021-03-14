import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:pharmacy_aggregator/components/appBar.dart';
import 'package:pharmacy_aggregator/core/constants.dart';
import 'package:pharmacy_aggregator/pages/authorization/sign_in_page.dart';
import 'package:pharmacy_aggregator/utils/utils.dart';

class PasswordRecoveryPage extends StatefulWidget {

  @override
  _PasswordRecoveryPageState createState() => _PasswordRecoveryPageState();
}

class _PasswordRecoveryPageState extends State<PasswordRecoveryPage> {
  TextEditingController loginController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(' '),
      backgroundColor: Colors.white,
      body: Container(child: 
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        Center(child: Image.asset('assets/images/Title.png', width: MediaQuery.of(context).size.width*0.9,)),
        SizedBox(height: 30),
        Container(
          decoration: BoxDecoration(color: Colors.indigo[900], borderRadius: BorderRadius.circular(20)),
          width: MediaQuery.of(context).size.width*0.85,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text('Забыли пароль?', style: TextStyle(color: Colors.white, fontSize: 22, fontFamily: 'Montserrat Regular'),),
                ),
                SizedBox(height: 10),
                Text('Напишите ваш email для сброса пароля. Мы вам отправим ссылку сброса на почту.', style: TextStyle(color: Colors.white, fontSize: 15, fontFamily: 'Montserrat Regular'), textAlign: TextAlign.center,),
                SizedBox(
                  height: 20,
                ),
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
                  SizedBox(
                    height: 20,
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
                                rec(loginController.text)
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
                            "Отправить",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height:20)
                ],),
              ],
            )
          ),
          ),
      ],),),
    );
  }

  void rec(String login) async {
    String jsonString = await recover(login);
    if (jsonString != null){
      Map<String, dynamic> status = jsonDecode(jsonString);
      if (status['status'] == "ok") {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => SignInPage()) //login, password ,
        );
      } else {
        Navigator.pop(context);
        _scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text('Проверьте соединения с интернетом или попробуйте позже!')));
      }
    }
    else{
      Navigator.pop(context);
        _scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text(
          'Неверный логин или пароль!',
        )));
    }
  }

  Future<String> recover(String login) async {
    final response = await http.post(AppConstants.baseUrl + "users/change/password/",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'username': login,
        }));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }
}