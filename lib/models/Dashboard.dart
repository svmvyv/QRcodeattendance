import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:qr_code_scanner_example/library/constant.dart';
class Dashboard {
  final String title;
  final Icon icon;
  final String routes;
  Dashboard({ this.title,  this.icon, this.routes});
}
List<Dashboard> dashboardData = [
  Dashboard(
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
  Dashboard(
    routes: "takeAttendance",
    title: "Generate QR",
    icon: Icon(
      FontAwesome5.getIconData(
        "user-check",
        weight: IconWeight.Solid,
      ),
      size: 40,
        color: primaryColor,
    ),
  ),
  Dashboard(
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
List<Dashboard> sdashboardData = [
  Dashboard(
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
  Dashboard(
    routes: "takeAttendance",
    title: "Scan",
    icon: Icon(
      FontAwesome5.getIconData(
        "camera",
        weight: IconWeight.Solid,
      ),
      size: 40,
      color: primaryColor,
    ),
  ),
  Dashboard(
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
