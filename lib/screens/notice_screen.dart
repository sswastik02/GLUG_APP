import 'package:flutter/material.dart';
import 'package:glug_app/models/notice_model.dart';
import 'package:glug_app/blocs/notices_bloc.dart';
import 'package:glug_app/widgets/notice_tile.dart';

class NoticeScreen extends StatefulWidget {
  @override
  _NoticeScreenState createState() => _NoticeScreenState();
}

class _NoticeScreenState extends State<NoticeScreen> {
  String _dropdownvalue;
  void changeNoticeType(String noticeType) {
    setState(() {
      _dropdownvalue = noticeType;
    });
  }

  @override
  void initState() {
    noticeBloc.fetchAllData();
    super.initState();
  }

  @override
  void dispose() {
    noticeBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notices'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: noticeBloc.allNoticeData,
              builder: (context, AsyncSnapshot<Notice> snapshot) {
                if (snapshot.hasData) {
                  Notice notice = snapshot.data;
                  return ListView.builder(
                    padding: EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: 20,
                    ),
                    itemCount: notice.notices.academic.length,
                    itemBuilder: (context, index) {
                      return NoticeTile(notice: notice.notices.academic[index]);
                    },
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

//return Container(
//   child: StreamBuilder(
//     stream: noticeBloc.allNoticeData,
//     builder: (context, AsyncSnapshot<Notice> snapshot) {
//       if (snapshot.hasData) {
//         Notice notice = snapshot.data;
//         List<Academic> generalNotices = notice.notices.general;
//         return Scaffold(
//           appBar: AppBar(

//           ),
//         );
//       } else
//         return Center(child: CircularProgressIndicator());
//     },
//   ),
// );
