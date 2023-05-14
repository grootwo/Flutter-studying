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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            Row(
              children: const [
                Text(
                  'Popular Movies',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            FutureBuilder(
              future: popularMovies,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Expanded(
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          var movie = snapshot.data![index];
                          return Column(
                            children: [
                              Container(),
                              Text('$movie.title'),
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
                return Container();
              },
            ),
            Row(
              children: const [
                Text(
                  'Now in Cinemas',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            Row(
              children: const [
                Text(
                  'Coming Soon',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
