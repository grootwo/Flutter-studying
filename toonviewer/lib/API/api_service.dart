import 'package:http/http.dart' as http;

class ApiService {
  String baseUri = "https://webtoon-crawler.nomadcoders.workers.dev";
  String today = "today";

  void getTodayToons() async {
    final url = Uri.parse("$baseUri/$today");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      print(response.body);
      return;
    }
    throw Error();
  }
}
