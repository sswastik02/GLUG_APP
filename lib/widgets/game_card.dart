import 'package:flutter/material.dart';
import 'package:glug_app/games/hangman/game_stage.dart';

class GameCard extends StatelessWidget {
  final String game;
  const GameCard({Key key, @required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        if (game == "hangman") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => VerticalGameStage()),
          );
        }
      },
      child: Container(
        height: 150,
        width: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          image: DecorationImage(
            image: AssetImage('images/$game.png'),
            fit: BoxFit.fitHeight,
          ),
        ),
      ),
    );
  }
}
