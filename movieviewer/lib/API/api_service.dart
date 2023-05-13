import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movieviewer/models/movie_model.dart';

class ApiService {
  final baseUrl = 'https://movies-api.nomadcoders.workers.dev';

  Future<List<MovieModel>> getPopularMovies() async {
    List<MovieModel> movies = [];
    final url = Uri.parse("$baseUrl/popular");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonCode = jsonDecode(response.body);
      final List<dynamic> jsonCodeResults = jsonCode["results"];
      print(jsonCodeResults);
      for (var movie in jsonCodeResults) {
        movies.add(MovieModel.fromJson(movie));
      }
      return movies;
    }
    throw Error();
  }
}
