import 'package:flutter/material.dart';
import 'package:glug_app/models/notice_model.dart';
import 'package:glug_app/blocs/notices_bloc.dart';
import 'package:glug_app/widgets/drawer_items.dart';
import 'package:glug_app/widgets/error_widget.dart';
import 'package:glug_app/widgets/notice_tile.dart';

class NoticeScreen extends StatefulWidget {
  @override
  _NoticeScreenState createState() => _NoticeScreenState();
}

class _NoticeScreenState extends State<NoticeScreen> {
  List<String> _categories = ['General', 'Academic', 'Student', 'Hostel'];
  String _dropdownvalue;
  Notice notice;
  List<Academic> noticeType;
  void changeNoticeType(String noticeType) {
    noticeBloc.fetchCalledNotice(noticeType);
    setState(() {
      _dropdownvalue = noticeType;
    });
  }

  @override
  void initState() {
    _dropdownvalue = "General";
    noticeBloc.fetchAllData();
    noticeBloc.fetchCalledNotice("General");
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
      drawer: Drawer(
        child: DrawerItems(),
      ),
      body: Column(
        children: [
          SizedBox(height: 50),
          Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            margin: EdgeInsets.symmetric(horizontal: 20),
            height: 60,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                color: Color(0xFFE5E5E5),
              ),
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: DropdownButton(
                    isExpanded: true,
                    underline: SizedBox(),
                    icon: Icon(Icons.arrow_downward),
                    value: _dropdownvalue,
                    items: _categories
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      changeNoticeType(newValue);
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 25),
          Expanded(
            child: StreamBuilder(
              stream: noticeBloc.noticeCategories,
              builder: (context, AsyncSnapshot<List<Academic>> snapshot) {
                if (snapshot.hasData) {
                  noticeType = snapshot.data;

                  return ListView.builder(
                    padding: EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: 20,
                    ),
                    itemCount: noticeType.length,
                    itemBuilder: (context, index) {
                      return NoticeTile(notice: noticeType[index]);
                    },
                  );
                } else if (snapshot.hasError) {
                  return errorWidget(snapshot.error);
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
