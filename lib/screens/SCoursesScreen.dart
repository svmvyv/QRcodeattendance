import '../screens/QRCodeAttend.dart';

import '../library/constant.dart';
import '../models/Courses.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_villains/villains/villains.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class SCoursesScreen extends StatefulWidget {

  _SCoursesScreenState createState() => _SCoursesScreenState();
}

class _SCoursesScreenState extends State<SCoursesScreen> {
  List<Courses> course = [];
  Future<List<Courses>> courses;
  var baseUrl = serverUrl + 'Eattendance/Student/StudentSections.php';
  var isLoading = false;
   _fetchData() async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response =
    await http.post(Uri.parse(baseUrl), body: {
      'userid':prefs.getString('userid'),
    });
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if(data["success"]==1) {
        final parsed = (data["arr"]).cast<Map<String, dynamic>>();
        course =  (data["arr"] as List)
            .map((data) => new Courses.fromJson(data))
            .toList();
      }
      else {
        //no places here
      }
      setState(() {
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load courses');
    }
  }
  @override
  void initState() {
    super.initState();
    setState(() {
       _fetchData();
    });

  }
  Widget createViewItem(Courses ccourse, BuildContext context) {
    return new ListTile(
        title: Text(ccourse.CourseName + ccourse.SectionName),
        subtitle: Column(
          children: <Widget>[
            Text(ccourse.sectiondays +
                ' ( From ' +
                ccourse.StartTime +'To'+  ccourse.EndTime +
                ')',style:TextStyle(fontWeight: FontWeight.bold,color: Colors.blue,fontSize: 15),),


          ],
        ),
        onTap: () {

         // var route = new MaterialPageRoute(
           // builder: (BuildContext context) => new relativedetails(place1: crelative),
          //);
          //A Navigator is a widget that manages a set of child widgets with
          //stack discipline.It allows us navigate pages.
        //  Navigator.of(context).push(route);
        });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              ClipPath(
                clipper: WaveClipperTwo(),
                child: Container(
                    height: 250,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [primaryColor, primaryColor])),
                    // color: Color(0xFFF55C20),
                    child: null),
              ),
              Villain(
                villainAnimation: VillainAnimation.fromTop(
                  // relativeOffset: 0.4,
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
                      IconButton(
                        icon: Icon(
                          SimpleLineIcons.getIconData("arrow-left"),
                          color: white,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      Text(
                        "Courses",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: white, fontSize: 20.0),
                      ),
                      SizedBox(
                        width: 50,
                      )
                    ],
                  ),
                ),
              ),
              Center(
                  child: AnimatedContainer(
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 5.0,
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: new BorderRadius.only(
                            topLeft: const Radius.circular(40.0),
                            bottomLeft: const Radius.circular(40.0),
                            bottomRight: const Radius.circular(40.0),
                            topRight: const Radius.circular(40.0))),
                    margin: EdgeInsets.only(top: 100),
                    width: MediaQuery.of(context).size.width * 0.85,
                    duration: Duration(seconds: 1),
                    height: MediaQuery.of(context).size.height * 0.60,
                    child:ListView.builder(
                        itemCount: course.length,
                        itemBuilder: (context, int currentIndex) {
                          return createViewItem(course[currentIndex], context);
                        }
                    ),
                  )),
            ],
          ),
        ));
  }
}
