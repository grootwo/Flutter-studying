void main() {
  Car bmw = Car(320, 100000, 'BMW');
  Car toyota = Car(250, 70000, 'TOYOTA');
  Car ford = Car(200, 80000, 'FORD');

// 처음 가격 출력
  print('first price: ${bmw.price.toInt()}'); // 100000

// 세 번 할인 적용
  bmw.doublesaleCar();
  bmw.doublesaleCar();
  bmw.doublesaleCar();

// 최종 가격 출력
  print('final price: ${bmw.price.toInt()}'); // 72900
}

class Car {
  int maxSpeed = 0;
  double price = 0;
  String name = '';

  Car(int maxSpeed, double price, String name) {
    this.maxSpeed= maxSpeed;
    this.price= price;
    this.name = name;
  }

  doublesaleCar() {
    price= price* 0.9;
    return price;
  }
}