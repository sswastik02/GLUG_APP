import 'package:glug_app/models/linit_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Stream<Linit>> getLinit() async {
  final String url = 'https://api.nitdgplug.org/api/linit/';

  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', Uri.parse(url)));

  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .expand((data) => (data as List))
      .map((data) => Linit.fromJSON(data));
}
