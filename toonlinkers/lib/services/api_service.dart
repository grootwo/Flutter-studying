import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:toonlinkers/models/webtoon_detail_model.dart';
import 'package:toonlinkers/models/webtoon_episode_model.dart';
import 'package:toonlinkers/models/webtoon_model.dart';

class ApiService {
  static const String baseUrl =
      'https://webtoon-crawler.nomadcoders.workers.dev';
  static const String today = 'today';

  static Future<List<WebtoonModel>> getTodayWebtoons() async {
    List<WebtoonModel> webtoons = [];
    final url = Uri.parse('$baseUrl/$today');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> webtoonsJson = jsonDecode(response.body);
      for (var webtoonJson in webtoonsJson) {
        webtoons.add(WebtoonModel.fromJson(webtoonJson));
      }
      return webtoons;
    }
    throw Error();
  }

  static Future<WebtoonDetailModel> getToonInfoById(String id) async {
    final url = Uri.parse('$baseUrl/$id');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      dynamic webtoonInfoJson = jsonDecode(response.body);
      return WebtoonDetailModel.fromJson(webtoonInfoJson);
    } else {
      throw Error();
    }
  }

  static Future<List<WebtoonEpisodeModel>> getEpisodesInfoById(
      String id) async {
    List<WebtoonEpisodeModel> episodes = [];
    final url = Uri.parse('$baseUrl/$id');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      dynamic webtoonEpisodesInfoJson = jsonDecode(response.body);
      for (var episodeJson in webtoonEpisodesInfoJson) {
        episodes.add(WebtoonEpisodeModel.fromJson(episodeJson));
      }
      return episodes;
    } else {
      throw Error();
    }
  }
}
