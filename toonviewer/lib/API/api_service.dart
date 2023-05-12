import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:toonviewer/models/webtoon_model.dart';
import 'package:toonviewer/models/webtoon_detail_model.dart';

class ApiService {
  String baseUri = "https://webtoon-crawler.nomadcoders.workers.dev";
  String today = "today";

  Future<List<WebtoonModel>> getTodayToons() async {
    List<WebtoonModel> webtoons = [];
    final url = Uri.parse("$baseUri/$today");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> webtoonCodes = jsonDecode(response.body);
      for (var webtoon in webtoonCodes) {
        webtoons.add(WebtoonModel.fromJson(webtoon));
      }
      return webtoons;
    }
    throw Error();
  }

  Future<WebtoonDetailModel> getWebtoonById(String id) async {
    final url = Uri.parse("$baseUri/$id");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final webtoon = jsonDecode(response.body);
      return WebtoonDetailModel.fromJson(webtoon);
    }
    throw Error();
  }
}
