import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:toonviewer/models/webtoon_model.dart';

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
}
