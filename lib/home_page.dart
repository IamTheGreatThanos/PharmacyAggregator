import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  //   final List<Widget> _children = [OrdersFromExecutorPage(), ServicesPage(), ProfilePage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
      // body: AppConstants.role? _childrenExecutor[_currentIndex] : _children[_currentIndex],
      // bottomNavigationBar: SizedBox(
      //   height: MediaQuery.of(context).size.width * 0.14,
      //   child: BottomNavigationBar(
      //     currentIndex: _currentIndex,
      //     elevation: 15.0,
      //     iconSize: 17,
      //     selectedItemColor: AppColors.mainColor,
      //     unselectedItemColor: AppColors.primaryTextColor,
      //     selectedFontSize: 13,
      //     unselectedFontSize: 11,
      //     items: [
      //       BottomNavigationBarItem(
      //         icon: Icon(
      //           Stoappicons.request_icon,
      //         ),
      //         label: "Заявки",
      //       ),
      //       BottomNavigationBarItem(
      //         icon: Icon(
      //           Stoappicons.services_icon,
      //         ),
      //         label: "Услуги",
      //       ),
      //       BottomNavigationBarItem(
      //         icon: Icon(
      //           Stoappicons.profile_icon,
      //         ),
      //         label: "Профиль",
      //       ),
      //     ],
      //     onTap: (index) {
      //       setState(() {
      //         // if (AppConstants.role)
      //         _currentIndex = index;
      //       });
      //     },
      //   ),
      // ),
    );
  }
}
