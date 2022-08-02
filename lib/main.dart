import 'screens/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_villains/villains/villains.dart';
import 'library/Authentication.dart';
import 'library/constant.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  final MaterialColor kPrimaryColor = const MaterialColor(
    0xFF1F5271,
    const <int, Color>{
      50: const Color(0xFF1F5271),
      100: const Color(0xFF1F5271),
      200: const Color(0xFF1F5271),
      300: const Color(0xFF1F5271),
      400: const Color(0xFF1F5271),
      500: const Color(0xFF1F5271),
      600: const Color(0xFF1F5271),
      700: const Color(0xFF1F5271),
      800: const Color(0xFF1F5271),
      900: const Color(0xFF1F5271),
    },
  );
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QR Attendance',
      navigatorObservers: [new VillainTransitionObserver()],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        backgroundColor: white,
        primarySwatch: kPrimaryColor,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      routes: {
        '/login': (context) => LoginScreen(),
      },
      home: FutureBuilder<bool>(
          future: checkIfAuthenticated(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.hasData) {
              bool user = snapshot.hasData;
              return  user ? LoginScreen() : LoginScreen();
            }
            return CircularProgressIndicator();
          }),
    );
  }
}
