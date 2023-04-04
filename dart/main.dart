String sayName(String name) {
  name = name + '!';
  return 'It\'s $name';
}

num getSum(num num1, num num2) => num1 + num2;

void main() {
  print(sayName('hola'));
  print(getSum(0, 10));
}