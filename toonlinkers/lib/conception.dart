class Cat {
  String color = 'cheese';
  final String state = 'healty';

  void meow() {
    print('meow $color cat! I\'m $state');
  }
}

void main() {
  Cat someCat = Cat();
  someCat.color = 'blak and white';
  someCat.meow();
}
