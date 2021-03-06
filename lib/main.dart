import 'package:flutter/material.dart';

import 'screens/dashboard.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ESP32 Temp & humid App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        fontFamily: 'pop',
      ),
      home: Dashboard(),
      debugShowCheckedModeBanner: false,
    );
  }
}
