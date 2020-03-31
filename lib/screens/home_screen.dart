import 'package:flutter/material.dart';
import 'package:glug_app/database/carousel_database.dart';
import 'package:glug_app/models/carousel_model.dart';
import 'package:glug_app/widgets/drawer_contents.dart';

class HomeScreen extends StatefulWidget {
  static final id = 'homescreen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int imgIndex = 0;

  Future<List<Carousel>> listenForCarouselItems() async {
    List items = [];
    final Stream<Carousel> stream = await getCarouselItems();
    stream.listen((Carousel carousel) => setState(() => items.add(carousel)));

    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "HOME",
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
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Expanded(
              child: DrawerContents(0),
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
      body: Center(
        child: Text(
          'No content to display as of now',
        ),
      ),
    );
  }
}
