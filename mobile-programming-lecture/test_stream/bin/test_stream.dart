import 'dart:async';

void main() async {
  var stream = Stream.fromIterable([1, 2, 3]);

  stream.last.then((value) => print('last: $value'));
  stream.isEmpty.then((value) => print('isEmpty: $value'));
  stream.length.then((value) => print('length: $value'));
  stream.first.then((value) => print('first: $value'));
}