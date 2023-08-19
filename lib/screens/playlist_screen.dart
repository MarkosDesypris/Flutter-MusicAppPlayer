import 'package:flutter/material.dart';
import 'package:music_app/models/playlist.dart';

class PlaylistScreen extends StatelessWidget {
  final Playlist playlist;

  const PlaylistScreen({
    super.key,
    required this.playlist,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.deepPurple.shade800.withOpacity(0.8),
            Colors.deepPurple.shade200.withOpacity(0.8),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: true,
          title: const Text('Playlist'),
          actions: [
            IconButton(
              onPressed: () => null,
              icon: const Icon(
                Icons.more_vert,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                _PlaylistInformation(playlist: playlist),
                const SizedBox(height: 20),
                const _PlayOrShuffleSwitch(),
                ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(top: 10),
                    itemCount: playlist.songs.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          color: Colors.deepPurple.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: ListTile(
                          minLeadingWidth: 20,
                          leading: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              '${index + 1}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                          title: Text(
                            playlist.songs[index].title,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            playlist.songs[index].description,
                          ),
                          trailing: const Icon(
                            Icons.more_vert,
                            color: Colors.white,
                          ),
                        ),
                      );
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PlayOrShuffleSwitch extends StatefulWidget {
  const _PlayOrShuffleSwitch({
    super.key,
  });

  @override
  State<_PlayOrShuffleSwitch> createState() => _PlayOrShuffleSwitchState();
}

class _PlayOrShuffleSwitchState extends State<_PlayOrShuffleSwitch> {
  bool isPlay = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isPlay = !isPlay;
        });
      },
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              left: isPlay ? 0 : MediaQuery.of(context).size.width * 0.45,
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.45,
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade400,
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Play',
                        style: TextStyle(
                          color: isPlay ? Colors.white : Colors.deepPurple,
                          fontSize: 17,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Icon(
                        Icons.play_circle,
                        color: isPlay ? Colors.white : Colors.deepPurple,
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Shuffle',
                        style: TextStyle(
                          color: isPlay ? Colors.deepPurple : Colors.white,
                          fontSize: 17,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Icon(
                        Icons.shuffle,
                        color: isPlay ? Colors.deepPurple : Colors.white,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PlaylistInformation extends StatelessWidget {
  const _PlaylistInformation({
    super.key,
    required this.playlist,
  });

  final Playlist playlist;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Hero(
          tag: playlist.imageUrl,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Image.network(
              playlist.imageUrl,
              width: MediaQuery.of(context).size.height * 0.3,
              height: MediaQuery.of(context).size.height * 0.3,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          playlist.title,
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        )
      ],
    );
  }
}
