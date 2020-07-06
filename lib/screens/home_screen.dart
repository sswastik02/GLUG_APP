import 'package:flutter/material.dart';
import 'package:glug_app/blocs/home_bloc.dart';
import 'package:glug_app/models/carousel_response.dart';
import 'package:glug_app/widgets/error_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreen extends StatefulWidget {
  static final id = 'homescreen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    return StreamBuilder(
      stream: homeBloc.allData,
      builder:
          (BuildContext context, AsyncSnapshot<CarouselResponse> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.error != null && snapshot.data.error.length > 0) {
            return errorWidget(snapshot.data.error);
          }

          final List<Widget> images = snapshot.data.carousel
              .map(
                (item) => Container(
                  alignment: Alignment.bottomCenter,
                  constraints: BoxConstraints.expand(
                    height: 250.0,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    image: DecorationImage(
                      image: NetworkImage(item.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    height: 50.0,
                    child: Center(
                      child: Text(
                        item.heading,
                        style: TextStyle(
                          fontFamily: "Montserrat",
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
              )
              .toList();

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage: AssetImage("images/glug_logo.jpeg"),
                        radius: 30.0,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        "GLUG App",
                        style: TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 1.0,
                  color: Theme.of(context).primaryColor,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 20.0,
                  ),
                  child: CarouselSlider(
                    items: images,
                    options: CarouselOptions(
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 3),
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 10.0,
                  ),
                  child: Text(
                    "Welcome to the official app of the GNU Linux Users' Group NITDGP. Be sure to check our exciting new events and blog and stay tuned for further updates.",
                    style: TextStyle(
                      fontFamily: "Montserrat",
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
    );
  }
}
