import 'dart:async';

Stream<int> countStream(int to) async* {
  for (int i = 1; i <= to; i ++) {
    print('countStream: $i');
    yield i;
  }
}

Future<int> sumStream(Stream<int> stream) async {
  var sum = 0;
  await for (var value in stream) {
    print("sumStream: $value");
    sum += value;
  }
  return sum;
}

Future<void> main() async {
  final stream = countStream(5);
  final sum = sumStream(stream);
  print('sum: $sum'); // 15
}