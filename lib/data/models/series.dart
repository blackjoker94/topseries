class Series {
  late int rank;
  late String title;
  late String description;
  late String image;
  late List<dynamic> genre;
  late double rating;
  late String year;

  Series.fromJson(Map<String, dynamic> json) {
    rank = json["rank"];
    title = json["title"];
    description = json["description"];
    image = json["image"];
    genre = json["genre"];

    // Handle both int and double types for rating
    rating = (json["rating"] is int)
        ? (json["rating"] as int).toDouble()
        : json["rating"];

    year = json["year"];
  }
}
