import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sam_maker/screens/info_game.dart';
import 'package:sam_maker/services/database_service.dart';
import 'package:sam_maker/utils/colors.dart';

class GamesScreen extends StatefulWidget {
  const GamesScreen({Key? key}) : super(key: key);

  @override
  State<GamesScreen> createState() => _GamesScreenState();
}

class _GamesScreenState extends State<GamesScreen> {
  String searchValue = '';
  List<Map<String, dynamic>> searchResults = [];

  Future<void> _fetchGameByTitle(String title) async {
    List<Map<String, dynamic>> games = await getGameByTitle(title);
    setState(() {
      searchResults = games;
    });
  }

  Future<List<Map<String, dynamic>>> _fetchAllGames() async {
    return await getAllGames();
  }


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: screenWidth * 0.01,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: AppColors.primaryColor,
        ),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(screenWidth * 0.06),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchBar(
                backgroundColor:
                    MaterialStateProperty.all<Color>(AppColors.secondaryColor),
                padding: const MaterialStatePropertyAll<EdgeInsets>(
                  EdgeInsets.symmetric(horizontal: 16.0),
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    side: BorderSide.none,
                  ),
                ),
                elevation: MaterialStateProperty.all<double>(4.0),
                onChanged: (value) {
                  setState(() {
                    searchValue = value;
                  });
                  _fetchGameByTitle(value); // Atualiza os resultados da busca
                },
                leading: const Icon(Icons.search),
              ),
              if (searchValue.isEmpty)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Text(
                          'Todos os jogos',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                      FutureBuilder<List<Map<String, dynamic>>>(
                        future: _fetchAllGames(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text('Erro ao buscar os jogos'));
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return Center(
                                child: Text('Nenhum jogo encontrado'));
                          } else {
                            final games = snapshot.data!;
                            return Expanded(
                              child: ListView.builder(
                                itemCount: games.length,
                                itemBuilder: (context, index) {
                                  final game = games[index];
                                  return Container(
                                    margin: const EdgeInsets.only(
                                      top: 8.0,
                                      bottom: 14.0,
                                      left: 16.0,
                                      right: 16.0,
                                    ),
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
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => InfoGame(game_title: game['game_title']!),
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
                                                  padding: const EdgeInsets.symmetric(vertical: 2.0),
                                                  child: Text(
                                                    game['game_title']!,
                                                    style: const TextStyle(
                                                      fontSize: 20.0,
                                                      color: AppColors.textDarkColor,
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  game['game_description'] ?? 'Sem descrição',
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
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              if (searchValue.isNotEmpty)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Text(
                          'Resultados da pesquisa',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: searchResults.length,
                          itemBuilder: (context, index) {
                            final game = searchResults[index];
                            return Container(
                              margin: const EdgeInsets.only(
                                top: 8.0,
                                bottom: 14.0,
                                left: 16.0,
                                right: 16.0,
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 4.0),
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
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => InfoGame(game_title: game['game_title']!),
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
                                            padding: const EdgeInsets.symmetric(vertical: 2.0),
                                            child: Text(
                                              game['game_title']!,
                                              style: const TextStyle(
                                                fontSize: 20.0,
                                                color: AppColors.textDarkColor,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            game['game_description'] ?? 'Sem descrição',
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
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
