import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sam_maker/utils/colors.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  int _index = 0;

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
                content: Container(
                  alignment: Alignment.centerLeft,
                  child: const Text('Selecione os materiais que você possui em casa'),
                ),
              ),
              const Step(
                title: Text('Habilidades'),
                content: Text('Selecione as habilidade que você deseja trabalhar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}