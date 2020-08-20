import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:glug_app/models/notice_model.dart';

class NoticeTile extends StatelessWidget {
  final Academic notice;

  const NoticeTile({Key key, @required this.notice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(bottom: 40),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      //alignment: Alignment.center,
      height: 80,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Colors.black26,
          )),
      child: Row(
        children: <Widget>[
          Text(notice.date),
          SizedBox(
            width: 20,
          ),
          GestureDetector(
            child: Container(
              width: size.width * 0.6,
              child: Text(
                notice.title,
                overflow: TextOverflow.clip,
              ),
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
