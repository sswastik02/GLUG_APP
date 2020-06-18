import 'package:glug_app/models/carousel_model.dart';

class CarouselResponse {
  final List<Carousel> carousel;
  final String error;

  CarouselResponse.fromJSON(List<dynamic> json)
      : carousel = json.map((data) => Carousel.fromJSON(data)).toList(),
        error = "";

  CarouselResponse.withError(String errorVal)
      : carousel = List(),
        error = errorVal;
}
