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

  Event.fromJSON(Map<String, dynamic> jsonMap)
      : show_bool = jsonMap['show_bool'],
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
}
