class Player {
	final String name, team;
	int xp, grade;

	Player({
		required this.name,
		required this.xp,
		required this.team,
		required this.grade,		
	});
	Player.createRedPlayer({required String name, required int grade }) :
		this.grade = grade,
		this.name = name,
		this.xp = 10,
		this.team = "Red";

	Player.createBluePlayer(String name, int grade) :
		this.grade = grade,
		this.name = name,
		this.xp = 0,
		this.team = "Blue";
  
   sayHello() {
      print("$name / $team / $xp / $grade");
   }
 }

void main() {
	var player1 = Player.createRedPlayer(
		name: "halo",
		grade: 4,
	);
   player1.sayHello();
	var player2 = Player.createBluePlayer("sky", 5);
   player2.sayHello();
}