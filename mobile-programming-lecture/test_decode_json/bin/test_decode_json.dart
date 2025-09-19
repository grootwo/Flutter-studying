import 'dart:convert';

void main(List<String> arguments) {
  var jsonString = '''
  [
    {"score": 40,
    "name": "Alice"},
    {"score": 80,
    "name": "Bob"}
  ]
''';
  var scores = jsonDecode(jsonString);
  print(scores is List); // true
  var firstScore = scores[0];
  print(firstScore is Map); // true
  print(firstScore['name']); // Alice
  print(firstScore['score']); // 40
}