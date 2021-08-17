import 'package:flutter/material.dart';
import 'game.dart';

/*

Article sur la base du code de ce snake :
https://blog.geekyants.com/2d-snake-game-in-flutter-hummingbird-b25403a781f2

*/

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Snake Game',
      home: Home(),
      //boolean pour activer la banière du mode debug
      debugShowCheckedModeBanner: false,
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Snake Game example"),
        backgroundColor: Colors.grey[850],
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[800],
      //body attend un widget donc appelle Game() un widget créer dans le fichier game.dart
      body: Game(),
    );
  }
}
