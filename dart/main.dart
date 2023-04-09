abstract class Creature {
	void live();
}

enum Team { red, blue }

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
		print("Creture is living");
	}
}

void main() {
	var player1 = Player(
		name: 'hwido',
		xp: 99,
		team: Team.red,
		grade: 100,
	);
	player1.sayHello();
	player1.live();
}