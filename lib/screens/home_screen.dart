import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sam_maker/screens/info_game.dart';
import 'package:sam_maker/services/database_service.dart';
import 'package:sam_maker/utils/colors.dart';

class HomeScreen extends StatefulWidget {
  final ValueNotifier<int> pageIndexNotifier;

  HomeScreen({Key? key, required this.pageIndexNotifier}) : super(key: key);


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController name = TextEditingController();

  final List<Map<String, String>> games = [
    {
      'title': 'Título jogo 1',
      'description': 'Descrição do Jogo 1. Detalhes sobre o jogo e como jogar.',
      'route': '/game1',
    },
    {
      'title': 'Título jogo 2',
      'description': 'Descrição do Jogo 2. Detalhes sobre o jogo e como jogar.',
      'route': '/game2',
    },
    {
      'title': 'Título jogo 3',
      'description': 'Descrição do Jogo 3. Detalhes sobre o jogo e como jogar.',
      'route': '/game3',
    },
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: AppColors.primaryColor,
          systemNavigationBarColor:  AppColors.primaryColor
        ),
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder(
          future: getUser(),
          builder: (context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                // Retorna um widget de Center.
                child:
                    CircularProgressIndicator(), // Indicador de progresso circular.
              );
            } else {
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
                          children: [
                            Image.asset('lib/utils/assets/images/sam_icon.png'),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Olá, ${snapshot.data['name']}!",
                                    style: TextStyle(
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.w500,
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
                        margin: const EdgeInsets.only(top: 24.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Jogos recomendados",
                                  style: TextStyle(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.w500,
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
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: games.length,
                              itemBuilder: (context, index) {
                                final game = games[index];
                                return Container(
                                  margin: const EdgeInsets.only(top: 12.0),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4.0),
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
                                      // Navigator.pushNamed(context, game['route']!);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const InfoGame()),
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
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 2.0),
                                                child: Text(
                                                  game['title']!,
                                                  style: const TextStyle(
                                                    fontSize: 20.0,
                                                    color:
                                                        AppColors.textDarkColor,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                game['description']!,
                                                style: const TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.w300,
                                                  color:
                                                      AppColors.textDarkColor,
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
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          }),
    );
  }
}
