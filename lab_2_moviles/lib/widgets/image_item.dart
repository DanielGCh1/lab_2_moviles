import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class ImageItem extends StatefulWidget {
  final String imageUrl;
  final bool isScrollingDown;
  final int crossAxisCount;
  final int index;

  const ImageItem({
    required this.imageUrl,
    required this.isScrollingDown,
    required this.crossAxisCount,
    required this.index,
    Key? key,
  }) : super(key: key);

  @override
  ImageItemState createState() => ImageItemState();
}

class ImageItemState extends State<ImageItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    // Iniciar la animación
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // Método para iniciar la animación de desaparición de la imagen
  void startDisappearAnimation() {
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return AnimationConfiguration.staggeredGrid(
      position: widget.index,
      columnCount: widget.crossAxisCount,
      duration: const Duration(milliseconds: 1500),
      child: ScaleTransition(
        scale: CurvedAnimation(
          parent: _animationController,
          curve: Interval(0.0, 1.0, curve: Curves.easeOut),
        ),
        child: FadeTransition(
          opacity: _animationController,
          child: SlideTransition(
            position: Tween<Offset>(
              begin:
                  widget.isScrollingDown ? Offset(0.0, 0.5) : Offset(0.0, -0.5),
              end: Offset.zero,
            ).animate(_animationController),
            child: SizeTransition(
              sizeFactor: CurvedAnimation(
                parent: _animationController,
                curve: Interval(0.0, 1.0, curve: Curves.easeOut),
              ),
              child: Container(
                margin: EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    widget.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
