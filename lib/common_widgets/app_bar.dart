import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:user_login/constants/text_string.dart';
import 'package:user_login/settings/my_accounts.dart';
import 'package:user_login/settings/settings_screen.dart';
import 'package:user_login/users/authentication/login_screen.dart';
import 'package:user_login/users/fragments/dashboard_of_fregments.dart';
import 'package:user_login/users/userPreferances/user_list_screen.dart';
import 'package:user_login/users/userPreferances/user_page.dart';
import 'package:user_login/users/userPreferances/user_preferences.dart';

class getAppBar extends StatefulWidget {
  @override
  State<getAppBar> createState() => _getAppBarState();
}

class _getAppBarState extends State<getAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(fAppTitle),
      backgroundColor: Colors.redAccent,
      actions: [
        PopupMenuButton(
            // add icon, by default "3 dot" icon
            // icon: Icon(Icons.book)
            itemBuilder: (context) {
          return [
            PopupMenuItem<int>(
              value: 0,
              child: Text("Dashboard"),
            ),
            PopupMenuItem<int>(
              value: 1,
              child: Text("My Account"),
            ),
            PopupMenuItem<int>(
              value: 2,
              child: Text("Settings"),
            ),
            PopupMenuItem<int>(
              value: 4,
              child: Text("User List"),
            ),
            PopupMenuItem<int>(
              value: 3,
              child: Text("Logout"),
            ),
          ];
        }, onSelected: (value) {
          if (value == 0) {
            print("Dashboard menu is selected.");
            Get.to(DashboardOfFragments());
          } else if (value == 1) {
            print("My account menu is selected.");
            Get.to(MyAccounts());
          } else if (value == 2) {
            Get.to(SettingsScreen());
          } else if (value == 4) {
            Get.to(DataTableListScreen());
          } else if (value == 3) {
            //Logout Button Action
            print("Logout selected");
            RememberUserPrefs.removeUserInfo().then((value) {
              Fluttertoast.showToast(msg: "Log out Successfully");
              Get.off(LoginScreen());
            });
          }
        }),
      ],
    );
  }
}
