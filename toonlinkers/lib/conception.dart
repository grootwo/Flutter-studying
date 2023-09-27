typedef intList = List<int>;

intList reverseIntList(intList list) {
  var reversed = list.reversed;
  return reversed.toList();
}

void main() {
  var someIntList = [0, 1, 2];
  someIntList = reverseIntList(someIntList);
}
