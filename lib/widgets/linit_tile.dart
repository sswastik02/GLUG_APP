import 'package:flutter/material.dart';
import 'package:glug_app/models/linit_model.dart';

class LinitTile extends StatelessWidget {
  final Linit magazine;

  LinitTile({this.magazine});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 20.0,
      ),
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        elevation: 10.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              constraints: BoxConstraints.expand(
                height: 500.0,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                image: DecorationImage(
                  image: magazine.image != null
                      ? NetworkImage(magazine.image)
                      : AssetImage('images/glug_logo.jpeg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                magazine.title,
                style: TextStyle(
                  fontFamily: "Montserrat",
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
          ],
        ),
      ),
    );
  }
}
