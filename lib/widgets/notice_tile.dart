import 'package:date_format/date_format.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:glug_app/models/notice_model.dart';
import 'package:path_provider/path_provider.dart';

class NoticeTile extends StatelessWidget {
  final Academic notice;

  const NoticeTile({Key key, @required this.notice}) : super(key: key);

  Future<void> downloadPDF() async {
    Dio dio = Dio();

    try {
      var dir = await getExternalStorageDirectory();
      // var dir = "/storage/emulated/0/Download";
      // print("${dir.path}");
      var fullSavePath = dir.path + "/${notice.title.toString()}.pdf";
      await dio.download(notice.file.toString(), fullSavePath,
          onReceiveProgress: (rec, total) =>
              print((rec / total * 100).toStringAsFixed(0) + "%"));
    } catch (error, stackTrace) {
      print("Exception occured: $error stackTrace: $stackTrace");
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      //alignment: Alignment.center,
      // height: 80,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Theme.of(context).primaryColor,
          )),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(notice.date),
          SizedBox(
            width: 20,
          ),
          GestureDetector(
            child: Container(
              width: size.width * 0.55,
              child: Text(
                notice.title,
                overflow: TextOverflow.clip,
              ),
            ),
            onTap: () {
              print(notice.file.toString());
              downloadPDF();
            },
          ),
        ],
      ),
    );
  }
}
