import 'package:glug_app/models/timeline_model.dart';

class TimelineResponse {
  final List<Timeline> timelines;
  final String error;

  TimelineResponse.fromJSON(List<dynamic> json)
      : timelines = json.map((data) => Timeline.fromJson(data)).toList(),
        error = "";

  TimelineResponse.withError(String errorVal)
      : timelines = List(),
        error = errorVal;
}
