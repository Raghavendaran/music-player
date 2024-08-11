import 'package:flutter/material.dart';
import 'package:music_player/components/neu_drawer.dart';
import 'package:music_player/models/playlist_provider.dart';
import 'package:provider/provider.dart';

class SongPage extends StatelessWidget {
  const SongPage({super.key});

  // Convert duration into min:sec format
  String formatTime(Duration duration) {
    String twoDigitSeconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    String formattedTime = "${duration.inMinutes}:$twoDigitSeconds";
    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaylistProvider>(builder: (context, provider, child) {
      // Get playlist
      final playlist = provider.playlist;

      // Get current song
      final currentSong = playlist[provider.currentSongIndex ?? 0];

      // Debugging prints
      print("Current Duration: ${provider.currentDuration}");
      print("Total Duration: ${provider.totalDuration}");

      // Return scaffold UI
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Appbar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Back button
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back),
                    ),

                    // Title
                    const Text("P L A Y L I S T"),

                    // Menu
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.menu),
                    ),
                  ],
                ),
                const SizedBox(height: 25),

                // Album artwork
                NeuBox(
                  child: Column(
                    children: [
                      // Image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(currentSong.albumArtImagePath),
                      ),
                      // Song and artist name and icon
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Song and artist name
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  currentSong.songName,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(currentSong.artistName),
                              ],
                            ),
                            // Heart icon
                            const Icon(
                              Icons.favorite,
                              color: Colors.red,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),

                // Song durations
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Start time
                          Text(formatTime(provider.currentDuration)),

                          // Shuffle icon
                          const Icon(Icons.shuffle),

                          // Repeat icon
                          const Icon(Icons.repeat),

                          // End time
                          Text(formatTime(provider.totalDuration)),
                        ],
                      ),
                    ),

                    // Song duration progress
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
                        activeTrackColor: Colors.green,
                        inactiveTrackColor: Colors.grey,
                        trackHeight: 2.0,
                        overlayShape: const RoundSliderOverlayShape(overlayRadius: 16.0),
                      ),
                      child: Slider(
                        min: 0,
                        max: provider.totalDuration.inSeconds.toDouble(),
                        value: provider.currentDuration.inSeconds.toDouble(),
                        onChanged: (double newValue) {
                          // Update the slider value as user drags
                          provider.seek(Duration(seconds: newValue.toInt()));
                        },
                        onChangeEnd: (double newValue) {
                          // Seek to the new position when user releases the slider
                          provider.seek(Duration(seconds: newValue.toInt()));
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Playback controls
                Row(
                  children: [
                    // Skip previous
                    Expanded(
                      child: GestureDetector(
                        onTap: provider.playPreviousSong,
                        child: const NeuBox(
                          child: Icon(Icons.skip_previous),
                        ),
                      ),
                    ),

                    const SizedBox(width: 20),

                    // Play/Pause
                    Expanded(
                      flex: 2,
                      child: GestureDetector(
                        onTap: provider.pauseOrResume,
                        child: NeuBox(
                          child: Icon(
                            provider.isPlaying ? Icons.pause : Icons.play_arrow,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 20),

                    // Skip next
                    Expanded(
                      child: GestureDetector(
                        onTap: provider.playNextSong,
                        child: const NeuBox(
                          child: Icon(Icons.skip_next),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
