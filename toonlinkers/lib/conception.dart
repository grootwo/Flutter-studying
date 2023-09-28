class Cat {
  String color;
  final String state;
  int age;

  Cat({
    required this.color,
    required this.state,
    required this.age,
  });

  void meow() {
    print('meow $color cat! I\'m $state and $age');
  }
}

void main() {
  Cat cat1 = Cat(
    color: 'cheese',
    state: 'healthy',
    age: 15,
  );
  Cat cat2 = Cat(
    color: 'black and white',
    state: 'healthy',
    age: 6,
  );
  cat1.meow();
  cat2.meow();
}
