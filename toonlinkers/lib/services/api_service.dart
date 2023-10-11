import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:toonlinkers/models/webtoon_model.dart';

class ApiService {
  final String baseUrl = 'https://webtoon-crawler.nomadcoders.workers.dev';
  final String today = 'today';

  Future<List<WebtoonModel>> getTodayWebtoons() async {
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
}
