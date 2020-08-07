import 'dart:convert';

class NoticeProperties {
  final String title;
  final String file;
  final String date;

  NoticeProperties({this.title, this.file, this.date});

  factory NoticeProperties.fromJson(Map<String, String> jsonMap) {
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

  factory NoticeCategories.fromJson(
      Map<String, List<NoticeProperties>> jsonMap) {
    return NoticeCategories(
        general: jsonMap['General'],
        student: jsonMap['Student'],
        academic: jsonMap['Academic'],
        hostel: jsonMap['Hostel']);
  }
}

class Notice {
  final NoticeCategories notices;

  Notice({this.notices});

  factory Notice.fromJson(Map<String, NoticeCategories> jsonMap) {
    return Notice(
      notices: jsonMap['notices'],
    );
  }

  // factory Notice.withError(String errorVal) {
  //   return
  // }
}
