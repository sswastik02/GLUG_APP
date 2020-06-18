class Carousel {
  final String identifier;
  final String image;
  final String heading;
  final String subHeading;

  Carousel(this.identifier, this.image, this.heading, this.subHeading);

  Carousel.fromJSON(Map<String, dynamic> jsonMap)
      : identifier = jsonMap['identifier'],
        image = jsonMap['image'],
        heading = jsonMap['heading'],
        subHeading = jsonMap['sub_heading'];
}
