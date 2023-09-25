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
}