import 'package:glug_app/models/event_model.dart';

class EventResponse {
  final List<Event> events;
  final String error;

  EventResponse.fromJSON(List<dynamic> json)
      : events = json.map((data) => Event.fromJSON(data)).toList(),
        error = "";

  EventResponse.withError(String errorVal)
      : events = List(),
        error = errorVal;
}
