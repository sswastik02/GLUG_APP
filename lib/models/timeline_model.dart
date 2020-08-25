class Timeline {
  final String eventName;
  final String detail;
  final String eventTime;


  Timeline(
      this.eventName,
      this.detail,
      this.eventTime,
      );

  Timeline.fromJson(Map<String, dynamic> json)
      : eventName = json['event_name'],
        detail = json['detail'],
        eventTime = json['event_time'];

}
