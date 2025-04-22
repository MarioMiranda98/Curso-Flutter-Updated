import 'package:flutter/material.dart';

import 'package:cinemapedia/src/presentation/views/views.dart';
import 'package:cinemapedia/src/presentation/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  static const String name = "home_screen";

  const HomeScreen({super.key, required this.pageIndex});

  final int pageIndex;

  final viewRoutes = const [HomeView(), SizedBox(), FavoritesView()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: pageIndex, children: viewRoutes),
      bottomNavigationBar: CustomBottomNavigationBar(currentIndex: pageIndex),
    );
  }
}
