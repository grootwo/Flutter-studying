import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movieviewer/models/movie_model.dart';

class ApiService {
  final baseUrl = 'https://movies-api.nomadcoders.workers.dev/';

  Future<List<MovieModel>> getPopularMovies() async {
    List<MovieModel> movies = [];
    final url = Uri.parse("$baseUrl/popular");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> movieCodes = jsonDecode(response.body);
      for (var movie in movieCodes) {
        movies.add(MovieModel.fromJson(movie));
      }
      return movies;
    }
    throw Error();
  }
}
