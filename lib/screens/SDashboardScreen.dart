import 'package:flutter_blue/flutter_blue.dart';
import 'package:qr_code_scanner_example/screens/ScourseSectionsScreen.dart';
import '../screens/SAttendanceScreen.dart';
import '../screens/SCoursesScreen.dart';
import '../library/constant.dart';
import '../models/Dashboard.dart';
import '../screens/CoursesScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_villains/villain.dart';
import 'package:page_transition/page_transition.dart';
import '../sidemenue.dart';
class SDashboardScreen extends StatefulWidget {
  @override
  SDashboardScreenState createState() => SDashboardScreenState();
}
class SDashboardScreenState extends State<SDashboardScreen> {

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: SideMenue(),
        appBar: new AppBar(title: const Text('Attendify'),
            backgroundColor:primaryColor ),
        body: SingleChildScrollView(
      child: Stack(
        children: <Widget>[
          ClipPath(
            clipper: OvalBottomBorderClipper(),
            child: Container(
                height: 250,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [primaryColor, primaryColor])),
                child: null),
          ),
          Villain(
            villainAnimation: VillainAnimation.fromTop(
              from: Duration(milliseconds: 200),
              to: Duration(milliseconds: 400),
            ),
            child: Container(
              margin: EdgeInsets.only(top: 35),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Dashboard",
                    style: TextStyle(color: white, fontSize: 20.0),
                  ),
                                  ],
              ),
            ),
          ),
          Villain(
            villainAnimation: VillainAnimation.fromTop(
              from: Duration(milliseconds: 300),
              to: Duration(milliseconds: 600),
            ),
            child: Center(
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width * 0.9,
                margin: EdgeInsets.only(top: 80),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: GridView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: sdashboardData.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              var screen;
                              if (sdashboardData[index].routes == 'courses') {
                                screen = SCoursesScreen();
                              } else if (sdashboardData[index].routes ==
                                  'viewAttendance') {
                                screen = ScourseSectionsScreen(
                                );
                              } else if (sdashboardData[index].routes ==
                                  'takeAttendance') {
                                screen = SAttendanceScreen();
                              } else {
                                screen = CoursesScreen();
                              }
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      child: screen));
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              decoration: BoxDecoration(
                                  color: white,
                                  shape: BoxShape
                                      .rectangle, // BoxShape.circle or BoxShape.retangle
                                  //color: const Color(0xFF66BB6A),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 1.0,
                                    ),
                                  ]),
                              height: 100,
                              width: 100,
                              child: Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    sdashboardData[index].icon,
                                    Text(
                                      sdashboardData[index].title,
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: black,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
