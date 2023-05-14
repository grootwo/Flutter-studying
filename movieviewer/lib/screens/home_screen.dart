import 'package:flutter/material.dart';
import 'package:movieviewer/API/api_service.dart';
import 'package:movieviewer/models/movie_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<MovieModel>> popularMovies = ApiService().getPopularMovies();

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
                        return Column(
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
                                'https://image.tmdb.org/t/p/w500/${movie.poster_path}',
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: 200,
                              child: Text(
                                movie.title,
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
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
