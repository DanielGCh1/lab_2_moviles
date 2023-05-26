import 'package:flutter/material.dart';
import 'package:lab_2_moviles/utilis/colors.dart';

class CategoryItem extends StatelessWidget {
  final String title;
  final String category;
  final bool isSelected;
  final Function(String) onTap;

  const CategoryItem({
    Key? key,
    required this.title,
    required this.category,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: InkWell(
        onTap: () => onTap(category),
        child: Container(
          color: isSelected ? AppColors.menuPriColor : Colors.transparent,
          child: ListTile(
            title: Text(
              title,
              style: TextStyle(
                color: isSelected
                    ? AppColors.textActColor
                    : AppColors.textDesColor,
                fontSize: 16.0,
                fontFamily: 'Georgia',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
