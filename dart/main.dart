// left : right
// if left is null return right
String getUpper(String? text) => text?.toUpperCase() ?? "NONE";

void main() {
  print(getUpper('test'));
}