import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pharmacy_aggregator/core/constants.dart';
import 'package:pharmacy_aggregator/pages/authorization/sign_in_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'bottom_navigation_page.dart';




void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.


  final FirebaseMessaging _firebaseMessaging =  FirebaseMessaging();
  FlutterLocalNotificationsPlugin localNotificationsPlugin;
  AndroidInitializationSettings androidInitializationSettings = new AndroidInitializationSettings('@mipmap/ic_launcher');
  IOSInitializationSettings iosInitializationSettings = new IOSInitializationSettings();
  final globalKey = GlobalKey<ScaffoldState>();


  Future<bool> isRegister() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var isReg = prefs.getBool('isReg');
    return isReg;
  }

  var signPage = SignInPage();
  var navPage = BottomNavigationPage();

  @override
  Widget build(BuildContext context) {

    InitializationSettings initializationSettings = new InitializationSettings(
        android:  androidInitializationSettings, iOS:  iosInitializationSettings );
    localNotificationsPlugin = FlutterLocalNotificationsPlugin();
    localNotificationsPlugin.initialize(initializationSettings);
    if (Platform.isIOS) iOS_Permission();
    _configureFirebaseListeners(context);
    _getToken();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          primaryColor: Colors.indigo[300],
          canvasColor: Colors.indigo[900],
          visualDensity: VisualDensity.adaptivePlatformDensity,
          tooltipTheme: TooltipThemeData(
            decoration: ShapeDecoration(
              color: Color(0xFF232F34),
              shape: StadiumBorder(),
            ),
          )),
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

  Future _showNotification(String title, String body) async {
    var androidDetails = new AndroidNotificationDetails("channelId", "channelName", "channelDescription");
    var iosDetails = new IOSNotificationDetails();
    var generalNotificationsDetails = new NotificationDetails(android: androidDetails, iOS: iosDetails);
    await localNotificationsPlugin.show(0, title, body, generalNotificationsDetails);
  }

  void iOS_Permission() {
    _firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true)
    );
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings)
    {
      // print("Settings registered: $settings");
    });
  }

  _getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    _firebaseMessaging.getToken().then((String token) async {
      assert(token != null);
      print(token);
      sharedPreferences.setString(AppConstants.deviceToken, token);
    });
  }

  _configureFirebaseListeners(BuildContext context) {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print(message);
        Map<String, dynamic> convertedMessage = _convertMessage(message);
        if(convertedMessage != null) {
          print("onMessage: $message");
          _showNotification(convertedMessage["title"], convertedMessage["body"]);
        }
      },
      onLaunch: (Map<String, dynamic> message) async {
        print(message);
        Map<String, dynamic> convertedMessage = _convertMessage(message);
        if(convertedMessage != null) {
          print("onLaunch: $message");
        }
      },
      onResume: (Map<String, dynamic> message) async {
        print(message);
        Map<String, dynamic> convertedMessage = _convertMessage(message);
        if(convertedMessage != null) {
          print("onResume: $message");
        }
      },
    );
  }

  Map<String, dynamic> _convertMessage(Map<String, dynamic> message) {
    try {
      if (Platform.isIOS) {
        return {
          'title': 'Agregator',
          'body': message['aps']['alert'],
        };
      } else {
        return {
          'title': 'Agregator',
          'body': message['notification']['body'],
        };
      }
    } catch (e) {
      return null;
    }
  }
}
