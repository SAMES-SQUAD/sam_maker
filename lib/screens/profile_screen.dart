import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sam_maker/screens/initial_screen.dart';
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
    await logout(); // Chama a função de logout do Firebase
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    // Navega para a tela de login e remove todas as rotas anteriores
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
                          onPressed: () => {
                            logout(),
                             Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                            return const InitialScreen();
                          }))
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
        child: Icon(isEditing ? Icons.save : Icons.edit, color: AppColors.secondaryColor,),
        backgroundColor: AppColors.primaryColor,
      ),
    );
  }
}
