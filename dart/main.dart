class Player {
	String name, team;
	int xp, grade;

	Player({
		required this.name,
		required this.xp,
		required this.team,
		required this.grade,		
	});

	sayHello() {
    print("$name / $team / $xp / $grade");
  }
}

void main() {
	var player = Player(name: "halo", xp: 1, team: "Green", grade: 10)
	..name = "hello"
	..xp = 100
	..team = "Blue"
	..grade = 9
	..sayHello();
}