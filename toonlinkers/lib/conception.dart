void sayHallo(String name) {
  print('Hallo $name');
}

String returnHallo(String name) {
  return 'Hallo $name';
}

void main() {
  sayHallo('some cat');
  print(returnHallo('some dog'));
}
