import 'package:flutter/material.dart';
import 'package:toonlinkers/models/Webtoon_detail_model.dart';
import 'package:toonlinkers/models/webtoon_episode_model.dart';
import 'package:toonlinkers/services/api_service.dart';

class DetailScreen extends StatefulWidget {
  final String title, thumb, id;

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
    webtoon = ApiService.getToonInfoById(widget.id);
    episodes = ApiService.getEpisodesInfoById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: Text(
          widget.title,
          style: const TextStyle(
            fontSize: 25,
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: widget.id,
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  width: 260,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        offset: const Offset(5, 5),
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Image.network(
                    widget.thumb,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
