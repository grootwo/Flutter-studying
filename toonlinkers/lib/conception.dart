String makeIntro(String name, int age, [String? major = 'unknown']) =>
    'name: $name, age: $age, major: $major';

void main() {
  print(makeIntro('hola', 30));
}
