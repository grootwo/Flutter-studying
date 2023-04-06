class Player {
	late final String name;
	late int xp;
	Player(String name, int xp) {
		this.name = name;
		this.xp = xp;
	}
	void sayHello() {
		print('hi my name is $name ($xp)');
	}
}

void main() {
	var player1 = Player('hwido', 99);
	print(player1.name);
	player1.sayHello();
}