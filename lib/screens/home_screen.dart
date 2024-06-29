import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sam_maker/screens/info_game.dart';
import 'package:sam_maker/services/database_service.dart';
import 'package:sam_maker/utils/colors.dart';

class HomeScreen extends StatefulWidget {
  final ValueNotifier<int> pageIndexNotifier;
  final List<Map<String, dynamic>> recommendedGames;

  HomeScreen({Key? key, required this.pageIndexNotifier, required this.recommendedGames}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: AppColors.primaryColor,
          systemNavigationBarColor: AppColors.primaryColor,
        ),
        automaticallyImplyLeading: false,
      ),
      body: ValueListenableBuilder(
        valueListenable: userNotifier,
        builder: (context, Map<String, dynamic> user, _) {
          return SafeArea(
            child: Container(
              padding: EdgeInsets.all(screenWidth * 0.06),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.textDarkColor.withOpacity(0.2),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                        const BoxShadow(
                          color: AppColors.secondaryColor,
                          offset: Offset(0.0, 0.0),
                          blurRadius: 0.0,
                          spreadRadius: 0.0,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset('lib/utils/assets/images/sam_icon.png'),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Olá, ${user['name']}!",
                                style: TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                              Text(
                                "Pronto para se divertir com o Sam hoje?",
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.normal,
                                  color: AppColors.textDarkColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(top: 24.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Jogos recomendados",
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  widget.pageIndexNotifier.value = 1;
                                },
                                child: const Text(
                                  "Ver todos",
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: widget.recommendedGames.isNotEmpty
                                ? ListView.builder(
                                    itemCount: widget.recommendedGames.length,
                                    itemBuilder: (context, index) {
                                      final game = widget.recommendedGames[index];
                                      return Container(
                                        margin: const EdgeInsets.only(
                                            top: 8.0,
                                            bottom: 14.0,
                                            left: 16.0,
                                            right: 16.0),
                                        decoration: BoxDecoration(
                                          color: AppColors.secondaryColor,
                                          borderRadius: BorderRadius.circular(15.0),
                                          boxShadow: [
                                            BoxShadow(
                                              color: AppColors.textDarkColor
                                                  .withOpacity(0.2),
                                              spreadRadius: 5,
                                              blurRadius: 7,
                                              offset: const Offset(0, 3),
                                            ),
                                          ],
                                        ),
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => InfoGame(
                                                  game_title: game['game_title']!,
                                                ),
                                              ),
                                            );
                                          },
                                          child: Row(
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.all(16.0),
                                                child: const Icon(
                                                  Icons.book,
                                                  size: 50.0,
                                                  color: AppColors.primaryColor,
                                                ),
                                              ),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.symmetric(
                                                              vertical: 2.0),
                                                      child: Text(
                                                        game['game_title']!,
                                                        style: const TextStyle(
                                                          fontSize: 20.0,
                                                          color: AppColors.textDarkColor,
                                                        ),
                                                      ),
                                                    ),
                                                    Text(
                                                      game['game_description'] ??
                                                          'Sem descrição',
                                                      style: const TextStyle(
                                                        fontSize: 16.0,
                                                        fontWeight: FontWeight.w300,
                                                        color: AppColors.textDarkColor,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                padding: const EdgeInsets.all(16.0),
                                                child: const Icon(
                                                  Icons.play_circle,
                                                  size: 50.0,
                                                  color: AppColors.primaryColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  )
                                : const Center(
                                    child: Text('Nenhum jogo recomendado'),
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
