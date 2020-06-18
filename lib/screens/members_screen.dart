import 'package:flutter/material.dart';
import 'package:glug_app/blocs/profiles_bloc.dart';
import 'package:glug_app/models/profile_model.dart';
import 'package:glug_app/models/profile_response.dart';
import 'package:glug_app/widgets/drawer_contents.dart';
import 'package:glug_app/widgets/error_widget.dart';
import 'package:glug_app/widgets/profile_tile.dart';

class MembersScreen extends StatefulWidget {
  static final id = 'membersscreen';

  @override
  _MembersScreenState createState() => _MembersScreenState();
}

class _MembersScreenState extends State<MembersScreen> {
  @override
  void initState() {
    profilesBloc.fetchAllProfiles();
    super.initState();
  }

  @override
  void dispose() {
    profilesBloc.dispose();
    super.dispose();
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
              child: null,
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
            child: StreamBuilder(
              stream: profilesBloc.allProfiles,
              builder: (context, AsyncSnapshot<ProfileResponse> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.error != null &&
                      snapshot.data.error.length > 0) {
                    return errorWidget(snapshot.data.error);
                  }
                  return ListView.builder(
                    itemCount: snapshot.data.profiles.length,
                    itemBuilder: (context, index) {
                      return ProfileTile(
                          profile: snapshot.data.profiles[index]);
                    },
                  );
                } else if (snapshot.hasError) {
                  return errorWidget(snapshot.error);
                } else
                  return Center(child: CircularProgressIndicator());
              },
            ),
          )
        ],
      ),
    );
  }
}
