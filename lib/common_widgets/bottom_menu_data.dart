import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:user_login/companies/e_engineering_ltd/e_engineering_ltd.dart';
import 'package:user_login/companies/saif_plastic_polimar/saif_plastic_polimar.dart';
import 'package:user_login/companies/saif_power_group/saif_power_group.dart';
import 'package:user_login/companies/saif_powertech_ltd/saif_powertech_ltd.dart';
import 'package:user_login/users/fragments/home_fragement_screen.dart';

var fBottom_menu_data = [
  {
    "active_icon": Icons.home,
    "non_active_icon": Icons.home_outlined,
    "label": "Home",
  },
  {
    "active_icon": Icons.favorite,
    "non_active_icon": Icons.favorite_border,
    "label": "Favorite",
  },
  {
    "active_icon": FontAwesomeIcons.boxOpen,
    "non_active_icon": FontAwesomeIcons.box,
    "label": "Order",
  },
  {
    "active_icon": Icons.person,
    "non_active_icon": Icons.person_outline,
    "label": "Profile",
  },
];

var fBottom_menu_other_data = [
  {
    "active_icon": Icons.home,
    "non_active_icon": Icons.home_outlined,
    "label": "Home",
  },
  {
    "active_icon": Icons.favorite,
    "non_active_icon": Icons.favorite_border,
    "label": "Favorite",
  },
  {
    "active_icon": FontAwesomeIcons.boxOpen,
    "non_active_icon": FontAwesomeIcons.box,
    "label": "Order",
  },
  {
    "active_icon": Icons.person,
    "non_active_icon": Icons.person_outline,
    "label": "Profile",
  },
];

var fsisterConcerns = [
  {
    "active_icon": Icons.home,
    "non_active_icon": Icons.home_outlined,
    "label": "Saif Power Group",
    "color": Colors.white30,
    "status": true,
    "page": SaifPowerGroup(),
  },
  {
    "active_icon": Icons.favorite,
    "non_active_icon": Icons.favorite_border,
    "label": "Saif Powertec LTD",
    "color": Colors.yellow,
    "status": true,
    "page": SaifPowerTecLtd(),
  },
  {
    "active_icon": FontAwesomeIcons.boxOpen,
    "non_active_icon": FontAwesomeIcons.box,
    "label": "E-Engineering Ltd.",
    "color": Colors.blue,
    "status": true,
    "page": EEngineeringLtd(),
  },
  {
    "active_icon": Icons.person,
    "non_active_icon": Icons.person_outline,
    "label": "Saif Plastic & Ploymer",
    "color": Colors.green,
    "status": true,
    "page": SaifPlasticPolimar(),
  },
  // {
  //   "active_icon": Icons.person,
  //   "non_active_icon": Icons.person_outline,
  //   "label": "Saif Maritime Limited",
  //   "color": Colors.grey,
  //   "status": true,
  // },
  // {
  //   "active_icon": Icons.person,
  //   "non_active_icon": Icons.person_outline,
  //   "label": "88innovations Engineering Ltd",
  //   "color": Colors.purple,
  //   "status": true,
  // },
  // {
  //   "active_icon": Icons.person,
  //   "non_active_icon": Icons.person_outline,
  //   "label": "Saif Port Holdings Limited",
  //   "color": Colors.lightBlue,
  //   "status": true,
  // },
  // {
  //   "active_icon": Icons.person,
  //   "non_active_icon": Icons.person_outline,
  //   "label": "SAIF Electrical Manufacturing Limited",
  //   "color": Colors.yellowAccent,
  //   "status": true,
  // },
  // {
  //   "active_icon": Icons.person,
  //   "non_active_icon": Icons.person_outline,
  //   "label": "Saif Logistics Alliance Limited",
  //   "color": Colors.white,
  //   "status": true,
  // },
  // {
  //   "active_icon": Icons.person,
  //   "non_active_icon": Icons.person_outline,
  //   "label": "Saif Plastic & Polymer Industries Limited",
  //   "color": Colors.white30,
  //   "status": true,
  // },
  // {
  //   "active_icon": Icons.person,
  //   "non_active_icon": Icons.person_outline,
  //   "label": "SAIF Electrical Manufacturing Limited",
  //   "color": Colors.blueGrey,
  //   "status": true,
  // },
  // {
  //   "active_icon": Icons.person,
  //   "non_active_icon": Icons.person_outline,
  //   "label": "Grihayan Limited",
  //   "color": Colors.white54,
  //   "status": true,
  // },
  // {
  //   "active_icon": Icons.person,
  //   "non_active_icon": Icons.person_outline,
  //   "label": "Saif Global Sports",
  //   "color": Colors.white30,
  //   "status": true,
  // },
];
