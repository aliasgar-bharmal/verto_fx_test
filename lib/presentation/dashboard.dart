import 'package:flutter/material.dart';
import 'package:test_verto/presentation/post/view/posts_view.dart';
import 'package:test_verto/presentation/article/view/articles_view.dart';
import 'package:test_verto/presentation/product/view/products_view.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [
        const PostsView(),
        const ProductsView(),
        const ArticlesView()
      ][index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        elevation: 0,
        backgroundColor: Colors.transparent,
        enableFeedback: false,
        onTap: (index) {
          setState(() {
            this.index = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.copy_all_rounded),
            label: "Posts",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.copy_all_rounded),
            label: "Products",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.photo_size_select_actual),
            label: "Articles",
          ),
        ],
      ),
    );
  }
}
