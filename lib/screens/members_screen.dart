import 'package:flutter/material.dart';
import 'package:glug_app/database/profile_database.dart';
import 'package:glug_app/models/profile_model.dart';
import 'package:glug_app/widgets/drawer_contents.dart';
import 'package:glug_app/widgets/profile_tile.dart';

class MembersScreen extends StatefulWidget {
  static final id = 'membersscreen';

  @override
  _MembersScreenState createState() => _MembersScreenState();
}

class _MembersScreenState extends State<MembersScreen> {
  List<Profile> _profiles = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listenForProfiles();
  }

//  Future<List<Profile>> listenForProfiles() async {
//    List<Profile> profiles = [];
//
//    final Stream<Profile> stream = await getProfiles();
//    stream.listen((Profile profile) => setState(() => profiles.add(profile)));
//    return profiles;
//  }

  void listenForProfiles() async {
    final Stream<Profile> stream = await getProfiles();
    stream.listen((Profile profile) => setState(() => _profiles.add(profile)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "MEMBERS",
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
              child: DrawerContents(2),
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
            child: ListView.builder(
              itemCount: _profiles.length,
              itemBuilder: (context, index) {
                return ProfileTile(
                  profile: _profiles[index],
                );
              },
            ),
//            child: FutureBuilder(
//              future: listenForProfiles(),
//              builder: (context, snapshot) {
//                if (snapshot.hasData) {
//                  return ListView.builder(
//                    itemCount: snapshot.data.length,
//                    itemBuilder: (context, index) {
//                      return ProfileTile(profile: snapshot.data[index]);
//                    },
//                  );
//                }
//                return Center(
//                  child: CircularProgressIndicator(),
//                );
//              },
//            ),
          )
        ],
      ),
    );
  }
}
