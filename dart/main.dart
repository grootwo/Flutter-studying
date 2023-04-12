class Intelligence {
  int intelligenceLevel = 0;
  void setILevel(int level) {
    this.intelligenceLevel = level;
  }
  void printILevel() {
    print("Intelligence level: $intelligenceLevel");
  }
}

class Creature {
  final String name;
  Creature({required this.name});
	void printLive() {
    print("I'm alive and my name is $name");
  }
}

enum Group { cat, dog }

class Player extends Creature with Intelligence {
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
		name: "halo",
		group: Group.cat,
	);
	player1.printLive();
  
  player1.setILevel(100);
  player1.printILevel();
}