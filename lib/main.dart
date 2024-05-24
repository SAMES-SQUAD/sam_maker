import 'package:flutter/material.dart';
import 'package:sam_maker/screens/initial_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: const ColorScheme(
            brightness: Brightness.light,
            primary:  Color.fromRGBO(237, 109, 34, 1),
            onPrimary:  Color.fromRGBO(246, 246, 246, 1),
            secondary:  Color.fromRGBO(246, 246, 246, 1),
            onSecondary:  Color.fromRGBO(237, 109, 34, 1),
            error:  Color.fromRGBO(237, 41, 41, 1),
            onError:  Color.fromRGBO(246, 246, 246, 1),
            background:  Color.fromRGBO(246, 246, 246, 1),
            onBackground:  Color.fromRGBO(237, 109, 34, 1),
            surface:  Color.fromRGBO(237, 109, 34, 1), //surface: background color for widgets like Card
            onSurface:  Color.fromRGBO(246, 246, 246, 1)),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const InitialScreen(),
    );
  }
}
