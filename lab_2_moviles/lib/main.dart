import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tarjetas con Imágenes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Lista de Imágenes'),
        ),
        body: OrientationBuilder(
          builder: (context, orientation) {
            return GridView.count(
              crossAxisCount: orientation == Orientation.portrait ? 3 : 6,
              children: List.generate(100, (index) {
                return Card(
                  color: index % 2 == 0 ? Colors.blue : Colors.green,
                  child: Column(
                    children: [
                      AspectRatio(
                        aspectRatio: 1, // Proporción de aspecto de la imagen
                        child: Image.asset(
                          'assets/images/arbol.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
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
