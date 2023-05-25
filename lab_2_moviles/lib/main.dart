import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

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

class _MasonryLayoutState extends State<MasonryLayout>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  List<String> images = [];
  int page = 1;
  bool isLoading = false;
  bool isScrollingDown = false;
  List<String> categories = ['All', 'Nature', 'Food', 'Architecture', 'Travel'];
  String selectedCategory = 'All';
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    fetchImages();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        fetchImages();
      }
      setState(() {
        isScrollingDown = _scrollController.position.userScrollDirection ==
            ScrollDirection.reverse;
      });
    });

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> fetchImages() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      final String apiKey =
          'JkyeRyS_33Ay_uowyzJqLjsi7M9NGnuykzB6eC8APmk'; // Reemplaza con tu propia API key de Unsplash
      final String baseUrl = 'https://api.unsplash.com';
      final String path = '/search/photos';
      final int perPage = 20;
      final String query = selectedCategory.toLowerCase();
      final String url =
          '$baseUrl$path?page=$page&per_page=$perPage&query=$query&client_id=$apiKey';

      try {
        final response = await http.get(Uri.parse(url));
        if (response.statusCode == 200) {
          final Map<String, dynamic> data = jsonDecode(response.body);
          final List<dynamic> results = data['results'];
          List<String> newImages = [];
          for (var item in results) {
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

  void onCategorySelected(String category) {
    setState(() {
      selectedCategory = category;
      images.clear();
      page = 1;
      fetchImages();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Masonry Layout'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              margin: EdgeInsets.only(top: 20.0, bottom: 10.0),
            ),
            ListTile(
              title: Text('Filtros'),
            ),
            ListTile(
              title: Text('All'),
              onTap: () {
                Navigator.pop(context);
                onCategorySelected('All');
              },
            ),
            ListTile(
              title: Text('Nature'),
              onTap: () {
                Navigator.pop(context);
                onCategorySelected('Nature');
              },
            ),
            ListTile(
              title: Text('Food'),
              onTap: () {
                Navigator.pop(context);
                onCategorySelected('Food');
              },
            ),
            ListTile(
              title: Text('Architecture'),
              onTap: () {
                Navigator.pop(context);
                onCategorySelected('Architecture');
              },
            ),
            ListTile(
              title: Text('Travel'),
              onTap: () {
                Navigator.pop(context);
                onCategorySelected('Travel');
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: OrientationBuilder(
              builder: (context, orientation) {
                final crossAxisCount =
                    orientation == Orientation.portrait ? 3 : 6;
                return AnimationLimiter(
                  child: StaggeredGridView.countBuilder(
                    controller: _scrollController,
                    physics: AlwaysScrollableScrollPhysics(),
                    crossAxisCount: crossAxisCount, // Número de columnas
                    itemCount: images.length + 1,
                    itemBuilder: (BuildContext context, int index) {
                      if (index < images.length) {
                        return AnimationConfiguration.staggeredGrid(
                          position: index,
                          columnCount: crossAxisCount,
                          duration: const Duration(milliseconds: 500),
                          child: ScaleAnimation(
                            child: FadeInAnimation(
                              child: SlideAnimation(
                                verticalOffset: isScrollingDown ? 50.0 : -50.0,
                                child: Container(
                                  margin: EdgeInsets.all(8.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.network(
                                      images[index],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      } else if (isLoading) {
                        return Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(16.0),
                          child: SpinKitCircle(
                            color: Colors
                                .blue, // Personaliza el color del indicador de carga
                            size:
                                50.0, // Personaliza el tamaño del indicador de carga
                          ),
                        );
                      } else {
                        return Container();
                      }
                    },
                    staggeredTileBuilder: (int index) {
                      if (index < images.length) {
                        return StaggeredTile.fit(
                            orientation == Orientation.portrait ? 1 : 2);
                      } else {
                        return StaggeredTile.count(crossAxisCount,
                            1); // Ancho completo para el indicador de carga
                      }
                    },
                    mainAxisSpacing: 8.0, // Espaciado vertical entre elementos
                    crossAxisSpacing:
                        8.0, // Espaciado horizontal entre elementos
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
