import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sam_maker/screens/menu_screen.dart';
import 'package:sam_maker/services/database_service.dart';
import 'package:sam_maker/utils/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.secondaryColor,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: AppColors.primaryColor,
            systemNavigationBarColor:  AppColors.primaryColor
          ),
        ),
        backgroundColor: AppColors.secondaryColor,
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Text
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(bottom: 25.0),
                child: const Text(
                  "Entrar",
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),

              //Inputs
              Form(
                // key: _loginFormKey,
                child: Column(
                  children: [
                    Container(
                      width: screenWidth * 0.8,
                      child: TextFormField(
                        cursorColor: AppColors.primaryColor,
                        controller: _emailController,
                        style: const TextStyle(
                            color: AppColors.primaryColor, fontSize: 18.0),
                        decoration: const InputDecoration(
                          label: Text(
                            'Email',
                            style: TextStyle(
                              color: AppColors.textDarkColor,
                              fontSize: 18.0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                            borderSide: BorderSide(
                              color: AppColors.primaryColor,
                              style: BorderStyle.solid,
                              width: 2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                            borderSide: BorderSide(
                              color: AppColors.primaryColor,
                              style: BorderStyle.solid,
                              width: 2,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                            borderSide: BorderSide(
                              color: Colors.red,
                              style: BorderStyle.solid,
                              width: 2,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                            borderSide: BorderSide(
                              color: Colors.red,
                              style: BorderStyle.solid,
                              width: 2,
                            ),
                          ),
                          errorStyle: TextStyle(
                            color: Colors.red,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 20.0),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira seu email';
                          }
                          // Adicione validações adicionais de email se necessário
                          return null;
                        },
                      ),
                    ),
                    Container(
                      width: screenWidth * 0.8,
                      margin: const EdgeInsets.only(top: 15.0),
                      child: TextFormField(
                        cursorColor: AppColors.primaryColor,
                        controller: _passwordController,
                        obscureText: !_isPasswordVisible,
                        style: const TextStyle(
                            color: AppColors.primaryColor, fontSize: 18.0),
                        decoration: InputDecoration(
                          label: const Text(
                            'Senha',
                            style: TextStyle(
                              color: AppColors.textDarkColor,
                              fontSize: 18.0,
                            ),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                            borderSide: BorderSide(
                              color: AppColors.primaryColor,
                              style: BorderStyle.solid,
                              width: 2,
                            ),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                            borderSide: BorderSide(
                              color: AppColors.primaryColor,
                              style: BorderStyle.solid,
                              width: 2,
                            ),
                          ),
                          focusedErrorBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                            borderSide: BorderSide(
                              color: Colors.red,
                              style: BorderStyle.solid,
                              width: 2,
                            ),
                          ),
                          errorBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                            borderSide: BorderSide(
                              color: Colors.red,
                              style: BorderStyle.solid,
                              width: 2,
                            ),
                          ),
                          errorStyle: const TextStyle(
                            color: Colors.red,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 20.0),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: AppColors.primaryColor,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira sua senha';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),

              // Button
              Container(
                margin: const EdgeInsets.only(top: 25.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      AppColors.primaryColor,
                    ),
                    side: MaterialStateProperty.all(
                      const BorderSide(
                        color: AppColors.secondaryColor,
                        width: 2,
                      ),
                    ),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  onPressed: () async {
                    var checklogin = await login(
                        _emailController.text, _passwordController.text);

                    if (checklogin == true) {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return const MenuScreen();
                      }));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Email ou senha incorretos.'),
                          backgroundColor: Color.fromARGB(255, 195, 12, 12),
                        ),
                      );
                    }
                  },
                  child: Container(
                    width: screenWidth * 0.4,
                    alignment: Alignment.center,
                    child: const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text(
                        "Entrar",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.normal,
                          color: AppColors.secondaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: Stack(
          children: [
            FloatingActionButton(
              onPressed: () {
                // Implemente a funcionalidade do botão flutuante aqui
              },
              elevation: 0,
              child: Image.asset('lib/utils/assets/images/mini_logo_sam.png'),
              backgroundColor: Colors.transparent,
            ),
          ],
        ),
      ),
    );
  }
}
