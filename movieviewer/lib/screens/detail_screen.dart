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
      body: Column(children: [
        Text(
          widget.title,
          style: TextStyle(
            fontSize: 50,
          ),
        )
      ]),
    );
  }
}
