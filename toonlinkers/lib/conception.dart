String makeIntro({
  required String name,
  required int age,
  required String major,
}) {
  return 'name: $name, age: $age, major: $major';
}

void main() {
  print(makeIntro(
    name: 'hola',
    major: 'computer science',
    age: 30,
  ));
  // makeIntro();
}
