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
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Image.asset(
                'logo-snake.jpg',
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
            ),
            ListTile(
              title: const Text('Jouer'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Options'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Scores'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      backgroundColor: Colors.grey[800],
      //body attend un widget donc appelle Game() un widget créer dans le fichier game.dart
      body: Game(),
    );
  }
}
