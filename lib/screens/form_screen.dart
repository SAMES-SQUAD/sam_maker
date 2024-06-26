import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sam_maker/services/database_service.dart';
import 'package:sam_maker/utils/colors.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  int _index = 0;

  // Listas para armazenar os materiais e áreas selecionados pelo usuário
  List<String> selectedMaterials = [];
  List<String> selectedAreas = [];

  // Listas de opções de materiais e áreas
  final List<String> materials = ['Lápis', 'Papel', 'Cola', 'Tesoura', 'Tinta'];
  final List<String> areas = ['Alfabetização', 'Lógica', 'Coordenação Motora', 'Socialização', 'Raciocínio'];

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
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.06),
          child: Column(
            children: [
              Expanded(
                child: Stepper(
                  currentStep: _index,
                  onStepCancel: () {
                    if (_index > 0) {
                      setState(() {
                        _index -= 1;
                      });
                    }
                  },
                  onStepContinue: () {
                    if (_index < 1) {
                      setState(() {
                        _index += 1;
                      });
                    }
                  },
                  onStepTapped: (int index) {
                    setState(() {
                      _index = index;
                    });
                  },
                  steps: <Step>[
                    Step(
                      title: const Text('Materiais'),
                      content: Column(
                        children: materials.map((material) {
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
                          );
                        }).toList(),
                      ),
                    ),
                    Step(
                      title: const Text('Habilidades'),
                      content: Column(
                        children: areas.map((area) {
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
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  // Combine as seleções de materiais e áreas em um único array
                  List<String> preferencia = [...selectedMaterials, ...selectedAreas];
                  
                  // Chame a função jogoRecomendado com as preferências do usuário
                  var resultado = await jogoRecomendado(preferencia);
                  print(resultado); // Imprime o resultado no console para verificação
                },
                child: const Text('Testar Função'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
