import 'package:glug_app/models/notice_model.dart';
import 'package:glug_app/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class NoticeBloc {
  final _respository = Repository();
  final _noticesFetcher = BehaviorSubject<Notice>();

  Stream<Notice> get allData => _noticesFetcher.stream;

  fetchAllData() async {
    Notice notice = await _respository.fetchAllNotices();
    if (!_noticesFetcher.isClosed) _noticesFetcher.sink.add(notice);
  }

  dispose() {
    _noticesFetcher.close();
  }
}

final noticeBloc = NoticeBloc();
