import 'package:flutter/material.dart';
import 'package:pharmacy_aggregator/components/appBar.dart';
import 'package:pharmacy_aggregator/core/constants.dart';

class SignInPage extends StatefulWidget {

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  var menu = ['Авторизация','Редактировать профиль','Служба поддержки','Настройки','Выход'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar('Авторизация'),
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
                Text('Добро пожаловать', style: TextStyle(color: Colors.white, fontSize: 22, fontFamily: 'Montserrat Regular'),),
                SizedBox(height: 10),
                GestureDetector(
                  child: Text('Добро пожаловать', style: TextStyle(color: Colors.white, fontSize: 14, fontFamily: 'Montserrat Regular', decoration: TextDecoration.underline), ),
                  onTap: (){
                    print('Tapped');
                  },
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Text('Login', style: TextStyle(color: Colors.white, fontSize: 16, fontFamily: 'Montserrat Regular')),
                  TextField(
                    
                  )
                ],),
                
                
              ],
            )
          ),
          ),
      ],),),
    );
  }
}
