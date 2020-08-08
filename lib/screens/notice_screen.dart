import 'package:flutter/material.dart';
import 'package:glug_app/models/notice_model.dart';
import 'package:glug_app/blocs/notices_bloc.dart';

class NoticeScreen extends StatefulWidget {
  @override
  _NoticeScreenState createState() => _NoticeScreenState();
}

class _NoticeScreenState extends State<NoticeScreen> {
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
    return Container(
      child: StreamBuilder(
        stream: noticeBloc.allNoticeData,
        builder: (context, AsyncSnapshot<Notice> snapshot) {
          if (snapshot.hasData) {
            Notice notice = snapshot.data;
            List<Academic> generalNotices = notice.notices.general;
            return Column(
              children: [
                Column(
                  children: [
                    Text(generalNotices[1].title),
                    Text(generalNotices[1].file),
                    Text(
                      generalNotices[1].date,
                    )
                  ],
                )
              ],
            );
          } else
            return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
