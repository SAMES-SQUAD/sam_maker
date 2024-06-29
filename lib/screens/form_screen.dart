import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sam_maker/services/database_service.dart';
import 'package:sam_maker/utils/colors.dart';

class FormScreen extends StatefulWidget {
  final ValueNotifier<int> pageIndexNotifier;
  final Function(List<Map<String, dynamic>>) onGamesRecommended;

  const FormScreen({
    Key? key,
    required this.pageIndexNotifier,
    required this.onGamesRecommended,
  }) : super(key: key);

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  List<String> selectedMaterials = [];
  List<String> selectedAreas = [];

  final List<String> materials = ['Lápis', 'Papel', 'Cola', 'Tesoura', 'Tinta'];
  final List<String> areas = [
    'Alfabetização',
    'Coordenação Motora',
    'Socialização',
    'Raciocínio Lógico'
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: screenWidth * 0.01,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: AppColors.primaryColor,
          systemNavigationBarColor: AppColors.primaryColor,
        ),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.06),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Formulário de recomendação',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryColor,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'O formulário de recomendação te ajuda a encontrar o jogo perfeito para o momento, considerando os materiais que você possui em casa e as habilidades que deseja trabalhar nos pequenos.',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 20.0),
              Text(
                'Selecione abaixo os materiais que você possui em casa:',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: materials.length,
                  itemBuilder: (context, index) {
                    final material = materials[index];
                    return CheckboxListTile(
                      title: Text(material),
                      value: selectedMaterials.contains(material),
                      onChanged: (bool? value) {
                        setState(() {
                          if (value == true) {
                            selectedMaterials.add(material);
                          } else {
                            selectedMaterials.remove(material);
                          }
                        });
                      },
                      activeColor: AppColors.primaryColor, 
                      checkColor: Colors.white, 
                    );
                  },
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                'Selecione as habilidades que deseja trabalhar e desenvolver:',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: areas.length,
                  itemBuilder: (context, index) {
                    final area = areas[index];
                    return CheckboxListTile(
                      title: Text(area),
                      value: selectedAreas.contains(area),
                      onChanged: (bool? value) {
                        setState(() {
                          if (value == true) {
                            selectedAreas.add(area);
                          } else {
                            selectedAreas.remove(area);
                          }
                        });
                      },
                      activeColor: AppColors.primaryColor, 
                      checkColor: Colors.white, 
                    );
                  },
                ),
              ),
              SizedBox(height: 20.0),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(AppColors.primaryColor),
                    side: MaterialStateProperty.all(
                        BorderSide(color: AppColors.secondaryColor, width: 2)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30))),
                  ),
                  onPressed: () async {
                    List<String> preferences = [
                      ...selectedMaterials,
                      ...selectedAreas
                    ];
                    var result = await jogoRecomendado(preferences);
                    print(result);

                    setState(() {
                      selectedMaterials.clear();
                      selectedAreas.clear();
                    });

                    widget.onGamesRecommended(result);
                    widget.pageIndexNotifier.value = 0;
                  },
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text(
                      "Enviar Respostas",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.normal,
                        color: AppColors.secondaryColor,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
