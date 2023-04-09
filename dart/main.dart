abstract class Creature {
	void live();
}

enum Team { cat, dog }

class Player extends Creature {
	final String name;
	int xp;
	Team team;
	int grade;
	Player({required this.name, required this.xp, required this.team, required this.grade,});
	void sayHello() {
		print('$name, $xp, $team, $grade');
	}
	void live() {
		print("Creature is living");
	}
}

void main() {
	var player1 = Player(
		name: 'halo',
		xp: 99,
		team: Team.cat,
		grade: 100,
	);
	player1.sayHello();
	player1.live();
}