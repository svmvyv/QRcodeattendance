import 'package:cached_network_image/cached_network_image.dart';

import '../library/constant.dart';
import '../models/Courses.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_villains/villains/villains.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class QRCodeAttend extends StatefulWidget {
  final String sectionid;
  QRCodeAttend(this.sectionid);
  _QRCodeAttendState createState() => _QRCodeAttendState();
}
class _QRCodeAttendState extends State<QRCodeAttend> {

  var baseUrl = serverUrl + 'Eattendance/Doctor/StartAttendance.php';
  var isLoading = false;
  var qrcodeurl="";
  _fetchData() async {
    setState(() {
      isLoading = true;
    });

    final response =
    await http.post(Uri.parse(baseUrl), body: {
      'sectionid':widget.sectionid,
    });
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if(data["success"]==1) {
        qrcodeurl=data["attendimageurl"];
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
                        "Attentd QR code",
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
                    child:CachedNetworkImage(
                      imageUrl: qrcodeurl,
                      placeholder: (context, url) => new CircularProgressIndicator(),
                      errorWidget: (context, url, error) => new Icon(Icons.zoom_out_outlined),
                    ),
                  ),
              ),
            ],
          ),
        ));
  }
}
