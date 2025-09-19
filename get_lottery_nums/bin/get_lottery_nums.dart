import 'dart:math' as math;

void main() {
  var rand = math.Random();
  Set<int> lotteryNums = Set();

  while (lotteryNums.length < 6) {
    lotteryNums.add(rand.nextInt(45) + 1); // 0 ~ 45
  }

  final lotteryNumsList = lotteryNums.toList();
  lotteryNumsList.sort();

  print(lotteryNumsList);
}