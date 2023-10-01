import 'package:flutter/material.dart';

class CurrencyCard extends StatelessWidget {
  final String currencyType, price, currencyTypeShort;
  final IconData currencyIcon;
  final bool isInverted;
  final int dy;

  final Color _black = const Color.fromARGB(255, 69, 69, 69);

  const CurrencyCard({
    super.key,
    required this.currencyType,
    required this.price,
    required this.currencyTypeShort,
    required this.currencyIcon,
    required this.isInverted,
    required this.dy,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, dy * 10),
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: isInverted ? _black : Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    currencyType,
                    style: TextStyle(
                      color: isInverted ? Colors.white : _black,
                      fontSize: 30,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        price,
                        style: TextStyle(
                          color: isInverted ? Colors.white : _black,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        currencyTypeShort,
                        style: TextStyle(
                          color: isInverted ? Colors.white : _black,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Transform.scale(
                scale: 2.1,
                child: Transform.translate(
                  offset: const Offset(
                    -5,
                    15,
                  ),
                  child: Icon(
                    currencyIcon,
                    color: isInverted ? Colors.white : _black,
                    size: 90,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
