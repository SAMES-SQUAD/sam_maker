import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sam_maker/services/database_service.dart';
import 'package:sam_maker/utils/colors.dart';

class InfoGame extends StatefulWidget {
  const InfoGame({Key? key, required this.game_title}) : super(key: key);
  final String game_title;

  @override
  State<InfoGame> createState() => _InfoGameState();
}

class _InfoGameState extends State<InfoGame> {
  Future<Map<String, dynamic>?> _fetchGameData() async {
    return await getStepsByGame(widget.game_title);
  }

  Color getBackgroundColor(String category) {
    switch (category) {
      case 'Alfabetização':
        return AppColors.greenLight; 
      case 'Raciocínio lógico':
        return AppColors.blueLight;
      case 'Coordenação Motora':
        return AppColors.purpleLigt;
      case 'Socialização':
        return AppColors.redLight;
      default:
        return AppColors.secondaryColor; 
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: FutureBuilder<Map<String, dynamic>?>(
        future: _fetchGameData(),
        builder: (context, AsyncSnapshot<Map<String, dynamic>?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('No game found with title: ${widget.game_title}'));
          }

          var gameData = snapshot.data!;

          // Ordenar os passos pelo campo 'order'
          List<dynamic> sortedSteps = List.from(gameData['Steps']);
          sortedSteps.sort((a, b) => a['order'].compareTo(b['order']));

          // Obtém a cor de fundo com base na categoria do jogo
          Color backgroundColor = getBackgroundColor(gameData['game_category'] ?? '');

          return SafeArea(
            child: Container(
              padding: EdgeInsets.all(screenWidth * 0.06),
              width: screenWidth,
              height: screenHeight,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.secondaryColor,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10.0,
                      spreadRadius: 1.0,
                      offset: Offset(0, 2),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.secondaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 4.0, bottom: 4.0, top: 4.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            IconButton(
                              icon: Icon(Icons.arrow_back),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 24.0, right: 16.0, bottom: 12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                gameData['game_title'] ?? "Jogo sem nome",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Wrap(
                              spacing: 8.0,
                              children: (gameData['tags'] as List<dynamic>? ?? [])
                                  .map((tag) {
                                return Padding(
                                  padding: EdgeInsets.only(bottom: 8.0),
                                  child: Chip(
                                    label: Text(
                                      tag.toString(), // Ajuste conforme a estrutura dos seus dados
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        color: AppColors.secondaryColor,
                                        letterSpacing: 1.0,
                                      ),
                                    ),
                                    labelPadding: EdgeInsets.symmetric(
                                        vertical: 0, horizontal: 8.0),
                                    backgroundColor: AppColors.primaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                      side: BorderSide(color: Colors.transparent),
                                    ),
                                    visualDensity: VisualDensity(vertical: -4.0),
                                  ),
                                );
                              }).toList(),
                            ),
                            Text(
                              gameData['game_description'] ?? "Jogo sem descrição",
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: backgroundColor, // Define a cor de fundo dinamicamente
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                          ),
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                for (var step in sortedSteps)
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Passo ${step['order']}: ${step['step_title']}",
                                          style: TextStyle(
                                            color: AppColors.secondaryColor,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: AppColors.secondaryColor,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          padding: const EdgeInsets.all(16.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                step['step_description'] ?? "",
                                                style: TextStyle(
                                                  color: AppColors.textDarkColor,
                                                  fontSize: 18.0,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
