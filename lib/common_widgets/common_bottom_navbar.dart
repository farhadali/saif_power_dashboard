import 'package:flutter/material.dart';
import 'package:get/get.dart';

class commonBottomNavBar extends StatelessWidget {
  const commonBottomNavBar({
    Key? key,
    required RxInt indexNumber,
    required List navigationButtonsProperties,
  })  : _indexNumber = indexNumber,
        _navigationButtonsProperties = navigationButtonsProperties,
        super(key: key);

  final RxInt _indexNumber;
  final List _navigationButtonsProperties;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => BottomNavigationBar(
        currentIndex: _indexNumber.value,
        onTap: (value) {
          _indexNumber.value = value;
        },
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white24,
        items: List.generate(_navigationButtonsProperties.length, (index) {
          var navButtonProperty = _navigationButtonsProperties[index];
          return BottomNavigationBarItem(
            backgroundColor: Colors.black,
            icon: Icon(navButtonProperty["non_active_icon"]),
            activeIcon: Icon(navButtonProperty["active_icon"]),
            label: navButtonProperty["label"],
          );
        }),
      ),
    );
  }
}
