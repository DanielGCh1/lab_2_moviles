import 'package:flutter/material.dart';
import 'package:lab_2_moviles/utilis/colors.dart';
import 'category_item.dart';
import 'students_list.dart';

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
        color: AppColors.menuSubColor,
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
                      color: AppColors.textActColor,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Georgia',
                    ),
                  ),
                ],
              ),
              accountEmail: null,
              currentAccountPicture: null,
            ),
            ...categories.map((category) {
              return CategoryItem(
                title: category['title']!,
                category: category['category']!,
                isSelected: selectedCategory == category['category'],
                onTap: onCategorySelected,
              );
            }).toList(),
            SizedBox(height: 16.0),
            StudentsList(),
          ],
        ),
      ),
    );
  }
}
