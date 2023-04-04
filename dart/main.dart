String sayInfo({
  String name = "Anonymous",
  String hobby = "somthing",
  int num = 0,
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