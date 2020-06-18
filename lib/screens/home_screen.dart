import 'package:flutter/material.dart';
import 'package:glug_app/blocs/home_bloc.dart';
import 'package:glug_app/models/carousel_response.dart';
import 'package:glug_app/widgets/drawer_contents.dart';
import 'package:glug_app/widgets/error_widget.dart';

class HomeScreen extends StatefulWidget {
  static final id = 'homescreen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int imgIndex = 0;

  void _onPrev(int length) {
    setState(() {
      imgIndex = (imgIndex == 0) ? length - 1 : imgIndex - 1;
    });
  }

  void _onNext(int length) {
    setState(() {
      imgIndex = (imgIndex == length - 1) ? 0 : imgIndex + 1;
    });
  }

  @override
  void initState() {
    homeBloc.fetchAllData();
    super.initState();
  }

  @override
  void dispose() {
    homeBloc.dispose();
    super.dispose();
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
              child: null,
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
      body: StreamBuilder(
        stream: homeBloc.allData,
        builder:
            (BuildContext context, AsyncSnapshot<CarouselResponse> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.error != null && snapshot.data.error.length > 0) {
              return errorWidget(snapshot.data.error);
            }

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 20.0,
                    ),
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      constraints: BoxConstraints.expand(
                        height: 250.0,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        image: DecorationImage(
                          image: NetworkImage(
                              snapshot.data.carousel[imgIndex].image),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Container(
                        height: 50.0,
                        child: Center(
                          child: Text(
                            snapshot.data.carousel[imgIndex].heading,
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(225, 255, 255, 255),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SizedBox(
                        width: 10.0,
                      ),
                      RaisedButton(
                        child: Icon(
                          Icons.arrow_left,
                          color: Colors.white,
                        ),
                        color: Theme.of(context).primaryColor,
                        onPressed: () {
                          _onPrev(snapshot.data.carousel.length);
                        },
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      RaisedButton(
                        child: Icon(
                          Icons.arrow_right,
                          color: Colors.white,
                        ),
                        color: Theme.of(context).primaryColor,
                        onPressed: () {
                          _onNext(snapshot.data.carousel.length);
                        },
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 10.0,
                    ),
                    child: Text(
                      "Welcome to the official app of the GNU Linux Users' Group NITDGP. Be sure to check our exciting new events and blog and stay tuned for further updates.",
                      style: TextStyle(
                        fontSize: 18.0,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return errorWidget(snapshot.error);
          } else
            return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
