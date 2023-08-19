import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_app/models/seekbar.dart';
import 'package:music_app/models/song.dart';
import 'package:music_app/widgets/player_buttons.dart';
import 'package:music_app/widgets/seekbar_widget.dart';
import 'package:rxdart/rxdart.dart' as rxdart;

class SongScreen extends StatefulWidget {
  final Song song;

  const SongScreen({
    super.key,
    required this.song,
  });

  @override
  State<SongScreen> createState() => _SongScreenState();
}

class _SongScreenState extends State<SongScreen> {
  AudioPlayer audioPlayer = AudioPlayer();

  Stream<SeekBar> get _seekBarDataStream =>
      rxdart.Rx.combineLatest2<Duration, Duration?, SeekBar>(
          audioPlayer.positionStream, audioPlayer.durationStream,
          (Duration position, Duration? duration) {
        return SeekBar(position: position, duration: duration ?? Duration.zero);
      });

  @override
  void initState() {
    super.initState();
    audioPlayer.setAudioSource(
      ConcatenatingAudioSource(
        children: [
          AudioSource.uri(
            Uri.parse('asset:///${widget.song.url}'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    audioPlayer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Hero(
            tag: widget.song.coverUrl,
            child: Image.asset(
              widget.song.coverUrl,
              fit: BoxFit.cover,
            ),
          ),
          const _BackgroundFilter(),
          _MusicPlayer(
            song: widget.song,
            seekBarDataStream: _seekBarDataStream,
            audioPlayer: audioPlayer,
          ),
        ],
      ),
    );
  }
}

class _MusicPlayer extends StatelessWidget {
  const _MusicPlayer({
    super.key,
    required this.song,
    required Stream<SeekBar> seekBarDataStream,
    required this.audioPlayer,
  }) : _seekBarDataStream = seekBarDataStream;

  final Stream<SeekBar> _seekBarDataStream;
  final AudioPlayer audioPlayer;
  final Song song;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 20,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            song.title,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 5),
          Text(
            song.description,
            maxLines: 2,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Colors.white,
                ),
          ),
          const SizedBox(height: 30),
          StreamBuilder<SeekBar>(
            stream: _seekBarDataStream,
            builder: (context, snapshot) {
              final positionData = snapshot.data;
              return SeekBarWidget(
                position: positionData?.position ?? Duration.zero,
                duration: positionData?.duration ?? Duration.zero,
                onChangedEnd: audioPlayer.seek,
              );
            },
          ),
          PlayersButtons(audioPlayer: audioPlayer),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                iconSize: 40,
                onPressed: () => null,
                icon: const Icon(
                  Icons.settings_applications,
                  color: Colors.white,
                ),
              ),
              IconButton(
                iconSize: 40,
                onPressed: () => null,
                icon: const Icon(
                  Icons.cloud_circle,
                  color: Colors.white,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class _BackgroundFilter extends StatelessWidget {
  const _BackgroundFilter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect rect) {
        return LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              Colors.white.withOpacity(0.5),
              Colors.white.withOpacity(0.0),
            ],
            stops: const [
              0.0,
              0.4,
              0.6
            ]).createShader(rect);
      },
      blendMode: BlendMode.dstOut,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.deepPurple.shade200,
              Colors.deepPurple.shade800,
            ],
          ),
        ),
      ),
    );
  }
}
