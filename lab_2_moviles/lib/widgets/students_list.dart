import 'package:flutter/material.dart';
import 'package:lab_2_moviles/utilis/colors.dart';

class StudentsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.menuPriColor,
      child: Column(
        children: [
          ListTile(
            title: Text(
              '\nLABORATORIO 2 \n\nEstudiantes:\n',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.textActColor,
                fontSize: 16.0,
                fontFamily: 'Times New Roman',
              ),
            ),
          ),
          ListTile(
            title: Text(
              'Daniel Gómez\n\nNatalia Rojas\n\nDiego Jiménez\n\nLibny Gómez\n',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.textDesColor,
                fontSize: 16.0,
                fontFamily: 'Times New Roman',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
