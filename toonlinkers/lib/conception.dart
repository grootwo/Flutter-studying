class Cat {
  late String color;
  late final String state;

  // Cat(String color, String state) {
  //   this.color = color;
  //   this.state = state;
  // }
  Cat(this.color, this.state);

  void meow() {
    print('meow $color cat! I\'m $state');
  }
}

void main() {
  Cat cat1 = Cat('cheese', 'healthy');
  Cat cat2 = Cat('black and white', 'healthy');
  cat1.meow();
  cat2.meow();
}
