import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:glug_app/models/notice_model.dart';
import 'package:glug_app/resources/firestore_provider.dart';
import 'package:glug_app/screens/pdf_view_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:progress_dialog/progress_dialog.dart';

class NoticeTile extends StatefulWidget {
  final Academic notice;
  final int c;
  final bool noticeStarred;


  const NoticeTile({Key key, @required this.notice,this.c, this.noticeStarred}) : super(key: key);

  @override
  _NoticeTileState createState() => _NoticeTileState();

}

class _NoticeTileState extends State<NoticeTile> {

  FirestoreProvider _provider;
  bool _isStared;


  ProgressDialog pr;
  @override
  void initState() {
    super.initState();
    _provider = new FirestoreProvider();
    _isStared = widget.noticeStarred;
    pr = ProgressDialog(context);
   // _initStarred();
  }

  /*void _initStarred() async {
    bool res = await _provider.isStarredNotice(widget.notice.title);
    print(res.toString());
    setState(() {
      _noticeStarred = res;
    });
  }*/

  @override
  void dispose() {
    super.dispose();
    _provider = null;
  }

  Future<File> _getFileFromUrl() async {

    Dio dio = Dio();
    try {
      String url = widget.notice.file.toString();
      String fileName =
          url.substring(url.lastIndexOf('/') + 1, url.lastIndexOf('.'));
      print(fileName);
      var response = await dio.get(url,
          options: Options(responseType: ResponseType.bytes));
      var bytes = response.data;

      var dir = await getTemporaryDirectory();
      File file = File("${dir.path}/$fileName.pdf");
      File urlFile = await file.writeAsBytes(bytes, flush: true);
      return urlFile;
    } catch (error, stackTrace) {
      print("Exception occured: $error stackTrace: $stackTrace");
      return null;
    }
  }

  final months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  Widget _getDate(String timing) {
    DateTime dateTime = DateTime.parse(timing).toLocal();
    var month = dateTime.month;
    var day = dateTime.day;
    var year = dateTime.year;
    var m = months[month - 1];
    Widget txt1 = Text(
      m.substring(0, 3),
      style: TextStyle(
        fontFamily: "Montserrat",
        fontSize: 15.0,
        fontWeight: FontWeight.bold,
      ),
    );
    Widget txt2 = Text(
      m.substring(3),
      style: TextStyle(
        fontFamily: "Montserrat",
        color: Colors.deepOrange,
        fontSize: 15.0,
        fontWeight: FontWeight.bold,
      ),
    );

    var date = " $day, $year";
    Widget txt3 = Text(
      date,
      style: TextStyle(
        fontFamily: "Montserrat",
        color: Colors.deepOrangeAccent,
        fontSize: 15.0,
        fontWeight: FontWeight.bold,
      ),
    );

    return Row(
      children: <Widget>[
        txt1,
        txt2,
        txt3,
        SizedBox(
          width: 10.0,
        ),
        Icon(
          Icons.calendar_today,
          color: Colors.deepOrangeAccent,
          size: 15,
        )
      ],
    );
  }


  Widget _tile(int index,String title,String date){
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Card(
          elevation: 8,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Notice $index",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    IconButton(
                      icon: Icon(
                        _isStared ? Icons.star : Icons.star_border,
                        color: _isStared ? Colors.deepOrangeAccent : Colors.black45,
                      ),
                      onPressed: () {
                        setState(() {
                          if (!_isStared) {
                            print(_isStared);
                            _provider.addStarredNotice({
                              "title": widget.notice.title,
                              "date": widget.notice.date,
                              "file": widget.notice.file
                            });
                          } else {
                            _provider.removeStarredNotice({
                              "title": widget.notice.title,
                              "date": widget.notice.date,
                              "file": widget.notice.file
                            });
                          }
                          _isStared = !_isStared;
                        });
                      },
                    ),

                  ],
                ),
                
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Text(
                    widget.notice.title,
                    overflow: TextOverflow.clip,
                  ) ,
                    
                ),
                
                
                SizedBox(
                  height: 10,
                ),

                Row(
                  children: [
                    _getDate(date),
                    SizedBox(width: 15,),
                    MaterialButton(
                        height: 30.0,
                        minWidth: 70.0,
                        padding: EdgeInsets.fromLTRB(5, 2, 5, 2),
                        color: Colors.deepOrangeAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Wrap(
                          direction: Axis.horizontal,
                          spacing: 0,
                          children: <Widget>[
                            Text(
                              "View",
                              style: TextStyle(
                                fontFamily: "Montserrat",
                                color: Colors.white,
                                fontSize: 12.0,
                              ),
                            ),
                          ],
                        ),
                        onPressed: () async {
                          pr.show();
                          File pdfFile = await _getFileFromUrl();
                          pr.hide();
                          pdfFile != null
                              ? Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PDFViewScreen(
                                file: pdfFile,
                                name: widget.notice.title.toString(),
                              ),
                            ),
                          )
                              : print("PDF file does not exist!");
                        })

                  ],
                )

              ],
            ),
          )
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return _tile(widget.c, widget.notice.title, widget.notice.date);
  }
}
