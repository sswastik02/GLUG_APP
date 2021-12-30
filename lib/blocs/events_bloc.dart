import 'package:glug_app/models/event_response.dart';
import 'package:glug_app/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class EventsBloc {
  final _repository = Repository();
  final _eventsFetcher = BehaviorSubject<EventResponse>();

  Stream<EventResponse> get allEvents => _eventsFetcher.stream;

  fetchAllEvents() async {
    EventResponse event = await _repository.fetchAllEvents();
    if (!_eventsFetcher.isClosed) _eventsFetcher.sink.add(event);
  }

  dispose() {
    _eventsFetcher.close();
  }
}

final eventsBloc = EventsBloc();
