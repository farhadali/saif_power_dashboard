import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:user_login/common_widgets/app_bar.dart';
import 'package:user_login/common_widgets/bottom_menu_data.dart';
import 'package:user_login/common_widgets/common_bottom_navbar.dart';
import 'package:user_login/companies/saif_powertech_ltd/saif_powertech_ltd.dart';
import 'package:user_login/constants/text_string.dart';
import 'package:user_login/settings/my_accounts.dart';
import 'package:user_login/settings/settings_screen.dart';
import 'package:user_login/users/authentication/login_screen.dart';
import 'package:user_login/users/fragments/favorites_fragement_scree.dart';
import 'package:user_login/users/fragments/home_fragement_screen.dart';
import 'package:user_login/users/fragments/order_fragement_screen.dart';
import 'package:user_login/users/fragments/profile_fragement_screen.dart';
import 'package:user_login/users/userPreferances/current_user.dart';
import 'package:get/get.dart';
import 'package:user_login/users/userPreferances/user_preferences.dart';

class DashboardOfFragments extends StatelessWidget {
  CurrentUser _rememberCurrentUser = Get.put(CurrentUser());

  List<Widget> _fragmentScreens = [
    HomeFragementScreen(),
    FavoritesFragementScree(),
    OrderFragementScreen(),
    ProfileFragementScreen(),
  ];

//Data Come From common_widgets/bottom_menu_data
  List _navigationButtonsProperties = fBottom_menu_data;

  //Dashboard fragement first key assign
  RxInt _indexNumber = 0.obs;
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: CurrentUser(),
      initState: (currentState) {
        _rememberCurrentUser.getUserInfo();
      },
      builder: (controller) {
        return Scaffold(
          appBar: PreferredSize(
              child: getAppBar(), preferredSize: Size.fromHeight(60)),
          body: SafeArea(
            child: Obx(() => _fragmentScreens[_indexNumber.value]),
          ),

          /* Bottom Nav Bar */
          bottomNavigationBar: commonBottomNavBar(
              indexNumber: _indexNumber,
              navigationButtonsProperties: _navigationButtonsProperties),
        );
      },
    );
  }
}
