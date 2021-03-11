import 'package:flutter/material.dart';
import 'package:pharmacy_aggregator/pages/authorization/sign_in_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'bottom_navigation_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  Future<bool> isRegister() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var isReg = prefs.getBool('isReg');
    return isReg;
  }

  var signPage = SignInPage();
  var navPage = BottomNavigationPage();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.indigo[300],
        canvasColor: Colors.indigo[900],
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FutureBuilder<bool>(
        future: isRegister(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.data == true) {
            return BottomNavigationPage();
          } else {
            return SignInPage();
          }
        },
      ),
    );
  }
}