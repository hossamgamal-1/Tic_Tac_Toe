import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/view/game_screen.dart';
import '../controller/my_provider.dart';
import 'package:wakelock/wakelock.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  //Wakelock.enable();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyProvider(),
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Tic Tac Toe',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          canvasColor: const Color.fromARGB(255, 243, 245, 231),
          textTheme: const TextTheme(
            bodyText1: TextStyle(
              fontSize: 28,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            bodyText2: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        darkTheme: ThemeData(
          primarySwatch: Colors.blue,
          canvasColor: const Color(0xff000619),
          textTheme: const TextTheme(
            bodyText1: TextStyle(
              fontSize: 28,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            bodyText2: TextStyle(
              fontSize: 18,
              color: Colors.black,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        themeMode: ThemeMode.dark,
        home: const GameScreen(),
      ),
    );
  }
}
