import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movieviewer/models/movie_model.dart';

import '../models/movie_detail_model.dart';

class ApiService {
  final baseUrl = 'https://movies-api.nomadcoders.workers.dev';

  Future<List<MovieModel>> getPopularMovies() async {
    List<MovieModel> movies = [];
    final url = Uri.parse("$baseUrl/popular");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonCode = jsonDecode(response.body);
      final List<dynamic> jsonCodeResults = jsonCode["results"];
      for (var movie in jsonCodeResults) {
        movies.add(MovieModel.fromJson(movie));
      }
      return movies;
    }
    throw Error();
  }

  Future<List<MovieModel>> getPlayingMovies() async {
    List<MovieModel> movies = [];
    final url = Uri.parse("$baseUrl/now-playing");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonCode = jsonDecode(response.body);
      final List<dynamic> jsonCodeResults = jsonCode["results"];
      for (var movie in jsonCodeResults) {
        movies.add(MovieModel.fromJson(movie));
      }
      return movies;
    }
    throw Error();
  }

  Future<List<MovieModel>> getComingMovies() async {
    List<MovieModel> movies = [];
    final url = Uri.parse("$baseUrl/coming-soon");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonCode = jsonDecode(response.body);
      final List<dynamic> jsonCodeResults = jsonCode["results"];
      for (var movie in jsonCodeResults) {
        movies.add(MovieModel.fromJson(movie));
      }
      return movies;
    }
    throw Error();
  }

  Future<MovieDetailModel> getMovieById(int id) async {
    final url =
        Uri.parse("https://movies-api.nomadcoders.workers.dev/movie?id=${id}");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final movie = jsonDecode(response.body);
      return MovieDetailModel.fromJson(movie);
    }
    throw Error();
  }
}
