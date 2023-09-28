class Cat {
  String color, state;
  int age;

  Cat({
    required this.color,
    required this.state,
    required this.age,
  });

  Cat.createCheese({
    required String state,
    required int age,
  })  : this.state = state,
        this.age = age,
        this.color = 'cheese';

  Cat.createTabby({
    required String state,
    required int age,
  })  : this.state = state,
        this.age = age,
        this.color = 'tabby';

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
  Cat cat1 = Cat.createCheese(
    state: 'healthy',
    age: 15,
  );
  Cat cat2 = Cat.createTabby(
    state: 'healthy',
    age: 6,
  );
  cat0.meow();
  cat1.meow();
  cat2.meow();
}
