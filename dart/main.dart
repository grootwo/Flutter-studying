// typedef can make alias to data types
typedef MyMap = Map<String, String>;

String getMyMap(MyMap input) {
  return "${input['first']}, ${input['second']}";
}

void main() {
  print(getMyMap({'first': 'FIRST', 'second': 'SECOND'}));
}