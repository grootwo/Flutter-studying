import 'package:flutter/material.dart';
import 'package:toonviewer/API/api_service.dart';
import 'package:toonviewer/models/webtoon_detail_model.dart';
import 'package:toonviewer/models/webtoon_episode_model.dart';

class DetailScreen extends StatefulWidget {
  final String title;
  final String thumb;
  final String id;

  const DetailScreen({
    super.key,
    required this.title,
    required this.thumb,
    required this.id,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<WebtoonDetailModel> webtoon;
  late Future<List<WebtoonEpisodeModel>> episodes;

  @override
  void initState() {
    super.initState();
    webtoon = ApiService().getWebtoonById(widget.id);
    episodes = ApiService().getEpisodesById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 5,
        toolbarHeight: 60.0,
        title: Text(
          widget.title,
          style: const TextStyle(
            fontSize: 23,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 30,
            vertical: 40,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: widget.id,
                    child: Container(
                      width: 250,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.4),
                              blurRadius: 10.0,
                              offset: const Offset(5, 5),
                            ),
                          ]),
                      child: Image.network(
                        widget.thumb,
                        headers: const {
                          "User-Agent":
                              "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36",
                        },
                      ),
                    ),
                  ),
                ],
              ),
              FutureBuilder(
                future: webtoon,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        Text(
                          '${snapshot.data!.genre} | ${snapshot.data!.age}',
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          snapshot.data!.about,
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    );
                  } else {
                    return const Text('...');
                  }
                },
              ),
              const SizedBox(
                height: 50,
              ),
              FutureBuilder(
                future: episodes,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        for (var episode in snapshot.data!)
                          Container(
                            decoration: const BoxDecoration(
                              border: Border(
                                top: BorderSide(),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 25,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    episode.title,
                                    style: const TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                  const Icon(Icons.arrow_forward_rounded),
                                ],
                              ),
                            ),
                          )
                      ],
                    );
                  }
                  return Container();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
