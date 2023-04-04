void main() {
  String? text;
  text ??= 'not null';
  text ??= 'not null 2';
  print(text);
}