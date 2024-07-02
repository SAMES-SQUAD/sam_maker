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
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

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
            systemNavigationBarColor: AppColors.primaryColor,
          ),
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Text
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

              // Inputs
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      width: screenWidth * 0.8,
                      child: TextFormField(
                        cursorColor: AppColors.primaryColor,
                        controller: _nameController,
                        style: const TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 18.0,
                        ),
                        decoration: const InputDecoration(
                          label: Text(
                            'Nome de usuário',
                            style: TextStyle(
                              color: AppColors.textDarkColor,
                              fontSize: 18.0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30.0)),
                            borderSide: BorderSide(
                              color: AppColors.primaryColor,
                              style: BorderStyle.solid,
                              width: 2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30.0)),
                            borderSide: BorderSide(
                              color: AppColors.primaryColor,
                              style: BorderStyle.solid,
                              width: 2,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30.0)),
                            borderSide: BorderSide(
                              color: Colors.red,
                              style: BorderStyle.solid,
                              width: 2,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30.0)),
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
                          color: AppColors.primaryColor,
                          fontSize: 18.0,
                        ),
                        decoration: const InputDecoration(
                          label: Text(
                            'Email',
                            style: TextStyle(
                              color: AppColors.textDarkColor,
                              fontSize: 18.0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30.0)),
                            borderSide: BorderSide(
                              color: AppColors.primaryColor,
                              style: BorderStyle.solid,
                              width: 2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30.0)),
                            borderSide: BorderSide(
                              color: AppColors.primaryColor,
                              style: BorderStyle.solid,
                              width: 2,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30.0)),
                            borderSide: BorderSide(
                              color: Colors.red,
                              style: BorderStyle.solid,
                              width: 2,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30.0)),
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
                          color: AppColors.primaryColor,
                          fontSize: 18.0,
                        ),
                        decoration: InputDecoration(
                          label: const Text(
                            'Senha',
                            style: TextStyle(
                              color: AppColors.textDarkColor,
                              fontSize: 18.0,
                            ),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30.0)),
                            borderSide: BorderSide(
                              color: AppColors.primaryColor,
                              style: BorderStyle.solid,
                              width: 2,
                            ),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30.0)),
                            borderSide: BorderSide(
                              color: AppColors.primaryColor,
                              style: BorderStyle.solid,
                              width: 2,
                            ),
                          ),
                          focusedErrorBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30.0)),
                            borderSide: BorderSide(
                              color: Colors.red,
                              style: BorderStyle.solid,
                              width: 2,
                            ),
                          ),
                          errorBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30.0)),
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
                        obscureText: !_isConfirmPasswordVisible,
                        style: const TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 18.0,
                        ),
                        decoration: InputDecoration(
                          label: const Text(
                            'Confirmar senha',
                            style: TextStyle(
                              color: AppColors.textDarkColor,
                              fontSize: 18.0,
                            ),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30.0)),
                            borderSide: BorderSide(
                              color: AppColors.primaryColor,
                              style: BorderStyle.solid,
                              width: 2,
                            ),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30.0)),
                            borderSide: BorderSide(
                              color: AppColors.primaryColor,
                              style: BorderStyle.solid,
                              width: 2,
                            ),
                          ),
                          focusedErrorBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30.0)),
                            borderSide: BorderSide(
                              color: Colors.red,
                              style: BorderStyle.solid,
                              width: 2,
                            ),
                          ),
                          errorBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30.0)),
                            borderSide: BorderSide(
                              color: Colors.red,
                              style: BorderStyle.solid,
                              width: 2,
                            ),
                          ),
                          errorStyle: const TextStyle(
                            color: Colors.red,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 20.0),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isConfirmPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: AppColors.primaryColor,
                            ),
                            onPressed: () {
                              setState(() {
                                _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                              });
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, confirme sua senha';
                          }
                          if (value != _passwordController.text) {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Text('As senhas não coincidem'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            });
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
                margin: const EdgeInsets.only(top: 35.0),
                width: screenWidth * 0.8,
                height: screenHeight * 0.075,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState?.validate() ?? false) {
                      setState(() {
                        isLoading = true;
                      });

                      // Chama a função de registro
                      await register(
                        _emailController.text,
                        _passwordController.text,
                        _nameController.text,
                      );

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

                      setState(() {
                        isLoading = false;
                      });
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        AppColors.primaryColor),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      ),
                    ),
                  ),
                  child: isLoading
                      ? const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              AppColors.primaryColor),
                        )
                      : const Text(
                          'Cadastrar',
                          style: TextStyle(
                            fontSize: 18.0,
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