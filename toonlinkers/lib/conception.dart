enum Color {
  cheese,
  tabby,
  gray,
  black,
}

mixin Agile {
  void crawl() {
    print('Crawling..');
  }
}

mixin Cute {
  void sayCute() {
    print('I\'m cute..');
  }
}

class Animal {
  late String type;

  Animal({required this.type});

  void breath() {
    print('I\'m breathing..');
  }
}

class Cat extends Animal with Cute, Agile {
  String state;
  Color color;

  Cat({
    required this.color,
    required this.state,
    required type,
  }) : super(type: type);

  @override
  void breath() {
    super.breath();
    print('I\'m breathing again..');
  }

  void meow() {
    print('meow $color cat! I\'m $state.');
  }
}

class Dog with Cute, Agile {}

void main() {
  Cat cat0 = Cat(
    color: Color.gray,
    state: 'healthy',
    type: 'cat',
  );
  cat0.breath();
  cat0.meow();
  cat0.crawl();
  Dog dog0 = Dog();
  dog0.sayCute();
}
