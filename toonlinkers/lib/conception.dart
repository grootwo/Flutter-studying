class Cat {
  String color, state;
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
  Cat cat0 = Cat(
    color: 'gray',
    state: 'healthy',
    age: 15,
  );
  var something = cat0
    ..color = 'tabby'
    ..state = 'okay'
    ..meow();
  // cat0.color = 'tabby';
  // cat0.state = 'okay';
  // cat0.meow();
}
