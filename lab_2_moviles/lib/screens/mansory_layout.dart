import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:lab_2_moviles/services/api_service.dart';
import 'package:lab_2_moviles/widgets/category_drawer.dart';
import 'package:lab_2_moviles/widgets/image_item.dart';

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

      final newImages = await APIService.fetchImages(selectedCategory, page);

      setState(() {
        images.addAll(newImages);
        isLoading = false;
        page++;
      });
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
        title: Text(selectedCategory, style: TextStyle(fontFamily: 'Georgia')),
      ),
      drawer: CategoryDrawer(
        selectedCategory: selectedCategory,
        onCategorySelected: onCategorySelected,
      ),
      body: Column(
        children: [
          Expanded(
            child: OrientationBuilder(
              builder: (context, orientation) {
                final crossAxisCount =
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? 3
                        : 6;
                orientation == Orientation.portrait ? 3 : 6;
                return AnimationLimiter(
                  child: StaggeredGridView.countBuilder(
                    controller: _scrollController,
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
                            color: Colors.teal,
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
                        return StaggeredTile.count(crossAxisCount, 1);
                      }
                    },
                    mainAxisSpacing: 8.0,
                    crossAxisSpacing: 8.0,
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
