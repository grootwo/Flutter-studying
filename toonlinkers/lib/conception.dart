String makeUpper(String? str) => str?.toUpperCase() ?? 'UNKNWON';

void main() {
  makeUpper('hallo');
  makeUpper(null);
  String? check;
  // if check is null, put following value
  check ??= 'nullable';
  check ??= 'another value';
}
