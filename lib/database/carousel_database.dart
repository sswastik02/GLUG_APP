import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:glug_app/models/carousel_model.dart';

Future<Stream<Carousel>> getCarouselItems() async {
  final String url = 'https://api.nitdgplug.org/api/carousel/';

  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', Uri.parse(url)));

  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .expand((data) => (data as List))
      .map((data) => Carousel.fromJSON(data));
}
