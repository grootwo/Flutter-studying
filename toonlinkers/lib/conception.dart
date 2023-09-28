enum Color {
  cheese,
  tabby,
  gray,
  black,
}

abstract class Animal {
  void breath();
}

class Cat extends Animal {
  String state;
  Color color;
  int age;

  Cat({
    required this.color,
    required this.state,
    required this.age,
  });

  void breath() {
    print('breathing..');
  }

  void meow() {
    print('meow $color cat! I\'m $state and $age');
  }
}

void main() {
  Cat cat0 = Cat(
    color: Color.gray,
    state: 'healthy',
    age: 15,
  )
    ..color = Color.tabby
    ..state = 'okay'
    ..meow()
    ..breath();
}
