import 'package:flutter/material.dart';
import 'package:sam_maker/screens/games_screen.dart';
import 'package:sam_maker/utils/colors.dart';
import 'package:sam_maker/screens/form_screen.dart';
import 'package:sam_maker/screens/games_screen.dart';
import 'package:sam_maker/screens/home_screen.dart';
import 'package:sam_maker/screens/profile_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> tags = ["Tinta", "Massinha", "Papel", "Ar Livre", "Água"];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
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
                  offset: const Offset(0, 3), // changes position of shadow
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
              children: [
                Image.asset('lib/utils/assets/images/sam_icon.png'),
                const Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Olá, <nome>",
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
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 24.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Jogos recomendados",
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const GamesScreen()),
                        );
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
                Container(
                  margin: const EdgeInsets.only(top: 12.0),
                  transformAlignment: AlignmentDirectional.center,
                  decoration: BoxDecoration(
                    color: AppColors.secondaryColor,
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.textDarkColor.withOpacity(0.2),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
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
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 4.0),
                              child: Text(
                                "Título do jogo",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: AppColors.textDarkColor,
                                ),
                              ),
                            ),
                            Wrap(
                              spacing: 6.0,
                              runSpacing: 4.0,
                              children: tags
                                  .map(
                                    (tag) => Text(
                                      tag,
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w300,
                                        color: AppColors.textDarkColor,
                                      ),
                                    ),
                                  )
                                  .toList(),
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
              ],
            ),
          )
        ],
      ),
    );
  }
}
