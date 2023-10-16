class WebtoonDetailModel {
  final String title, about, genre, age;

  WebtoonDetailModel(
    this.title,
    this.about,
    this.genre,
    this.age,
  );

  WebtoonDetailModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        about = json['about'],
        genre = json['genre'],
        age = json['age'];
}
