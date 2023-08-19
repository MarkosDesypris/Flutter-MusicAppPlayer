import 'package:flutter/material.dart';
import 'package:music_app/models/song.dart';
import 'package:music_app/screens/song_screen.dart';

class SongCard extends StatelessWidget {
  const SongCard({
    super.key,
    required this.song,
  });

  final Song song;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => SongScreen(song: song),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Hero(
              tag: song.coverUrl,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  image: DecorationImage(
                    image: AssetImage(song.coverUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              height: 50,
              width: MediaQuery.of(context).size.width * 0.37,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.white.withOpacity(0.8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        song.title,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        song.description,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  const Icon(
                    Icons.play_circle,
                    color: Colors.deepPurple,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
