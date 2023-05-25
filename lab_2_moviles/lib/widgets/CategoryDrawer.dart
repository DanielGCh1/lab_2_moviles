import 'package:flutter/material.dart';

class CategoryDrawer extends StatelessWidget {
  final String selectedCategory;
  final Function(String) onCategorySelected;

  const CategoryDrawer({
    Key? key,
    required this.selectedCategory,
    required this.onCategorySelected,
  }) : super(key: key);

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
          ListTile(
            title: Text('All'),
            onTap: () {
              Navigator.pop(context);
              onCategorySelected('All');
            },
            selected: selectedCategory == 'All',
          ),
          ListTile(
            title: Text('Nature'),
            onTap: () {
              Navigator.pop(context);
              onCategorySelected('Nature');
            },
            selected: selectedCategory == 'Nature',
          ),
          ListTile(
            title: Text('Food'),
            onTap: () {
              Navigator.pop(context);
              onCategorySelected('Food');
            },
            selected: selectedCategory == 'Food',
          ),
          ListTile(
            title: Text('Architecture'),
            onTap: () {
              Navigator.pop(context);
              onCategorySelected('Architecture');
            },
            selected: selectedCategory == 'Architecture',
          ),
          ListTile(
            title: Text('Travel'),
            onTap: () {
              Navigator.pop(context);
              onCategorySelected('Travel');
            },
            selected: selectedCategory == 'Travel',
          ),
        ],
      ),
    );
  }
}
