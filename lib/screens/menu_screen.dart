import 'package:flutter/material.dart';
import 'package:sam_maker/screens/form_screen.dart';
import 'package:sam_maker/screens/games_screen.dart';
import 'package:sam_maker/screens/home_screen.dart';
import 'package:sam_maker/screens/profile_screen.dart';
import 'package:sam_maker/utils/colors.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  int currentPageIndex = 0;

  final List<Widget> _pages = [
    HomeScreen(),
    GamesScreen(),
    FormScreen(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: AppColors.primaryColor,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home, color: AppColors.secondaryColor),
            icon: Icon(Icons.home_outlined),
            label: 'Início',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.play_arrow, color: AppColors.secondaryColor),
            icon: Icon(Icons.play_arrow_outlined),
            label: 'Jogos',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.library_books, color: AppColors.secondaryColor),
            icon: Icon(Icons.library_books_outlined),
            label: 'Formulário',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.supervised_user_circle, color: AppColors.secondaryColor),
            icon: Icon(Icons.supervised_user_circle_outlined),
            label: 'Perfil',
          ),
        ],
      ),
      body: IndexedStack(
        index: currentPageIndex,
        children: _pages,
      ),
    );
  }
}
