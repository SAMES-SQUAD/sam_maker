import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sam_maker/screens/login_screen.dart';
import 'package:sam_maker/services/database_service.dart';
import 'package:sam_maker/utils/colors.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isLoading = false;
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
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
        backgroundColor: AppColors.secondaryColor,
        appBar: AppBar(
          backgroundColor: AppColors.secondaryColor,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: AppColors.primaryColor,
          systemNavigationBarColor:  AppColors.primaryColor
        ),
      ),
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
                  "Cadastrar",
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
                        controller: _nameController,
                        style: const TextStyle(
                            color: AppColors.primaryColor, fontSize: 18.0),
                        decoration: const InputDecoration(
                          label: Text(
                            'Nome de usuário',
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
                            return 'Por favor, insira seu nome';
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

                    Container(
                      width: screenWidth * 0.8,
                      margin: const EdgeInsets.only(top: 15.0),
                      child: TextFormField(
                        cursorColor: AppColors.primaryColor,
                        controller: _confirmPasswordController,
                        obscureText: !_isPasswordVisible,
                        style: const TextStyle(
                            color: AppColors.primaryColor, fontSize: 18.0),
                        decoration: InputDecoration(
                          label: const Text(
                            'Confimar senha',
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

                        // ajeitar essa verificação pra comparar se a senha ta igual
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira sua senha';
                          }
                          if (value != _passwordController.text) {
                            return 'As senhas não coincidem';
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

                    register(
                      _emailController.text,
                      _passwordController.text,
                      _nameController.text,
                    );

                    // Define o que acontece quando o botão é pressionado
                    setState(() {
                      // Atualiza o estado da tela
                      isLoading = true; // Define isLoading como true
                    });

                    // Navega para a tela de login após o registro
                    Navigator.push(context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                    );

                    // Exibe uma mensagem após o registro
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Usuário cadastrado com sucesso'),
                      backgroundColor: Colors.green,
                    ));

                  },

                  child: Container(
                    width: screenWidth * 0.4,
                    alignment: Alignment.center,
                    child: const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text(
                        "Cadastrar",
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