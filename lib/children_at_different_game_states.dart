import 'package:flutter/material.dart';

final Widget gameStartChild = Container(
  width: 320,
  height: 320,
  padding: const EdgeInsets.all(32),
  child: Center(
    child: Text(
      "Tap to start the Game!\nDo not Touch Walls:)",
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.white, fontSize: 30.0),
    ),
  ),
);

final Widget gameRunningChild = Container(
  width: 15.5,
  height: 15.5,
  decoration: new BoxDecoration(
    color: const Color(0xff1cff40),
    shape: BoxShape.rectangle,
  ),
);

final Widget newSnakePointInGame = Container(
  width: 20.0,
  height: 20.0,
  
  decoration: new BoxDecoration(
    // color: const Color(0xff1cff40),
    // border: new Border.all(color: Colors.white),
    // borderRadius: BorderRadius.circular(20),
    image: DecorationImage(image: AssetImage("assets/apple.png"), fit: BoxFit.cover)
  ),
);

//class which gives the snake HEAD
class Point {
  late double x;
  late double y;

  Point(double x, double y) {
    this.x = x;
    this.y = y;
  }
}
