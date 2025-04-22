import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key, required this.currentIndex});

  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BottomNavigationBar(
        elevation: 0,
        onTap: (value) => _onItemTappped(context, value),
        currentIndex: currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home_max),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.label_outline),
            label: 'Categorías',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.favorite_outline),
            label: 'Favoritos',
          ),
        ],
      ),
    );
  }

  void _onItemTappped(BuildContext context, int index) {
    context.go('/home/$index');
  }
}
