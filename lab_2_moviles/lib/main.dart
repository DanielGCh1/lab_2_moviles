import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Masonry Layout',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: OrientationBuilder(
        builder: (context, orientation) {
          return MasonryLayout(orientation: orientation);
        },
      ),
    );
  }
}

class MasonryLayout extends StatefulWidget {
  final Orientation orientation;

  const MasonryLayout({Key? key, required this.orientation}) : super(key: key);

  @override
  _MasonryLayoutState createState() => _MasonryLayoutState();
}

class _MasonryLayoutState extends State<MasonryLayout> {
  final ScrollController _scrollController = ScrollController();
  List<String> images = [];
  int page = 1;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchImages();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        fetchImages();
      }
    });
  }

  Future<void> fetchImages() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      final String apiKey =
          'JkyeRyS_33Ay_uowyzJqLjsi7M9NGnuykzB6eC8APmk'; // Reemplaza con tu propia API key de Unsplash
      final String url =
          'https://api.unsplash.com/photos/random?count=20&page=$page&client_id=$apiKey';

      try {
        final response = await http.get(Uri.parse(url));
        if (response.statusCode == 200) {
          final List<dynamic> data = jsonDecode(response.body);
          List<String> newImages = [];
          for (var item in data) {
            newImages.add(item['urls']['regular']);
          }
          setState(() {
            images.addAll(newImages);
            isLoading = false;
            page++;
          });
        } else {
          setState(() {
            isLoading = false;
          });
          print('Error: ${response.statusCode}');
        }
      } catch (e) {
        setState(() {
          isLoading = false;
        });
        print('Error: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Masonry Layout'),
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          final crossAxisCount = orientation == Orientation.portrait ? 3 : 6;
          return StaggeredGridView.countBuilder(
            controller: _scrollController,
            crossAxisCount: crossAxisCount, // Número de columnas
            itemCount: images.length + 1,
            itemBuilder: (BuildContext context, int index) {
              if (index < images.length) {
                return Container(
                  margin: EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      images[index],
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              } else if (isLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return SizedBox();
              }
            },
            staggeredTileBuilder: (int index) =>
                StaggeredTile.fit(orientation == Orientation.portrait ? 1 : 2),
            mainAxisSpacing: 8.0, // Espaciado vertical entre elementos
            crossAxisSpacing: 8.0, // Espaciado horizontal entre elementos
          );
        },
      ),
    );
  }
}
