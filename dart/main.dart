String sayInfo(String name, String hobby, [int? num = 0]) {
  return "$name likes to do $hobby for fun and input $num";
}

void main() {
  print(sayInfo('Hola', 'Judo', 70));
}