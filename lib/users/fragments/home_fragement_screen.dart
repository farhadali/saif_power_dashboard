import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_login/common_widgets/bottom_menu_data.dart';
import 'package:user_login/companies/saif_powertech_ltd/saif_powertech_ltd.dart';

class HomeFragementScreen extends StatelessWidget {
  List _saif_power_sister_concerns = fsisterConcerns;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
            itemCount: _saif_power_sister_concerns.length,
            itemBuilder: (context, index) {
              return Card(
                color: _saif_power_sister_concerns[index]["color"],
                child: ListTile(
                  title: Text(
                    _saif_power_sister_concerns[index]["label"],
                  ),
                  leading: Icon(
                    _saif_power_sister_concerns[index]["active_icon"],
                    size: 50,
                  ),
                  onTap: () {
                    Get.to(_saif_power_sister_concerns[index]["page"]);
                  },
                ),
              );
            }),
      ),
    );
  }
}
