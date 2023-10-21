import 'package:flutter/material.dart';
import 'package:toonlinkers/models/webtoon_episode_model.dart';

class Episode extends StatelessWidget {
  final String episodeId;

  const Episode({
    super.key,
    required this.episode,
    required this.episodeId,
  });

  final WebtoonEpisodeModel episode;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(
          bottom: 10,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.3),
                offset: const Offset(3, 3),
                blurRadius: 5)
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 25,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                episode.title,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              const Icon(
                Icons.chevron_right_outlined,
              ),
            ],
          ),
        ));
  }
}
