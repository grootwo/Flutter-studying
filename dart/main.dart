class Creature {
  final String name;
  Creature({required this.name});
	void printLive() {
    print("I'm alive and my name is $name");
  }
}

enum Team { cat, dog }

class Player extends Creature {
	Team team;
	Player({required name, required this.team,}) : super(name: name);
}

void main() {
	var player1 = Player(
		name: 'hwido',
		team: Team.red,
	);
	player1.printLive();
}