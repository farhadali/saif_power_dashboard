import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:user_login/common_widgets/app_bar.dart';
import 'package:user_login/common_widgets/bottom_menu_data.dart';
import 'package:user_login/common_widgets/common_bottom_navbar.dart';
import 'package:user_login/constants/text_string.dart';
import 'package:user_login/settings/my_accounts.dart';
import 'package:user_login/settings/settings_screen.dart';
import 'package:user_login/users/authentication/login_screen.dart';
import 'package:user_login/users/fragments/dashboard_of_fregments.dart';
import 'package:user_login/users/userPreferances/user_preferences.dart';

class MyAccounts extends StatefulWidget {
  static const TextStyle optionStyle =
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold);

  @override
  State<MyAccounts> createState() => _MyAccountsState();
}

class _MyAccountsState extends State<MyAccounts> {
  List _navigationButtonsProperties = fBottom_menu_other_data;

  RxInt _indexNumber = 0.obs;

  int _selectedIndex = 0;

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
          "My Account",
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
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
