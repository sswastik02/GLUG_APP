import 'package:flutter/material.dart';
import 'package:glug_app/blocs/linitMagazines_bloc.dart';
import 'package:glug_app/models/linit_model.dart';
import 'package:glug_app/models/linit_response.dart';
import 'package:glug_app/widgets/drawer_contents.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "LINIT",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/drawer_header.jpeg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: null,
            ),
            Expanded(
              child: DrawerContents(4),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 20.0,
                left: 5.0,
              ),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 30.0,
                  backgroundImage: AssetImage('images/glug_logo.jpeg'),
                ),
                title: Text(
                  "Developed by the GNU Linux Users' Group NITDGP",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
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
      ),
    );
  }
}
