// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:lab_2_moviles/screens/mansory_layout.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PinFinity',
      theme: ThemeData(
        primarySwatch: Colors.teal, //cambia este
        scaffoldBackgroundColor: Colors.black, //deja est en negro
      ),
      debugShowCheckedModeBanner: false,
      home: OrientationBuilder(
        builder: (context, orientation) {
          return MasonryLayout(orientation: orientation);
        },
      ),
    );
  }
}
