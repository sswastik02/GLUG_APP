
import 'package:glug_app/models/timeline_response.dart';
import 'package:glug_app/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class TimelineBloc {
  final _repository = Repository();
  final _timelineFetcher = BehaviorSubject<TimelineResponse>();

  Stream<TimelineResponse> get allTimelineData => _timelineFetcher.stream;

  fetchAllTimelineData() async {
    TimelineResponse t = await _repository.fetchAllTimelineData();
    if (!_timelineFetcher.isClosed) _timelineFetcher.sink.add(t);
  }

  dispose() {
    _timelineFetcher.close();
  }
}

final timelineBloc = TimelineBloc();
