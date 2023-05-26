import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:lab_2_moviles/widgets/image_item.dart';
import 'package:lab_2_moviles/utilis/colors.dart';

class MasonryGridView extends StatelessWidget {
  final ScrollController scrollController;
  final List<String> images;
  final bool isLoading;
  final bool isScrollingDown;
  final Orientation orientation;
  final Function() fetchImages;

  const MasonryGridView({
    Key? key,
    required this.scrollController,
    required this.images,
    required this.isLoading,
    required this.isScrollingDown,
    required this.orientation,
    required this.fetchImages,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final crossAxisCount = orientation == Orientation.portrait ? 3 : 6;

    return AnimationLimiter(
      child: StaggeredGridView.countBuilder(
        controller: scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        crossAxisCount: crossAxisCount,
        itemCount: images.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index < images.length) {
            return ImageItem(
              imageUrl: images[index],
              isScrollingDown: isScrollingDown,
              crossAxisCount: crossAxisCount,
              index: index,
            );
          } else if (isLoading) {
            return Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(16.0),
              child: const CircularProgressIndicator(
                color: AppColors.menuPriColor,
              ),
            );
          } else {
            return Container();
          }
        },
        staggeredTileBuilder: (int index) {
          if (index < images.length) {
            return StaggeredTile.fit(
                orientation == Orientation.portrait ? 1 : 1);
          } else {
            return StaggeredTile.count(crossAxisCount, 1);
          }
        },
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
      ),
    );
  }
}
