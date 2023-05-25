import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class ImageItem extends StatelessWidget {
  final String imageUrl;
  final bool isScrollingDown;
  final int crossAxisCount;
  final int index;

  const ImageItem({
    required this.imageUrl,
    required this.isScrollingDown,
    required this.crossAxisCount,
    required this.index,
  });

  static const animationDuration = Duration(milliseconds: 500);

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(8.0);

    return AnimationConfiguration.staggeredGrid(
      position: index,
      columnCount: crossAxisCount,
      duration: animationDuration,
      child: ScaleAnimation(
        child: FadeInAnimation(
          child: SlideAnimation(
            verticalOffset: isScrollingDown ? 50.0 : -50.0,
            child: Container(
              margin: EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: borderRadius,
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
