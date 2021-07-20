import 'package:flutter/material.dart';
import 'game.dart';

//https://blog.geekyants.com/2d-snake-game-in-flutter-hummingbird-b25403a781f2

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Olden Days Snake Game',
      home: Home(),
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
        centerTitle: true,
      ),
      backgroundColor: Colors.brown[500],
      body: Game(),
    );
  }
}
