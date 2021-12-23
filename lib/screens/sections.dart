import 'package:flutter/material.dart';
import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:glug_app/screens/routine.dart';
import 'package:flutter/services.dart';
class Sections extends StatefulWidget {

  @override
  _SectionsState createState() => _SectionsState();
}

class _SectionsState extends State<Sections> {
  @override
  Widget build(BuildContext context) {

    // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown,DeviceOrientation.portraitDown]);
        return Scaffold(
          backgroundColor: DynamicTheme.of(context).themeId==1 ? Colors.black : Colors.white,
          body: SafeArea(
            child: Column(
              children: [
                Container(
                  child:     Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                  icon: Icon(
                                    Icons.arrow_back,
                                    size: 30,
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop(true);
                                  }),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                'Choose Your Section',
                                style: TextStyle(
                                    fontFamily: "Nexa-Bold",
                                    fontSize: MediaQuery.of(context).size.width * 0.055,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ]),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (BuildContext context,int index){
                      return  Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: InkWell(
                          onTap: (){
                            print("He");
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (ctxt) => Routine(String.fromCharCode(index+65))));
                          },
                          child: Container(
                            child: Center(child: Text(
                                "SECTION ${String.fromCharCode(index+65)}",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            )
                            ),
                            padding: EdgeInsets.only(left: 20, right: 20),
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            height: 60,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              // color: Colors.white,
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(
                                  color: Colors.deepOrangeAccent //Color(0xFFE5E5E5),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        );

  }
}
