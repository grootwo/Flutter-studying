// semi colon and main function are important
void main() {
  print("hello world!");

  // inside of function and method, use var
  var animal = 'a cat';
  animal = 'a dog';
  // inside of class, use specific type
  String name = 'a cat';
  name = 'a dog';

  // something is dynamic type
  var something;
  something = 100;
  something = 'one hundred';
  something = true;
  if (something is String) {
    print(something.length);
  }
  if (something is int) {
    print(something.isOdd);
  }

  // nullable can be possible with ?
  String greeting = 'hello';
  // greeting = null;
  String? nullGreeting = 'hello';
  nullGreeting = null;
  // if nullGreeting is not null, do next
  nullGreeting?.isEmpty;

  // final var won't be changed
  final lastVar = 'This is final definition';

  // late var can be assigned later, but can be used after assignment
  late final String lately;
  // do something, go to api
  lately = 'hallo';
  // lately = 'hallo later';

  // constant is known while compile time
  const anExample = 'http://something';

  // list
  var check = true;
  var nums = [
    0,
    1,
    2,
    3,
    4,
    if (check) 5,
  ];
  List<String> strs = [
    'abc',
    'bcd',
    'cde',
  ];
  print(nums.last);
  print(strs.isNotEmpty);

  // string interpolation
  var meaning = '안녕';
  var count = 0;
  var sentence = '\'hallo means $meaning, and you can say ${count + 1}\'';
  print(sentence);

  // collection for
  var cuteAnimals = [
    'cat',
    'dog',
  ];
  var coolAnimals = [
    'koala',
    'kangaroo',
    'squirrel',
    for (var animal in cuteAnimals) '$animal 🥳',
  ];
}
