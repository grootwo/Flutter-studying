void sayHallo(String name) {
  print('Hallo $name');
}

String returnHallo(String name) {
  return 'Hallo $name';
}

num mutiple(num num1, num num2) => num1 * num2;

void main() {
  sayHallo('some cat');
  print(returnHallo('some dog'));
  var answer = mutiple(3, 10.3);
}
