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
}