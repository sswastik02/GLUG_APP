import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:glug_app/blocs/linitMagazines_bloc.dart';
import 'package:glug_app/models/linit_model.dart';
import 'package:glug_app/models/linit_response.dart';
import 'package:glug_app/widgets/error_widget.dart';
import 'package:glug_app/widgets/linit_tile.dart';

class LinitScreen extends StatefulWidget {
  static final id = 'linitscreen';

  @override
  _LinitScreenState createState() => _LinitScreenState();
}

class _LinitScreenState extends State<LinitScreen> {
  @override
  void initState() {
    linitMagazinesBloc.fetchAllLinitMagazines();
    super.initState();
  }

  @override
  void dispose() {
    linitMagazinesBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 20.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Linit",
                style: TextStyle(
                    fontFamily: "Montserrat",
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic),
              ),
              FaIcon(FontAwesomeIcons.book),
            ],
          ),
        ),
        Divider(
          thickness: 1.0,
          color: Theme.of(context).primaryColor,
        ),
        Expanded(
          child: StreamBuilder(
              stream: linitMagazinesBloc.allLinitMagazines,
              builder: (context, AsyncSnapshot<LinitResponse> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.error != null &&
                      snapshot.data.error.length > 0) {
                    return errorWidget(snapshot.data.error);
                  }
                  List<Linit> lm = snapshot.data.linitMagazines;
                  lm = lm.reversed.toList();

                  return ListView.builder(
                    itemCount: lm.length,
                    itemBuilder: (context, index) {
                      return LinitTile(
                        magazine: lm[index],
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return errorWidget(snapshot.error);
                } else
                  return Center(child: CircularProgressIndicator());
              }),
        ),
      ],
    );
  }
}
