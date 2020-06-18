class Linit {
  final String title;
  final String description;
  final String image;
  final int year_edition;
  final String pdf;

  Linit(this.title, this.description, this.image, this.year_edition, this.pdf);

  Linit.fromJSON(Map<String, dynamic> jsonMap)
      : title = jsonMap['title'],
        description = jsonMap['description'],
        image = jsonMap['image'],
        year_edition = jsonMap['year_edition'],
        pdf = jsonMap['pdf'];
}
