import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:user_login/common_widgets/app_bar.dart';
import 'package:user_login/users/authentication/login_screen.dart';
import 'package:user_login/users/fragments/dashboard_of_fregments.dart';
import 'package:user_login/users/userPreferances/user_preferences.dart';

class SaifPlasticPolimar extends StatefulWidget {
  const SaifPlasticPolimar({Key? key}) : super(key: key);

  @override
  _SaifPlasticPolimarState createState() => _SaifPlasticPolimarState();
}

class _SaifPlasticPolimarState extends State<SaifPlasticPolimar> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      print(index);
      if (index == 0) {
        Get.to(DashboardOfFragments());
      }
      if (index == 1) {
        RememberUserPrefs.removeUserInfo().then((value) {
          Fluttertoast.showToast(msg: "Log out Successfully");
          Get.off(LoginScreen());
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          PreferredSize(child: getAppBar(), preferredSize: Size.fromHeight(60)),
      body: Center(
        child: Text(
          "Saif Power Group.",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Go To Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Logout',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
