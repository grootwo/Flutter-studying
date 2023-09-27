String makeUpper(String? str) => str != null ? str.toUpperCase() : 'UNKNOWN';

void main() {
  makeUpper('hallo');
  makeUpper(null);
}
