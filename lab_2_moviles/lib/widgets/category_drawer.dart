import 'package:flutter/material.dart';

class CategoryDrawer extends StatelessWidget {
  final String selectedCategory;
  final Function(String) onCategorySelected;

  CategoryDrawer({
    Key? key,
    required this.selectedCategory,
    required this.onCategorySelected,
  }) : super(key: key);

  final List<Map<String, String>> categories = [
    {'title': 'All', 'category': 'All'},
    {'title': 'Nature', 'category': 'Nature'},
    {'title': 'Food', 'category': 'Food'},
    {'title': 'Architecture', 'category': 'Architecture'},
    {'title': 'Travel', 'category': 'Travel'},
    {'title': 'Animal', 'category': 'Animal'},
    {'title': 'Flowers', 'category': 'Flowers'},
    {'title': 'Science', 'category': 'Science'},
    {'title': 'Art', 'category': 'Art'},
    {'title': 'Sports', 'category': 'Sports'},
    {'title': 'Fashion', 'category': 'Fashion'},
    {'title': 'Music', 'category': 'Music'},
    {'title': 'Technology', 'category': 'Technology'},
    {'title': 'History', 'category': 'History'},
    {'title': 'Cars', 'category': 'Cars'},
    {'title': 'Books', 'category': 'Books'}
  ];
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.teal.shade400,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Filtros',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Georgia'),
                  ),
                ],
              ),
              accountEmail: null,
              currentAccountPicture: null,
            ),
            ...categories.map((category) {
              return MouseRegion(
                cursor: SystemMouseCursors.click,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    onCategorySelected(category['category']!);
                  },
                  child: Container(
                    color: selectedCategory == category['category']
                        ? Colors.teal
                        : Colors.transparent,
                    child: ListTile(
                      title: Text(
                        category['title']!,
                        style: TextStyle(
                            color: selectedCategory == category['category']
                                ? Colors.white
                                : Colors.white70,
                            fontSize: 16.0,
                            fontFamily: 'Georgia'),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
            SizedBox(
                height:
                    16.0), // Espacio vertical entre las categorías y los nombres de los desarrolladores

            Container(
              color: Colors.teal,
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      '\nLABORATORIO 2 \n\nEstudiantes:',
                      textAlign: TextAlign.center, // Centra el texto
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontFamily: 'Times New Roman'),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Daniel Gómez\n\nNatalia Rojas\n\nDiego Jiménez\n\nLibny Gómez\n\n',
                      textAlign: TextAlign.center, // Centra el texto
                      style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16.0,
                          fontFamily: 'Times New Roman'),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
