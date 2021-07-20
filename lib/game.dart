import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'children_at_different_game_states.dart';

/*
* les enum sont des listes, cf : https://www.tutorialspoint.com/dart_programming/dart_programming_enumeration.htm
* ici pour enregistrer les différents états et possibilités de directions du snake
*/
enum Direction { LEFT, RIGHT, UP, DOWN }
enum GameState { START, RUNNING, FAILURE }

/* 
* la class Game hérite du statefullWidget car c'est un widgets qui aura plusieurs états qui seront apparent à l'affichage avec la gestion du state : createState,initState et setState : 
* StateLess / StateFull / state
* Un Stateless Widget est un widget qui ne dépend pas d’autre chose que de ses propres informations qui lui sont fournies au moment de son build (par son parent) 
* Pour faire simple ce sont par exemple les widgets comme : Text, Row, Container, Column, Center…etc. Aucun événement utilisateur ne relancera le build d’un stateless widget
* A l’opposé, nous trouvons le Stateful Widget. De son côté, le stateful widget va générer des “données internes” qui changeront au cours du cycle de vie de ce widget. Les données incluses dans ce type de widget forment un ensemble que l’on nomme “State”
*/
class Game extends StatefulWidget {
  //on créer un état qui sera la class _GameState
  @override
  State<StatefulWidget> createState() => _GameState();
}

//la class _GameState hérite de state de la class Game dans lequel on va coder nos intéractions de jeu
class _GameState extends State<Game> {
  //On commence par définir les attributs de notre class _GameState
  var snakePosition;
  late Point newPointPosition;
  late Timer timer;
  Direction _direction = Direction.UP;
  var gameState = GameState.START;
  int score = 0;

  //ici le render du build de la page en prenant en compte le context
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
          width: 320,
          height: 320,
          padding: EdgeInsets.all(29),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/snake_bg.png"),
              fit: BoxFit.fill,
            ),
          ),
          /*
          * gestion de la détection d'évènements de gesture
          * https://flutter.dev/docs/development/ui/advanced/gestures
          */
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTapUp: (tapUpDetails) {
              _handleTap(tapUpDetails);
            },
            child: _getChildBasedOnGameState(),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 20.0, right: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: 100,
                height: 100,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(width: 1.0, color: Colors.red),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text(
                  "Score\n$score",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: 50),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _direction = Direction.UP;
                        });
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.green),
                      ),
                      child: Icon(Icons.keyboard_arrow_up),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _direction = Direction.LEFT;
                          });
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.yellow),
                        ),
                        child: Icon(Icons.keyboard_arrow_left),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _direction = Direction.RIGHT;
                            });
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.yellow),
                          ),
                          child: Icon(Icons.keyboard_arrow_right),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 50),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _direction = Direction.DOWN;
                        });
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.green),
                      ),
                      child: Icon(Icons.keyboard_arrow_down),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  /*
  * Ici les méthodes de _GameState
  */

  //méthode qui ne retourne rien. Elle est lancé lorsqu'on tap sur l'écran de jeu
  void _handleTap(TapUpDetails tapUpDetails) {
    switch (gameState) {
      case GameState.START:
        startToRunState();
        break;
      case GameState.RUNNING:
        break;
      case GameState.FAILURE:
        setGameState(GameState.START);
        break;
    }
  }

  //initalisation du jeu
  void startToRunState() {
    startingSnake();
    generatenewPoint();
    _direction = Direction.UP;
    setGameState(GameState.RUNNING);
    timer = new Timer.periodic(new Duration(milliseconds: 400), onTimeTick);
  }

  //initialiser le snake
  void startingSnake() {
    setState(() {
      final midPoint = (320 / 20 / 2);
      snakePosition = [
        Point(midPoint, midPoint - 1),
        Point(midPoint, midPoint),
        Point(midPoint, midPoint + 1),
      ];
    });
  }

  //génération du nouveau fruit
  void generatenewPoint() {
    setState(() {
      //on utilise le random, comme très souvent dans le jeu video pour définir les coordonnées du fruit à manger du snale
      Random rng = Random();
      var min = 0;
      var max = 320 ~/ 20;
      var nextX = min + rng.nextInt(max - min);
      var nextY = min + rng.nextInt(max - min);

      var newRedPoint = Point(nextX.toDouble(), nextY.toDouble());

      if (snakePosition.contains(newRedPoint)) {
        generatenewPoint();
      } else {
        //nouveau fruit pour le snake
        newPointPosition = newRedPoint;
      }
    });
  }

  void setGameState(GameState _gameState) {
    setState(() {
      gameState = _gameState;
    });
  }

  //Un Widget créer pour définir les comportements à la suite d'un tap sur l'écran de jeu
  Widget _getChildBasedOnGameState() {
    var child;
    switch (gameState) {
      case GameState.START:
        setState(() {
          score = 0;
        });
        child = gameStartChild;
        break;

      case GameState.RUNNING:
        List<Positioned> snakePiecesWithNewPoints = [];
        snakePosition.forEach(
          (i) {
            snakePiecesWithNewPoints.add(
              Positioned(
                child: gameRunningChild,
                left: i.x * 15.5,
                top: i.y * 15.5,
              ),
            );
          },
        );
        final latestPoint = Positioned(
          child: newSnakePointInGame,
          left: newPointPosition.x * 15.5,
          top: newPointPosition.y * 15.5,
        );
        snakePiecesWithNewPoints.add(latestPoint);
        child = Stack(children: snakePiecesWithNewPoints);
        break;

      case GameState.FAILURE:
        timer.cancel();
        child = Container(
          width: 320,
          height: 320,
          padding: const EdgeInsets.all(32),
          child: Center(
            child: Text(
              "You Scored: $score\nTap to play again!",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.red),
            ),
          ),
        );
        break;
    }
    return child;
  }

  //Comportement en fonction du temps
  void onTimeTick(Timer timer) {
    setState(() {
      snakePosition.insert(0, getLatestSnake());
      snakePosition.removeLast();
    });

    var currentHeadPos = snakePosition.first;
    if (currentHeadPos.x < 0 ||
        currentHeadPos.y < 0 ||
        currentHeadPos.x > 320 / 20 ||
        currentHeadPos.y > 320 / 20) {
      setGameState(GameState.FAILURE);
      return;
    }

    if (snakePosition.first.x == newPointPosition.x &&
        snakePosition.first.y == newPointPosition.y) {
      generatenewPoint();
      setState(() {
        if (score <= 10)
          score = score + 1;
        else if (score > 10 && score <= 25)
          score = score + 2;
        else
          score = score + 3;
        snakePosition.insert(0, getLatestSnake());
      });
    }
  }

  //génération des coordonnées du snake
  Point getLatestSnake() {
    var newHeadPos;

    switch (_direction) {
      case Direction.LEFT:
        var currentHeadPos = snakePosition.first;
        newHeadPos = Point(currentHeadPos.x - 1, currentHeadPos.y);
        break;

      case Direction.RIGHT:
        var currentHeadPos = snakePosition.first;
        newHeadPos = Point(currentHeadPos.x + 1, currentHeadPos.y);
        break;

      case Direction.UP:
        var currentHeadPos = snakePosition.first;
        newHeadPos = Point(currentHeadPos.x, currentHeadPos.y - 1);
        break;

      case Direction.DOWN:
        var currentHeadPos = snakePosition.first;
        newHeadPos = Point(currentHeadPos.x, currentHeadPos.y + 1);
        break;
    }

    return newHeadPos;
  }
}
