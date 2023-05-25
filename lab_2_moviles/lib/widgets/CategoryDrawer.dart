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
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            margin: EdgeInsets.only(top: 20.0, bottom: 10.0),
          ),
          ListTile(
            title: Text('Filtros'),
          ),
          ...categories.map((category) {
            return ListTile(
              title: Text(category['title']!),
              onTap: () {
                Navigator.pop(context);
                onCategorySelected(category['category']!);
              },
              selected: selectedCategory == category['category'],
            );
          }).toList(),
        ],
      ),
    );
  }
}
