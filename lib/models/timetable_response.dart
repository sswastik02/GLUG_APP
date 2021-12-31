import 'package:glug_app/resources/routine_data.dart';

dynamic timetableFromMap(dynamic jsons) {
  List<List<dynamic>> timetable = List<List<dynamic>>.from(jsons.map((json) => [
        json['tme'],
        json['Mon'],
        json['Tue'],
        json['Wed'],
        json['Thu'],
        json['Fri']
      ]));
  dynamic timetableFinal = [RoutineData().data[0]] + timetable;
  return timetableFinal;
}

class TimetableResponse {
  List<List<String>> timetable;
  String error;

  TimetableResponse.fromJSON(List<dynamic> jsons)
      : timetable = timetableFromMap(jsons),
        error = '';

  TimetableResponse.withError(String errorVal)
      : timetable = [],
        error = errorVal;
}
