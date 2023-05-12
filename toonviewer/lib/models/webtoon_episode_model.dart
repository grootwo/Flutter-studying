class WebtoonEpisodeModel {
  final title, rating, date;

  WebtoonEpisodeModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        rating = json['rating'],
        date = json['date'];
}
