import 'dart:convert';

var scores = [
  {'score': 40},
  {'score': 100},
  {'score': 120, 'overtime': true, 'special_guest': null}
];

void main() {
  var jsonText = jsonEncode(scores);
  print(jsonText);

  print(jsonText == "[{'score': 40},{'score': 100},{'score': 120, 'overtime': true, 'special_guest': null}]"); // false
  print(jsonText == '[{"score":40},{"score":100},{"score":120,"overtime":true,"special_guest":null}]'); // true

  final obj = jsonDecode(jsonText);
  print(obj is List); // true
  print(obj[2]['overtime'] == true); // true
  print(obj[2]['special_guest'] == null); // true
}