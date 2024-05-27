import 'dart:js';

import 'package:flutter/material.dart';
import 'package:sam_maker/screens/login_screen.dart';
import 'package:sam_maker/screens/register_scree.dart';

class InitialScreen extends StatelessWidget {
  const InitialScreen({super.key});

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
              Center(
                child: Container(
                  child: Image.asset('lib/utils/assets/images/logo_sam.png'),
                ),
              ),
            
            Container(
              margin: const EdgeInsets.only(top: 10.0),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Theme.of(context).colorScheme.secondary,
                  ),
                  side: MaterialStateProperty.all(
                    BorderSide(
                      color: Theme.of(context).primaryColor,
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
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Entrar",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSecondary,
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
                    Theme.of(context).colorScheme.secondary,
                  ),
                  side: MaterialStateProperty.all(
                    BorderSide(
                      color: Theme.of(context).primaryColor,
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
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Cadastrar",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSecondary,
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
