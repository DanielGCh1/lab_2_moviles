import 'package:flutter/material.dart';
import 'package:lab_2_moviles/screens/MansoryLayout.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PinFinity',
      theme: ThemeData(
        primarySwatch: Colors.blue, //cambia este
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
