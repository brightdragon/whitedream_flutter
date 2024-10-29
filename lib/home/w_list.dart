
import 'package:flutter/material.dart';
import 'package:whitedream/home/enum/audio_state.dart';

class ListWidget extends StatelessWidget {

  final List<PlayTrack> playTrackList = PlayTrack.values;
  final Function(PlayTrack) onPress;

  const ListWidget({super.key, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) {
          PlayTrack track = playTrackList[index];

          return ListTile(
            leading: Icon(Icons.surround_sound),
            title: GestureDetector(
              onTap: (){
                onPress(track);
              },
              child: Text(track.name),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
        itemCount: playTrackList.length
    );
  }
}
