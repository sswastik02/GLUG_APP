import 'package:glug_app/models/event_response.dart';
import 'package:glug_app/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class UpcomingEventsBloc {
  final _repository = Repository();
  final _upcomingEventsFetcher = BehaviorSubject<EventResponse>();

  Stream<EventResponse> get allUpcomingEvents => _upcomingEventsFetcher.stream;

  fetchAllUpcomingEvents() async {
    EventResponse event = await _repository.fetchAllUpcomingEvents();
    if (!_upcomingEventsFetcher.isClosed)
      _upcomingEventsFetcher.sink.add(event);
  }

  dispose() {
    _upcomingEventsFetcher.close();
  }
}

final upcomingEventsBloc = UpcomingEventsBloc();
