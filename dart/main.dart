class Player {
	String name = 'hwido';
	int xp = 999;
	void sayHello() {
		print('hi my name is $name');
	}
}

void main() {
	var player1 = Player();
	print(player1.name);
	player1.sayHello();
}