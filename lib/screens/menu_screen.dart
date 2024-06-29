import 'package:flutter/material.dart';
import 'package:sam_maker/screens/form_screen.dart';
import 'package:sam_maker/screens/games_screen.dart';
import 'package:sam_maker/screens/home_screen.dart';
import 'package:sam_maker/screens/profile_screen.dart';
import 'package:sam_maker/services/database_service.dart';
import 'package:sam_maker/utils/colors.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final ValueNotifier<int> _pageIndexNotifier = ValueNotifier<int>(0);
  List<Map<String, dynamic>> recommendedGames = [];

  @override
  void dispose() {
    _pageIndexNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      HomeScreen(
        pageIndexNotifier: _pageIndexNotifier,
        recommendedGames: recommendedGames,
      ),
      const GamesScreen(),
      FormScreen(
        pageIndexNotifier: _pageIndexNotifier,
        onGamesRecommended: (games) {
          setState(() {
            recommendedGames = games;
          });
        },
      ),
      const ProfileScreen(),
    ];

    return Scaffold(
      bottomNavigationBar: ValueListenableBuilder<int>(
        valueListenable: _pageIndexNotifier,
        builder: (context, currentIndex, child) {
          return NavigationBar(
            backgroundColor: AppColors.secondaryColor,
            onDestinationSelected: (int index) {
              _pageIndexNotifier.value = index;
            },
            indicatorColor: AppColors.primaryColor,
            selectedIndex: currentIndex,
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
          );
        },
      ),
      body: ValueListenableBuilder<int>(
        valueListenable: _pageIndexNotifier,
        builder: (context, currentIndex, child) {
          return IndexedStack(
            index: currentIndex,
            children: _pages,
          );
        },
      ),
    );
  }
}
