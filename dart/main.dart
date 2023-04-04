String sayInfo({
  required String name,
  required String hobby,
  required int num,
}) {
  return "$name likes to do $hobby for fun and input $num";
}

void main() {
  print(sayInfo(
    name: 'Hola',
    num: 50,
    hobby: 'Judo',
  ));
}