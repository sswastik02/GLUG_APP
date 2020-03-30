import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:glug_app/models/profile_model.dart';

Future<Stream<Profile>> getProfiles() async {
  final String url = 'https://api.nitdgplug.org/api/profiles/';

  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', Uri.parse(url)));

  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .expand((data) => (data as List))
      .map((data) => Profile.fromJson(data));
}
