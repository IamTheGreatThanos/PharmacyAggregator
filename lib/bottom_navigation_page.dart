import 'package:flutter/material.dart';
import 'package:pharmacy_aggregator/components/appBar.dart';
import 'package:pharmacy_aggregator/pages/notification/notification_item.dart';
import 'package:pharmacy_aggregator/pages/authorization/sign_in_page.dart';
import 'core/constants.dart';
import 'pages/home/home_page.dart';
import 'pages/notification/notification_page.dart';
import 'pages/profile/profile_page.dart';
import 'pages/record/record_page.dart';

class BottomNavigationPage extends StatefulWidget {
  @override
  _BottomNavigationPageState createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    HomePage(),
    NotificationPage(),
    RecordPage(),
    ProfilePage()
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: SizedBox(
        height: MediaQuery.of(context).size.width * 0.19,
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          elevation: 15.0,
          iconSize: 17,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white,
          selectedFontSize: 13,
          unselectedFontSize: 11,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
              ),
              label: "Главная",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.notification_important_outlined,
              ),
              label: "Уведомления",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.assignment_rounded,
              ),
              label: "Учет",
            ),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Профиль")
          ],
          onTap: (index) {
            setState(() {
              // if (AppConstants.role)
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
