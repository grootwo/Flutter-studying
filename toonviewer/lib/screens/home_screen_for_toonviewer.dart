import 'package:flutter/material.dart';
import 'package:toonviewer/API/api_service.dart';
import 'package:toonviewer/models/webtoon_model.dart';
import 'package:toonviewer/widgets/wetoon_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  Future<List<WebtoonModel>> webtoons = ApiService().getTodayToons();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 5,
        toolbarHeight: 60.0,
        title: const Text(
          "Today's webtoon",
          style: TextStyle(
            fontSize: 23,
          ),
        ),
      ),
      body: FutureBuilder(
        future: webtoons,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Expanded(child: makeList(snapshot)),
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  ListView makeList(AsyncSnapshot<List<WebtoonModel>> snapshot) {
    return ListView.separated(
      separatorBuilder: (context, index) => const SizedBox(
        width: 40,
      ),
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        var webtoon = snapshot.data![index];
        return Webtoon(
          title: webtoon.title,
          thumb: webtoon.thumb,
          id: webtoon.id,
        );
      },
      itemCount: snapshot.data!.length,
    );
  }
}
