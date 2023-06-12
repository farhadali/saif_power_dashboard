import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_login/constants/text_string.dart';
import 'package:user_login/users/authentication/login_screen.dart';
import 'package:user_login/users/fragments/dashboard_of_fregments.dart';
import 'package:user_login/users/userPreferances/user_preferences.dart';

void main() {
  //Avoid fist empty app
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: fAppTitle,
      theme: ThemeData(primarySwatch: Colors.purple),
      home: FutureBuilder(
          future: RememberUserPrefs.readUserInfo(),
          builder: (context, dataSnapShot) {
            if (dataSnapShot.data == null) {
              return LoginScreen();
            } else {
              return DashboardOfFragments();
            }
          }),
    );
  }
}
