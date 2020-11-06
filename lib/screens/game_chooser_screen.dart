import 'package:flutter/material.dart';
import 'package:glug_app/widgets/drawer_items.dart';
import 'package:glug_app/widgets/game_card.dart';

class GameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Games"),
      ),
      drawer: Drawer(
        child: DrawerItems(),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GameCard(game: "hangman"),
                GameCard(game: "flappybird"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
