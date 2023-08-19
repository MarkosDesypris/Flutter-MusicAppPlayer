import 'package:flutter/material.dart';
import 'package:music_app/models/playlist.dart';
import 'package:music_app/screens/playlist_screen.dart';

class PlaylistCard extends StatelessWidget {
  const PlaylistCard({
    super.key,
    required this.playlist,
  });

  final Playlist playlist;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => PlaylistScreen(playlist: playlist),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.deepPurple.withOpacity(0.8),
          borderRadius: BorderRadius.circular(15.0),
        ),
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Hero(
              tag: playlist.imageUrl,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.network(
                  playlist.imageUrl,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    playlist.title,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${playlist.songs.length} songs',
                    maxLines: 2,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () => null,
              icon: Icon(
                Icons.play_circle,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
