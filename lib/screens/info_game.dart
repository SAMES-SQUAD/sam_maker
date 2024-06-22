import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sam_maker/utils/colors.dart';

class InfoGame extends StatefulWidget {
  const InfoGame({super.key});

  @override
  State<InfoGame> createState() => _InfoGameState();
}

class _InfoGameState extends State<InfoGame> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
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
              decoration: const BoxDecoration(
                  color: AppColors.secondaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
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
                            "Título",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: Wrap(
                            spacing: 8.0,
                            children: [
                              Chip(
                                label: Text(
                                  "Tag1",
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
                                  side: BorderSide(color: Colors.transparent)
                                ),
                                visualDensity: VisualDensity(vertical:-4.0), // Ajuste o valor conforme necessário
                              ),
                              Padding(
                          padding: EdgeInsets.only(bottom: 8.0),
                                child: Chip(
                                  label: Text(
                                    "Tag2",
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
                                    side: BorderSide(color: Colors.transparent)
                                  ),
                                  visualDensity: VisualDensity(vertical:-4.0), // Ajuste o valor conforme necessário
                                ),
                              ),
                              Chip(
                                label: Text(
                                  "Tag3",
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
                                  side: BorderSide(color: Colors.transparent)
                                ),
                                visualDensity: VisualDensity(vertical:-4.0), // Ajuste o valor conforme necessário
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "Breve descrição da atividade",
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                          color: AppColors.redLight,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10))),
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Passo 1: Explicação do passo 1",
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi felis massa, faucibus et augue ac, iaculis maximus ipsum. Suspendisse et malesuada quam.",
                                            style: TextStyle(
                                                color: AppColors.textDarkColor,
                                                fontSize: 18.0),
                                          ),
                                          SizedBox(height: 10),
                                          Image.asset('assets/passo1.png'),
                                        ],
                                      ),
                                    ),
                                  ]),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Passo 1: Explicação do passo 1",
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi felis massa, faucibus et augue ac, iaculis maximus ipsum. Suspendisse et malesuada quam.",
                                            style: TextStyle(
                                                color: AppColors.textDarkColor,
                                                fontSize: 18.0),
                                          ),
                                          SizedBox(height: 10),
                                          Image.asset('assets/passo1.png'),
                                        ],
                                      ),
                                    ),
                                  ]),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Passo 1: Explicação do passo 1",
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi felis massa, faucibus et augue ac, iaculis maximus ipsum. Suspendisse et malesuada quam.",
                                            style: TextStyle(
                                                color: AppColors.textDarkColor,
                                                fontSize: 18.0),
                                          ),
                                          SizedBox(height: 10),
                                          Image.asset('assets/passo1.png'),
                                        ],
                                      ),
                                    ),
                                  ]),
                            )
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
      ),
    );
  }
}
