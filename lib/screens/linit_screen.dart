import 'package:flutter/material.dart';
import 'package:glug_app/database/linit_database.dart';
import 'package:glug_app/models/linit_model.dart';
import 'package:glug_app/widgets/drawer_contents.dart';
import 'package:glug_app/widgets/linit_tile.dart';

class LinitScreen extends StatefulWidget {

  static final id = 'linitscreen';

  @override
  _LinitScreenState createState() => _LinitScreenState();
}

class _LinitScreenState extends State<LinitScreen> {
  Future<List<Linit>> listenForLinit() async {
    List<Linit> magazines = [];

    final Stream<Linit> stream = await getLinit();
    stream.listen((Linit linit) => setState(() => magazines.add(linit)));

    return magazines;
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
            child: FutureBuilder(
              future: listenForLinit(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return LinitTile(magazine: snapshot.data.reversed.toList()[index]);
                      });
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }
}
