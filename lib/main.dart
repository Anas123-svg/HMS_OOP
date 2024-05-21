import 'package:flutter/material.dart';
import 'package:kk/screen/loginScreen.dart';
import 'package:kk/Helps/Utility.dart';
import 'package:kk/screen/HomeScreen.dart';
import 'package:kk/screen/DoctorScreen.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DoctorScreen(),
    );
  }
}





