import 'dart:convert';

class NoticeProperties {
  final String title;
  final String file;
  final String date;

  NoticeProperties({this.title, this.file, this.date});

  factory NoticeProperties.fromJson(Map<String, dynamic> jsonMap) {
    return NoticeProperties(
      title: jsonMap['title'],
      file: jsonMap['file'],
      date: jsonMap['date'],
    );
  }
}

class NoticeCategories {
  final List<NoticeProperties> general;
  final List<NoticeProperties> student;
  final List<NoticeProperties> academic;
  final List<NoticeProperties> hostel;

  NoticeCategories({this.general, this.student, this.academic, this.hostel});

  factory NoticeCategories.fromJson(Map<String, dynamic> jsonMap) {
    var generalfromjson = jsonMap['General'];
    List<NoticeProperties> generalList =
        new List<NoticeProperties>.from(generalfromjson);
    var studentfromjson = jsonMap['Student'];
    List<NoticeProperties> studentList =
        new List<NoticeProperties>.from(studentfromjson);
    var academicfromjson = jsonMap['Academic'];
    List<NoticeProperties> academicList =
        new List<NoticeProperties>.from(academicfromjson);
    var hostelfromjson = jsonMap['Hostel'];
    List<NoticeProperties> hostelList =
        new List<NoticeProperties>.from(hostelfromjson);
    return NoticeCategories(
      general: generalList,
      student: studentList,
      academic: academicList,
      hostel: hostelList,
    );
  }
}

class Notice {
  final NoticeCategories notices;

  Notice({this.notices});

  factory Notice.fromJson(Map<String, dynamic> jsonMap) {
    return Notice(
      notices: NoticeCategories.fromJson(jsonMap['notices']),
    );
  }

  // factory Notice.withError(String errorVal) {
  //   return
  // }
}
