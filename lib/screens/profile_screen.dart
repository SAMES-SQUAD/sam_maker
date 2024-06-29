import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sam_maker/screens/initial_screen.dart';
import 'package:sam_maker/screens/login_screen.dart';
import 'package:sam_maker/services/database_service.dart';
import 'package:sam_maker/utils/colors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isEditing = false;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  void showSuccessSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Edição realizada com sucesso!'),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.green,
      ),
    );
  }

  void logoutUser(BuildContext context) async {
    await logout();
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }

  Future<void> _showDeleteConfirmationDialog(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false, // impede fechar clicando fora do dialog
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirmar exclusão"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    'Tem certeza que deseja deletar sua conta? Essa ação não poderá ser revertida.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    AppColors.redLight), // Cor de fundo do botão
              ),
              child: Text(
                'Cancelar',
                style: TextStyle(
                  color: Colors.white, // Cor do texto
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    AppColors.greenLight), // Cor de fundo do botão
              ),
              child: Text('Confirmar',
                style: TextStyle(
                  color: Colors.white, // Cor do texto
                ),),
              onPressed: () async {
                await deleteAccount();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InitialScreen(),
                  ),
                  (route) => false,
                );
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> deleteAccount() async {
    try {
      await deleteUser(); // chama o método para deletar o usuário
    } catch (e) {
      // Tratar erros, se necessário
      print("Erro ao deletar conta: $e");
    }
  }

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
      body: FutureBuilder(
        future: getUser(),
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Erro ao carregar os dados"),
            );
          } else {
            nameController.text = snapshot.data['name'];
            emailController.text = snapshot.data['email'];
            return SafeArea(
              child: Padding(
                padding: EdgeInsets.all(screenWidth * 0.06),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Perfil',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textDarkColor,
                          ),
                        ),
                        Spacer(),
                        IconButton(
                          onPressed: () {
                            logout();
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return const InitialScreen();
                              }),
                            );
                          },
                          icon: Icon(Icons.logout),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: nameController,
                      enabled: isEditing,
                      decoration: InputDecoration(
                        labelText: "Nome",
                        labelStyle: TextStyle(
                          color: AppColors.textDarkColor,
                        ),
                        border: OutlineInputBorder(),
                      ),
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.normal,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: emailController,
                      enabled: isEditing,
                      decoration: InputDecoration(
                        labelText: "Email",
                        labelStyle: TextStyle(
                          color: AppColors.textDarkColor,
                        ),
                        border: OutlineInputBorder(),
                      ),
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.normal,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10.0),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            AppColors.primaryColor,
                          ),
                          side: MaterialStateProperty.all(
                            const BorderSide(
                              color: AppColors.secondaryColor,
                              width: 1,
                            ),
                          ),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                        onPressed: () {
                          _showDeleteConfirmationDialog(context);
                        },
                        child: Container(
                          width: screenWidth * 0.4,
                          alignment: Alignment.center,
                          child: const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Text(
                              "Deletar conta",
                              style: TextStyle(
                                fontSize: 18.0,
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
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (isEditing) {
            await editUser(nameController.text, emailController.text);
            showSuccessSnackbar(context);
          }
          setState(() {
            isEditing = !isEditing;
          });
        },
        child: Icon(isEditing ? Icons.save : Icons.edit,
            color: AppColors.secondaryColor),
        backgroundColor: AppColors.primaryColor,
      ),
    );
  }
}
