import 'package:flutter/material.dart';
import 'package:qr_code_scanner_example/library/constant.dart';
import 'package:qr_code_scanner_example/screens/AttendanceScreen.dart';
import 'package:qr_code_scanner_example/screens/CoursesScreen.dart';
import 'package:qr_code_scanner_example/screens/LoginScreen.dart';
import 'package:qr_code_scanner_example/screens/SAttendanceScreen.dart';
import 'package:qr_code_scanner_example/screens/SCoursesScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
class SideMenue extends StatefulWidget {
  const SideMenue({Key key}) : super(key: key);
  @override
  _SideMenueState createState() => _SideMenueState();
}
class _SideMenueState extends State<SideMenue> {
  String name="";
  getStringValuesSF() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String stringValue = prefs.getString('fullname');
    setState(() {
      name= stringValue;
    });

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      getStringValuesSF();
    });
  }
  @override

    Widget build(BuildContext context)  {
      return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(
                'Attendify',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
              decoration: BoxDecoration(
                  color: primaryColor,
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/images/icon.jpeg'))),
            ),
            ListTile(
              leading: Icon(Icons.input),
               title: Text('Welcome:' +  name),
           //   title: Text('Welcome:'),
            ),
            ListTile(
                title: Text('My Courses'),
                onTap: ()  async {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  String typeid=prefs.getString("typeid");
                  if(int.parse(typeid)==1)
                  {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (c) => CoursesScreen(
                        ),
                      ),
                    );
                  }
                  else
                  {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (c) => SCoursesScreen(
                        ),
                      ),
                    );
                  }

                }
            ),
            ListTile(
                title: Text('Make Attendance'),
                onTap: ()  async {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  String typeid=prefs.getString("typeid");
                  if(int.parse(typeid)==1)
                  {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (c) => AttendanceScreen(
                        ),
                      ),
                    );
                  }
                  else
                  {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (c) => SAttendanceScreen(
                        ),
                      ),
                    );
                  }

                }
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Logout'),
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.remove('userid');
                prefs.remove('name');
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (BuildContext ctx) => LoginScreen()));
              },
            ),
          ],
        ),
      );
    }
}



