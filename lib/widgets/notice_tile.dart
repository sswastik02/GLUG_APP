import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:glug_app/models/notice_model.dart';
import 'package:glug_app/resources/firestore_provider.dart';
import 'package:glug_app/screens/pdf_view_screen.dart';
import 'package:path_provider/path_provider.dart';

class NoticeTile extends StatefulWidget {
  final Academic notice;

  const NoticeTile({Key key, @required this.notice}) : super(key: key);

  @override
  _NoticeTileState createState() => _NoticeTileState();
}

class _NoticeTileState extends State<NoticeTile> {
  FirestoreProvider _provider;
  bool _noticeStarred = false;

  @override
  void initState() {
    super.initState();
    _provider = new FirestoreProvider();
    _initStarred();
  }

  void _initStarred() async {
    bool res = await _provider.isStarredNotice(widget.notice.title);
    print(res.toString());

    setState(() {
      _noticeStarred = res;
    });
  }

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

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      alignment: Alignment.center,
      constraints: BoxConstraints(
        minHeight: 70.0,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Theme.of(context).primaryColor,
          )),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          IconButton(
            icon: Icon(
              _noticeStarred ? Icons.star : Icons.star_border,
              color: _noticeStarred ? Colors.deepOrangeAccent : Colors.black45,
            ),
            onPressed: () {


              setState(() {
                if (!_noticeStarred) {

                  print(_noticeStarred);
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
              //  _noticeStarred = !_noticeStarred;
              });
            },
          ),
          Text(widget.notice.date),
          SizedBox(
            width: 20,
          ),
          GestureDetector(
            child: Container(
              width: size.width * 0.50,
              child: Text(
                widget.notice.title,
                overflow: TextOverflow.clip,
              ),
            ),
            onTap: () async {
              File pdfFile = await _getFileFromUrl();
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
            },
          ),
        ],
      ),
    );
  }
}
