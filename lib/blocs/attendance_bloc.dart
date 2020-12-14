import 'package:rxdart/rxdart.dart';
import 'package:glug_app/resources/database_provider.dart';

class AttendanceBloc{
  DatabaseProvider _dataBaseProvider=DatabaseProvider.databaseProvider;
  final _attendanceFetcher = BehaviorSubject<List<Map>>();
  Stream<List<Map>> get allAttendanceData => _attendanceFetcher.stream;

  fetchAllData() async {
    List<Map> data = await _dataBaseProvider.getAttendanceData();
    if (!_attendanceFetcher.isClosed) _attendanceFetcher.sink.add(data);
  }

  dispose() {
    _attendanceFetcher.close();
  }
}

final attendanceBloc = AttendanceBloc();
