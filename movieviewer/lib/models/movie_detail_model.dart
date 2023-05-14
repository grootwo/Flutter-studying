class MovieDetailModel {
  final String title, poster_path, overview;
  final List<dynamic> genres;
  final double vote_average;
  MovieDetailModel.fromJson(Map<String, dynamic> json)
      : title = json["title"],
        poster_path = json["poster_path"],
        overview = json["overview"],
        genres = json["genres"],
        vote_average = json["vote_average"];
}
