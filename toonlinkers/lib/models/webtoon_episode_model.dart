class WebtoonEpisodeModel {
  final String title, id, rating, date;

  WebtoonEpisodeModel(
    this.title,
    this.id,
    this.rating,
    this.date,
  );

  WebtoonEpisodeModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        id = json['id'],
        rating = json['rating'],
        date = json['date'];
}
