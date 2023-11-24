class Books {
  String? id;
  String title, urlImg, description, category, position, availability;
  Books(
      {this.id,
      required this.title,
      required this.urlImg,
      required this.description,
      required this.category,
      required this.position,
      required this.availability});
}
