import 'dart:async';
import 'package:flutter_blue/flutter_blue.dart';
import '../models/Device.dart';
import '../models/Studentlec.dart';
import '../library/constant.dart';
import '../models/Courses.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_villains/villains/villains.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class SAttendanceTrackScreen extends StatefulWidget {
  final String AttendanceID;
  final String BeaconID;
  final String Distance;
  SAttendanceTrackScreen(this.AttendanceID,this.BeaconID,this.Distance);
  _SAttendanceTrackScreenState createState() => _SAttendanceTrackScreenState();
}
class _SAttendanceTrackScreenState extends State<SAttendanceTrackScreen> {
  List<Track> lectrack = [];
  Future<List<Studentlec>> fStudentlec;
  var Addtrack = serverUrl + 'Eattendance/Student/AttendanceTrack.php';
  var isLoading = false;
  Timer timer;
  FlutterBlue flutterBlue = FlutterBlue.instance;
  var subscription;
  _fetchData() async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response =
    await http.post(Uri.parse(Addtrack), body: {
      'AttendanceID':widget.AttendanceID
    });
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if(data["success"]==1) {
        final parsed = (data["arr"]).cast<Map<String, dynamic>>();
        lectrack =  (data["arr"] as List)
            .map((data) => new Track.fromJson(data))
            .toList();
      }
      else {
        //no Results here
      }
      setState(() {
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load Lectures');
    }
  }
   static double calculateAccuracy(int txPower, double rssi) {
    if (rssi == 0) {
      return -1.0; // if we cannot determine accuracy, return -1.
    }
    double ratio = rssi*1.0/txPower;
    if (ratio < 1.0) {
      return pow(ratio,10);
    }
    else {
      double accuracy =  (0.89976)* pow(ratio,7.7095) + 0.111;
      return accuracy;
    }
  }
  void startscan() async{
    List<device> devices = [];
    bool myvlue=false;
    flutterBlue.startScan(timeout: Duration(seconds: 4));
    subscription =  flutterBlue.scanResults.listen((results)  {
      // do something with scan results
      for (ScanResult r in results) {
        print('${r.device.name} found! rssi: ${r.rssi}');
        print('${r.device.id} found! rssi: ${r.rssi}');
        if(r.device.id.toString()==widget.BeaconID && devices.length==0 && myvlue==false)
        {
          setState(() {
            myvlue=true;
          device newdevice=new device(r.device.name, r.device.id.toString(), r.rssi.toString(), r.advertisementData.txPowerLevel.toString());
          devices.add(newdevice);
          print("lenghth=" + devices.length.toString());
          print('me' + r.advertisementData.txPowerLevel.toString());
          double distance=calculateAccuracy(-74 ,double.parse(devices[0].getdvicerssi()));
          print('distance' + distance.toString());
           if(double.parse(widget.Distance)>=distance )
           _fetchData();
          });
          break;
        }
      }
   });
    flutterBlue.stopScan();
  }

  @override
  void initState()  {
    super.initState();
    setState(() {
      _fetchData();
     timer = Timer.periodic(Duration(seconds:600), (Timer t) => startscan());
    });
    @override
    void dispose() {
      timer?.cancel();
      super.dispose();

    }
  }
  Widget createViewItem(Track Strack, BuildContext context) {
    return new ListTile(
      title: Text(Strack.CourseName + Strack.SectionName),
      subtitle: Column(
        children: <Widget>[
          Text(Strack.LECDate +
              '(' +
              Strack.TrackDate +  Strack.TrackTime +
              ')'),
          //Text(clec.statusdesc),
          //(clec.statusdesc=="attending")? Icon(Icons.check, color: Colors.redAccent) : Icon(Icons.close, color: Colors.grey),
        ],
      ),
    );
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
                        "WAIT! \n Please don’t exit this page.",
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
                        itemCount: lectrack.length,
                        itemBuilder: (context, int currentIndex) {
                          return createViewItem(lectrack[currentIndex], context);
                        }
                    ),

                  ),
              ),
            ],
          ),
        ));
  }
}
