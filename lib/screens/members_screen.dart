import 'package:flutter/material.dart';
import 'package:glug_app/blocs/profiles_bloc.dart';
import 'package:glug_app/models/profile_response.dart';
import 'package:glug_app/widgets/drawer_items.dart';
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
        drawer: Drawer(
          child: DrawerItems(),
        ),
        appBar: AppBar(
          title: Text("Our Team"),
          // leading: new IconButton(
          //   icon: new Icon(Icons.arrow_back),
          //   onPressed: () {
          //     Navigator.of(context).pop(true);
          //   },
          // ),
        ),
        body: Column(
          children: <Widget>[
            /* Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Members",
                style: TextStyle(
                    fontFamily: "Montserrat",
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic),
              ),
              FaIcon(FontAwesomeIcons.userFriends),
            ],
          ),
        ),
        Divider(
          thickness: 1.0,
          color: Theme.of(context).primaryColor,
        ),*/
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
        ));
  }
}
