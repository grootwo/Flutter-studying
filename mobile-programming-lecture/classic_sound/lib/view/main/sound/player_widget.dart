import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:classic_sound/data/local_database.dart';
import 'package:classic_sound/data/music.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class PlayerWidget extends StatefulWidget {
  final AudioPlayer player;
  final Music music;
  final Database database;
  final Function(Music) callback;

  const PlayerWidget({
    required this.player,
    Key? key,
    required this.music,
    required this.database,
    required this.callback,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PlayerWidgetState();
}

class _PlayerWidgetState extends State<PlayerWidget> {
  PlayerState? _playerState;
  Duration? _duration;
  Duration? _position;
  late Music _currentMusic;

  StreamSubscription? _durationSubscription;
  StreamSubscription? _positionSubscription;
  StreamSubscription? _playerCompleteSubscription;
  StreamSubscription? _playerStateChangeSubscription;

  bool get _isPlaying => _playerState == PlayerState.playing;
  bool _repeatCheck = false;
  bool _shuffleCheck = false;

  String get _durationText => _duration?.toString().split('.').first ?? '';
  String get _positionText => _position?.toString().split('.').first ?? '';

  AudioPlayer get _player => widget.player;

  @override
  void initState() {
    super.initState();
    _currentMusic = widget.music;
    _playerState = _player.state;
    _initStreams();
    _player.getDuration().then((value) {
      if (mounted) setState(() => _duration = value);
    });
    _player.getCurrentPosition().then((value) {
      if (mounted) setState(() => _position = value);
    });

    _initStreams();
  }

  @override
  void dispose() {
    _durationSubscription?.cancel();
    _positionSubscription?.cancel();
    _playerCompleteSubscription?.cancel();
    _playerStateChangeSubscription?.cancel();
    super.dispose();
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).primaryColor;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Slider(
          onChanged: (v) {
            final position = v * (_duration?.inMilliseconds ?? 0);
            _player.seek(Duration(milliseconds: position.round()));
          },
          value: (_position != null &&
              _duration != null &&
              _duration!.inMilliseconds > 0 &&
              _position!.inMilliseconds >= 0 &&
              _position!.inMilliseconds <= _duration!.inMilliseconds)
              ? _position!.inMilliseconds / _duration!.inMilliseconds
              : 0.0,
        ),
        Text(
          _position != null
              ? '$_positionText / $_durationText'
              : _duration != null
              ? _durationText
              : '',
          style: const TextStyle(fontSize: 16.0),
        ),


        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              key: const Key('prev_button'),
              onPressed: _prev,
              icon: const Icon(Icons.skip_previous),
              iconSize: 44,
              color: color,
            ),

            IconButton(
              key: const Key('play_pause_button'),
              onPressed: _isPlaying ? _pause : _play,
              iconSize: 44,
              icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
              color: color,
            ),

            IconButton(
              key: const Key('next_button'),
              onPressed: _next,
              icon: const Icon(Icons.skip_next),
              iconSize: 44,
              color: color,
            ),
          ],
        ),

        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              key: const Key('repeat_button'),
              onPressed: _repeat,
              icon: const Icon(Icons.repeat),
              iconSize: 44,
              color: _repeatCheck ? Colors.lightBlue : color,
            ),
            IconButton(
              key: const Key('shuffle_button'),
              onPressed: _shuffle,
              icon: const Icon(Icons.shuffle),
              iconSize: 44,
              color: _shuffleCheck ? Colors.lightBlue : color,
            ),
          ],
        ),
      ],
    );
  }

  void _initStreams() {
    _durationSubscription = _player.onDurationChanged.listen((duration) {
      if (mounted) setState(() => _duration = duration);
    });

    _positionSubscription = _player.onPositionChanged.listen(
          (p) => {if (mounted) setState(() => _position = p)},
    );

    _playerCompleteSubscription = _player.onPlayerComplete.listen((event) {
      _onCompletion();
    });

    _playerStateChangeSubscription = _player.onPlayerStateChanged.listen((state) {
      if (mounted) setState(() => _playerState = state);
        _playerState = state;
    });
  }

Future<void> _onCompletion() async {
    if (mounted) {
      setState(() {
        _position = _repeatCheck ? Duration.zero : _duration;
      });
    }
    if (_repeatCheck) {
      await _repeatPlay();
    } else {
      await _next();
    }
}

Future<void> _repeatPlay() async {
    final dir = await getApplicationDocumentsDirectory();
    if (mounted) {
      setState(() {
        _position = Duration.zero;
      });
    }
    final path = '${dir.path}/${_currentMusic.name}';
    await _player.setSourceDeviceFile(path);
    await _player.resume();
}

  /// 재생
  Future<void> _play() async {
    final player = _player;
    final currentMusicPath = (await getApplicationDocumentsDirectory()).path + '/${_currentMusic.name}';

    try {
      if (player.state == PlayerState.paused) {
        await player.resume();
      } else {
        await player.play(DeviceFileSource(currentMusicPath), position: _position);
      }
      if (mounted) {
        setState(() => _playerState = PlayerState.playing);
      }
    } catch (e) {
      print('오디오 재생 오류: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('재생 오류: ${e.toString()}')),
        );
        setState(() => _playerState = PlayerState.stopped);
      }
    }
  }

  /// 일시정지
  Future<void> _pause() async {
    try {
      await _player.pause();
      if (mounted) {
        setState(() => _playerState = PlayerState.paused);
      }
    } catch (e) {
      print('오디오 일시 정지 오류: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('일시 정지 오류: ${e.toString()}')),
        );
      }
    }
  }

  void _repeat() {
    if (mounted) setState(() => _repeatCheck = !_repeatCheck);
  }

  void _shuffle() {
    if (mounted) setState(() => _shuffleCheck = !_shuffleCheck);
  }

  Future<void> _prev() async {
    if(!mounted) return;

    final musics = await MusicDatabase(widget.database).getMusic();
    int currentIndex = musics.indexWhere(
        (m) => m['name'] == _currentMusic.name,
    );

    if (currentIndex > 0) {
      await _playMusic(musics[currentIndex - 1]);
    } else if (currentIndex == 0) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('첫번째 곡입니다.'),));
    } else {
      if (musics.isNotEmpty) await _playMusic(musics.first);
    }
  }

  Future<void> _next() async {
    if (!mounted) return;

    final List<Map<String, dynamic>> musics = await MusicDatabase(widget.database).getMusic();
    List<Map<String, dynamic>> playlist = List.from(musics);

    if (_shuffleCheck) {
      playlist.shuffle();
      int currentShuffleIndex = playlist.indexWhere(
            (m) => m['name'] == _currentMusic.name,
      );
      if (currentShuffleIndex != -1 && currentShuffleIndex + 1 < playlist.length) {
        await _playMusic(playlist[currentShuffleIndex + 1]);
      } else if (playlist.isNotEmpty && playlist.first['name'] != _currentMusic.name) {
        await _playMusic(playlist.first);
      } else if (playlist.length > 1) {
        await _playMusic(playlist[1]);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('마지막 곡입니다.')));
      }
      return;
    }

    int currentIndex = playlist.indexWhere(
          (m) => m['name'] == _currentMusic.name,
    );

    if (currentIndex != -1 && currentIndex + 1 < playlist.length) {
      await _playMusic(playlist[currentIndex + 1]);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('마지막 곡입니다.')));
    }
  }

  Future<void> _playMusic(Map<String, dynamic> musicData) async {
    if (!mounted) return;

    final dir = await getApplicationDocumentsDirectory();
    _currentMusic = Music(
      musicData['name'],
      musicData['composer'],
      musicData['tag'],
      musicData['category'],
      musicData['size'],
      musicData['type'],
      musicData['downloadUrl'],
      musicData['imageDownloadUrl'],
    );
    final path = '${dir.path}/${_currentMusic.name}';

    try {
      await _player.play(DeviceFileSource(path));
      if (mounted) {
        widget.callback(_currentMusic);
        setState(() {
          _position = Duration.zero;
        });
      }
    } catch (e) {
      print('음악 재생 오류 (_playMusic: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('다음 곡 로딩 오류: ${e.toString()}')),
        );
        setState(() => _playerState = PlayerState.stopped);
      }
    }
  }
}
