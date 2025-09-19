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
}