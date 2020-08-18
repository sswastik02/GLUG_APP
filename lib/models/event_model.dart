import 'package:glug_app/resources/database_provider.dart';

class Event {
  final bool show_bool;
  final int id;
  final String identifier;
  final String title;
  final String description;
  final String venue;
  final String url;
  final String event_timing;
  final String facebook_link;
  final String event_image;
  final String status;

  Event(
      this.show_bool,
      this.id,
      this.identifier,
      this.title,
      this.description,
      this.venue,
      this.url,
      this.event_timing,
      this.facebook_link,
      this.event_image,
      this.status);

  Event.fromJSON(Map<String, dynamic> jsonMap)
      : show_bool = (jsonMap['show_bool'] == 1 || jsonMap['show_bool']) == true
            ? true
            : false,
        id = jsonMap['id'],
        identifier = jsonMap['identifier'],
        title = jsonMap['title'],
        description = jsonMap['description'],
        venue = jsonMap['venue'],
        url = jsonMap['url'],
        event_timing = jsonMap['event_timing'],
        facebook_link = jsonMap['facebook_link'],
        event_image = jsonMap['event_image'],
        status = jsonMap['status'];

  Map<String, dynamic> toMap() => {
        DatabaseProvider.EVENT_SHOW: show_bool ? 1 : 0,
        DatabaseProvider.EVENT_ID: id,
        DatabaseProvider.EVENT_IDENTIFIER: identifier,
        DatabaseProvider.EVENT_TITLE: title,
        DatabaseProvider.EVENT_DESCRIPTION: description,
        DatabaseProvider.EVENT_VENUE: venue,
        DatabaseProvider.EVENT_URL: url,
        DatabaseProvider.EVENT_TIMING: event_timing,
        DatabaseProvider.EVENT_FB_LINK: facebook_link,
        DatabaseProvider.EVENT_IMAGE: event_image,
        DatabaseProvider.EVENT_STATUS: status,
      };
}
