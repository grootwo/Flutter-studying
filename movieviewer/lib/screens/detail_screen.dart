import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:movieviewer/API/api_service.dart';
import 'package:movieviewer/models/movie_detail_model.dart';

class DetailScreen extends StatefulWidget {
  final int id;
  final String title, poster_path;
  // final String overview;
  // final List<String> genres;
  // final double vote_average;
  const DetailScreen({
    super.key,
    required this.id,
    required this.title,
    required this.poster_path,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<MovieDetailModel> movie;

  @override
  void initState() {
    super.initState();
    movie = ApiService().getMovieById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Color.fromARGB(0, 255, 255, 255),
        shadowColor: Color.fromARGB(0, 255, 255, 255),
        elevation: 5,
        toolbarHeight: 60.0,
        title: Text(
          'Back to list',
          style: const TextStyle(
            fontSize: 23,
          ),
        ),
      ),
      body: FutureBuilder(
        future: movie,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 50,
                    ),
                  ),
                  Row(
                    children: [
                      // for (var genre in snapshot.data!.genres) Text(genre),
                      Text('${snapshot.data!.vote_average}'),
                    ],
                  ),
                  Text(snapshot.data!.overview),
                ],
              ),
            );
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
