class Creature {
  final String name;
  Creature({required this.name});
	void printLive() {
    print("I'm alive and my name is $name");
  }
}

enum Group { cat, dog }

class Player extends Creature {
	Group group;
	Player({required name, required this.group,}) : super(name: name);
	
  @override
  void printLive() {
    super.printLive();
    print("And my group is $group");
  }
}

void main() {
	var player1 = Player(
		name: "hwido",
		group: Group.cat,
	);
	player1.printLive();
}