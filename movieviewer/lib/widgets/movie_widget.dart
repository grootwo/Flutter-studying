import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../screens/detail_screen.dart';

class MovieWidget extends StatelessWidget {
  final String poster_path, title;
  final int id;

  const MovieWidget({
    super.key,
    required this.id,
    required this.poster_path,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(
              title: title,
              poster_path: poster_path,
              id: id,
            ),
          ),
        );
      },
      child: Column(
        children: [
          Container(
            width: 200,
            height: 300,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.4),
                  blurRadius: 10.0,
                  offset: const Offset(5, 5),
                ),
              ],
            ),
            child: Image.network(
              'https://image.tmdb.org/t/p/w500/${poster_path}',
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: 200,
            child: Text(
              title,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
    ;
  }
}
