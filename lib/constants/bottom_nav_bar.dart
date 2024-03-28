import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScaffoldWithNestedNavigation extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  final bool showBottomNavBar;

  const ScaffoldWithNestedNavigation({
    Key? key,
    required this.navigationShell,
    this.showBottomNavBar = true,
  }) : super(key: key);

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: showBottomNavBar
          ? NavigationBar(
              selectedIndex: navigationShell.currentIndex,
              destinations: const [
                NavigationDestination(
                    label: 'Category', icon: Icon(Icons.category_outlined)),
                NavigationDestination(
                    label: 'Brand', icon: Icon(Icons.insert_page_break)),
                NavigationDestination(
                    label: 'Cart', icon: Icon(Icons.shopping_cart_outlined)),
              ],
              onDestinationSelected: _goBranch,
              backgroundColor: Colors.white,
            )
          : null,
    );
  }
}
