import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tarjetas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Tarjetas'),
        ),
        body: OrientationBuilder(
          builder: (context, orientation) {
            return GridView.count(
              crossAxisCount: orientation == Orientation.portrait ? 3 : 6,
              children: List.generate(12, (index) {
                return Card(
                  color: index % 2 == 0 ? Colors.blue : Colors.green,
                  child: Center(
                    child: Text(
                      'Tarjeta $index',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                );
              }),
            );
          },
        ),
      ),
    );
  }
}

