import 'package:flutter/material.dart';
import 'package:movieviewer/API/api_service.dart';
import 'package:movieviewer/models/movie_model.dart';
import 'package:movieviewer/widgets/movie_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<MovieModel>> popularMovies = ApiService().getPopularMovies();
  late Future<List<MovieModel>> playingMovies = ApiService().getPlayingMovies();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(
            height: 100,
          ),
          CategoryTitle(
            title: 'Popular Movies',
          ),
          FutureBuilder(
            future: popularMovies,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Expanded(
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        var movie = snapshot.data![index];
                        return MovieWidget(
                          id: movie.id,
                          poster_path: movie.poster_path,
                          title: movie.title,
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Container(
                          width: 40,
                        );
                      },
                      itemCount: snapshot.data!.length),
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
          CategoryTitle(
            title: 'Now in Cinemas',
          ),
          FutureBuilder(
            future: playingMovies,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Expanded(
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        var movie = snapshot.data![index];
                        return MovieWidget(
                          id: movie.id,
                          poster_path: movie.poster_path,
                          title: movie.title,
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Container(
                          width: 40,
                        );
                      },
                      itemCount: snapshot.data!.length),
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
          CategoryTitle(
            title: 'Coming Soon',
          ),
        ],
      ),
    );
  }
}

class CategoryTitle extends StatelessWidget {
  final String title;
  const CategoryTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          Text(
            '$title',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
