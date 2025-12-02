import 'package:classic_sound/data/local_database.dart';
import 'package:classic_sound/view/main/sound/download_listtile.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '../../data/music.dart';

class UserPage extends StatefulWidget {
  final Database database;

  const UserPage({super.key, required this.database});

  @override
  State<StatefulWidget> createState() {
    return _UserPage();
  }
}

class _UserPage extends State<UserPage> {
  late Future<List<Map<String, dynamic>>> _data;

  @override
  void initState() {
    super.initState();
    _data = MusicDatabase(widget.database).getMusic();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('내가 내려받은 음악'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _data,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              final data = snapshot.data;
              return ListView.builder(
                itemCount: data!.length,
                itemBuilder: (context, index) {
                  final music = data[index];

                  return DownloadListTile(
                    music: Music(
                      music['name'],
                      music['composer'],
                      music['tag'],
                      music['category'],
                      music['size'],
                      music['type'],
                      music['downloadUrl'],
                      music['imageDownloadUrl'],
                    ),
                    database: widget.database,   // ✔ DB 전달 정상
                  );
                },
              );
            } else {
              return const Center(
                child: Text('No data found'),
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
