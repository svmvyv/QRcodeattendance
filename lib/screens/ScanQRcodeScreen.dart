import 'dart:developer';
import 'dart:io';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:http/http.dart' as http;
import 'package:qr_code_scanner_example/screens/SAttendanceScreen.dart';
import 'package:qr_code_scanner_example/screens/SAttendanceTrackScreen.dart';
import 'package:qr_code_scanner_example/screens/SDashboardScreen.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../library/constant.dart';
class ScanQRcodeScreen extends StatefulWidget {
  final String Sectionlecid;
  ScanQRcodeScreen(this.Sectionlecid);
  @override
  _ScanQRcodeScreenState createState() => _ScanQRcodeScreenState();
}
class _ScanQRcodeScreenState extends State<ScanQRcodeScreen> {
  @override
 // void initState() {
   // super.initState();
    //setState(() {
      //Navigator.of(context).push(MaterialPageRoute(
        //builder: (context) => QRViewExample(widget.Sectionlecid),
      //));
    //});
  //}
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scan Lecture QR code screen'), backgroundColor:primaryColor),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => QRViewExample(widget.Sectionlecid),
            ));
          },
          child: const Text('Scan QR code'),
          style: ElevatedButton.styleFrom(primary: primaryColor),
        ),
      ),
    );
  }
}
class QRViewExample extends StatefulWidget {
  final String Sectionlecid;
  QRViewExample(this.Sectionlecid);
  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}
class _QRViewExampleState extends State<QRViewExample> {
  Barcode result;
  String AttendanceID;
  String BeaconID;
  String Distance;
  QRViewController controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseCamera();
    }
    controller.resumeCamera();
  }
  var baseUrl = serverUrl + 'Eattendance/Student/StudentAttend.php';
  var isLoading = false;
  var qrcodeurl="";
  _fetchData(String qrcode) async {
    //compare code with lecture id
    if(qrcode==widget.Sectionlecid) {
      setState(() {
        isLoading = true;
      });
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final response =
      await http.post(Uri.parse(baseUrl), body: {
        'lecid': widget.Sectionlecid,
        'userid': prefs.getString('userid'),
        'deviceid': "123345",
      });
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data["success"] == 1) {
          AttendanceID=data["AttendanceID"];
          BeaconID=data["BeaconID"];
          Distance=data["Distance"];
          await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                backgroundColor: Colors.green,
                title: Text("Attendance Success"),
                content: Text("thanks you attend in lecture"),
                actions: <Widget>[
                  FlatButton(
                    child: Text("Close",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),),
                    onPressed: () {
                      setState(() {
                        Navigator.pop(context);
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (c) => SAttendanceTrackScreen(AttendanceID,BeaconID,Distance
                            ),
                          ),
                        );
                      });
                    },
                  )
                ],
              ));
        }
        else if (data["success"] == 2) {
          AttendanceID=data["AttendanceID"];
          BeaconID=data["BeaconID"];
          Distance=data["Distance"];
          await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                backgroundColor: Colors.red,
                title: Text("Error"),
                content: Text("User already attend in lecture"),
                actions: <Widget>[
                  FlatButton(
                    child: Text("Close",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),),
                    onPressed: () {
                      setState(() {
                        Navigator.pop(context);
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (c) => SAttendanceTrackScreen(AttendanceID,BeaconID,Distance
                            ),
                          ),
                        );
                      });
                    },
                  )
                ],
              ));
        }
        else
          {
            await showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  backgroundColor: Colors.red,
                  title: Text("Error"),
                  content: Text("User not enrolled in lecture"),
                  actions: <Widget>[
                    FlatButton(
                      child: Text("Close",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),),
                      onPressed: () {
                        setState(() {
                          Navigator.pop(context);
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (c) => SAttendanceTrackScreen(AttendanceID,BeaconID,Distance
                              ),
                            ),
                          );
                        });
                      },
                    )
                  ],
                ));
          }
        setState(() {
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load courses');
      }
    }
    else
      {
        //Error
        await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: Colors.red,
              title: Text("Error"),
              content: Text("QR code for another lecture"),
              actions: <Widget>[
                FlatButton(
                  child: Text("Close",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),),
                  onPressed: () {
                    setState(() {
                      Navigator.pop(context);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (c) => SDashboardScreen(
                          ),
                        ),
                      );


                    });
                  },
                )
              ],
            ));
      }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
          Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  if (result != null)
                      Text(
                          'Barcode Type: ${describeEnum(
                              result.format)}   Data: ${result.code}')
                  else
                    const Text('Scan Lecture  Code'),
                  Container(
                    margin: const EdgeInsets.all(40),
                    child: ElevatedButton(
                      onPressed: ()  {
                        if (Navigator.canPop(context)) {
                          Navigator.pop(context);
                        } else {
                          SystemNavigator.pop();
                        }
                      },
                      child: const Text('Close',
                          style: TextStyle(fontSize: 20)),
                      style: ElevatedButton.styleFrom(primary: primaryColor),

                    ),
                  ),

                ],
              ),

          )
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
        MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        if(result!=null) {
          controller?.dispose();
          controller?.pauseCamera();
          _fetchData(result.code);
        }
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
