class MovieModel {
  final String id, title, poster_path;
  MovieModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        title = json["title"],
        poster_path = json["poster_path"];
}
