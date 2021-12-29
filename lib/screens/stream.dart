import 'package:flutter/material.dart';
import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:glug_app/screens/routine.dart';
int year;
class Stream extends StatefulWidget {

  Stream(int y){
    year=y;
  }

  @override
  _StreamState createState() => _StreamState();
}

class _StreamState extends State<Stream> {
  var dept =  {
    "CS":"Computer Science",
    "EC":"Electronics and Communication",
    "EE":"Electrical",
    "CE":"Civil",
    "MM":"Metallurgy and Materials",
    "CH":"Chemical",
    "BT":"Biotechnology",
    "ME":"Mechanical"
  };
  var dep = ["CS","EC","EE","ME","CH","CE","MM","BT"];
  @override
  Widget build(BuildContext context) {
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
                            'Choose Your Department',
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
                itemCount: 8,
                itemBuilder: (BuildContext context,int index){
                  return  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: InkWell(
                      onTap: (){
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (ctxt) => Routine(dep[index],year)));
                      },
                      child: Container(
                        child: Center(child: Text(
                          "${dept[dep[index]]}",
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
