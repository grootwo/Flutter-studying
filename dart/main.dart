void main() {
  var oldFriends = ['cat', 'dog'];
  var newFriends = [
    'Parrot',
    'Elephant',
    for (var friend in oldFriends) '👐 $friend',
  ];
  print(newFriends);
}