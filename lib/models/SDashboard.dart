import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:qr_code_scanner_example/library/constant.dart';
class SDashboard {
  final String title;
  final Icon icon;
  final String routes;
  SDashboard({ this.title,  this.icon, this.routes});
}
List<SDashboard> SdashboardData = [
  SDashboard(
    routes: "courses",
    title: "My courses",
    icon: Icon(
      SimpleLineIcons.getIconData(
        "graduation",
      ),
      size: 50,
        color: primaryColor,
    ),
  ),
  SDashboard(
    routes: "takeAttendance",
    title: "Scan",
    icon: Icon(
      FontAwesome5.getIconData(
        "fa-camera",
        weight: IconWeight.Solid,
      ),
      size: 40,
        color: primaryColor,
    ),
  ),
  SDashboard(
    routes: "viewAttendance",
    title: "View Attendance",
    icon: Icon(
      Feather.getIconData(
        "eye",
      ),
      size: 50,
      color: primaryColor,
    ),
  ),
];
