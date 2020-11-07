import 'package:flutter/material.dart';
import 'package:glug_app/games/hangman/game_stage.dart';

class GameCard extends StatelessWidget {
  final String game;
  final String title;
  const GameCard({Key key, @required this.game, @required this.title})
      : super(key: key);

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
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
          SizedBox(height: 15.0),
          Text(title,
              style: TextStyle(
                fontFamily: "Montserrat",
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              )),
        ],
      ),
    );
  }
}
