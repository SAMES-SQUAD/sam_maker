import 'package:flutter/material.dart';
import 'package:sam_maker/screens/login_screen.dart';
import 'package:sam_maker/screens/register_scree.dart';
import 'package:sam_maker/utils/colors.dart';

class InitialScreen extends StatelessWidget {
  const InitialScreen({super.key});

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
              Center(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 10.0),
                  child: Image.asset('lib/utils/assets/images/logo_sam.png'),
                ),
              ),
            
            Container(
              margin: const EdgeInsets.only(top: 10.0),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    AppColors.secondaryColor,
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
                onPressed: () =>
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const LoginScreen();
                })),
                child: Container(
                  width: screenWidth * 0.4,
                  alignment: Alignment.center,
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Entrar",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.normal,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            Container(
              margin: const EdgeInsets.only(top: 10.0),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    AppColors.secondaryColor,
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
                onPressed: () =>
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const RegisterScreen();
                })),
                child: Container(
                  width: screenWidth * 0.4,
                  alignment: Alignment.center,
                  child: const Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Cadastrar",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.normal,
                        color: AppColors.primaryColor,
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
}
