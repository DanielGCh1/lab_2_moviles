import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lab_2_moviles/services/api_service.dart';
import 'package:lab_2_moviles/widgets/category_drawer.dart';
import 'package:lab_2_moviles/widgets/masonry_grid_view.dart';

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
                return MasonryGridView(
                  scrollController: _scrollController,
                  images: images,
                  isLoading: isLoading,
                  isScrollingDown: isScrollingDown,
                  orientation: orientation,
                  fetchImages: fetchImages,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}