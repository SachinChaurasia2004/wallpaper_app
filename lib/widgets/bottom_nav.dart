import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe/pages/categories.dart';
import 'package:tictactoe/pages/home.dart';
import 'package:tictactoe/pages/search.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int currentIndex = 0;

  late List<Widget> pages;
  late Home home;
  late Search search;
  late Categories categories;
  late Widget currentPage;

  @override
  void initState() {
    home = Home();
    search = Search();
    categories = Categories();
    pages = [home, search, categories];
    currentPage = Home();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: 65,
        color: Colors.amber,
        backgroundColor: Colors.white,
        animationDuration: Duration(milliseconds: 500),
        onTap: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          Icon(Icons.home_outlined),
          Icon(Icons.search_outlined),
          Icon(Icons.category_outlined)
        ],
      ),
      body: pages[currentIndex],
    );
  }
}
