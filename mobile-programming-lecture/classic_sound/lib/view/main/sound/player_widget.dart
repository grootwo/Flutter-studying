import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class PlayerWidget extends StatefulWidget {
  final AudioPlayer player;

  const PlayerWidget({
    required this.player,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _PlayerWidgetState();
}

class _PlayerWidgetState extends State<PlayerWidget> {
  PlayerState? _playerState;
  Duration? _duration;
  Duration? _position;

  StreamSubscription? _durationSubscription;
  StreamSubscription? _positionSubscription;
  StreamSubscription? _playerCompleteSubscription;
  StreamSubscription? _playerStateChangeSubscription;

  bool get _isPlaying => _playerState == PlayerState.playing;
  bool get _isPaused => _playerState == PlayerState.paused;

  String get _durationText => _duration?.toString().split('.').first ?? '';
  String get _positionText => _position?.toString().split('.').first ?? '';

  AudioPlayer get _player => widget.player;

  @override
  void initState() {
    super.initState();
    _playerState = _player.state;
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
    if (this.mounted) {
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
            if (_duration == null) return;
            final position = v * _duration!.inMilliseconds;
            _player.seek(Duration(milliseconds: position.round()));
          },
          value: (_position != null &&
              _duration != null &&
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
      ],
    );
  }

  void _initStreams() {
    _durationSubscription = _player.onDurationChanged.listen((duration) {
      setState(() => _duration = duration);
    });

    _positionSubscription = _player.onPositionChanged.listen(
          (p) => setState(() => _position = p),
    );

    _playerCompleteSubscription = _player.onPlayerComplete.listen((event) {
      setState(() {
        _playerState = PlayerState.stopped;
        _position = Duration.zero;
      });
    });

    _playerStateChangeSubscription = _player.onPlayerStateChanged.listen((state) {
      setState(() {
        _playerState = state;
      });
    });
  }



  /// 재생
  Future<void> _play() async {
    final position = _position;
    if (position != null && position.inMilliseconds > 0) {
      await _player.seek(position);
    }

    await _player.resume();
    setState(() => _playerState = PlayerState.playing);
  }

  /// 일시정지
  Future<void> _pause() async {
    await _player.pause();
    setState(() => _playerState = PlayerState.paused);
  }

  Future<void> _prev() async {

  }

  Future<void> _next() async {

  }
}
