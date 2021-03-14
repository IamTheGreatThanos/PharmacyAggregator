import 'package:flutter/material.dart';
import 'package:pharmacy_aggregator/components/appBar.dart';
import 'package:pharmacy_aggregator/core/constants.dart';
import 'package:pharmacy_aggregator/pages/authorization/sign_in_page.dart';
import 'package:pharmacy_aggregator/pages/profile/settings_page.dart';
import 'package:pharmacy_aggregator/pages/profile/support_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'edit_profile_page.dart';

class ProfilePage extends StatefulWidget {

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var menu = ['Авторизация','Редактировать профиль','Служба поддержки','Настройки','Выход'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar('Мой профиль'),
      backgroundColor: Colors.white,
      body: Container(child: 
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        Center(child: Image.asset('assets/images/Title.png', width: MediaQuery.of(context).size.width*0.8,)),
        Image.asset('assets/images/_ 2.png', width: MediaQuery.of(context).size.width*0.4,),
        SizedBox(height: 20),
        Container(
          decoration: BoxDecoration(color: Colors.indigo[900], borderRadius: BorderRadius.circular(20)),
          width: MediaQuery.of(context).size.width*0.85,
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
                          style: TextStyle(fontSize: 18, color: Colors.white)),
                      trailing: Icon(Icons.keyboard_arrow_right_outlined, color: Colors.white,),
                      // tileColor: Colors.white,
                      onTap: () {
                        // if (isReg == true) {
                          if (index == 0) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignInPage()),
                            );
                          } else if (index == 1) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditProfilePage()));
                          } else if (index == 2) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>  SupportPage()));
                          } else if (index == 3) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>  SettingsPage()));
                          } else if (index == 4) {
                            quit();
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (context) => SignInPage()), (Route<dynamic> route) => false);
                          }
                      },
                    ),
                  );
                }),
          ),
          ),
      ],),),
    );
  }

  quit() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isReg', false);
  }
}
