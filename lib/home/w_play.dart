import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whitedream/home/enum/audio_state.dart';

class PlayWidget extends StatelessWidget {
  final double width;
  final double height;
  final AnimationController animationController;
  final PlayTrack playTrack;
  final double volumeValue;
  final Function(double) volume;

  const PlayWidget({
    super.key,
    required this.animationController,
    required this.width,
    required this.height,
    required this.playTrack,
    required this.volumeValue,
    required this.volume
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height / 2.4,
      color: Colors.white,
      child: Stack(
        children: [

          Container(
              alignment: Alignment.topCenter,
              child: Text(
                  '${playTrack.name} 소리',
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.black,
                      fontWeight: FontWeight.w600
                  )
              )
          ),

          /*Positioned(
            top: 20,
            child:
          ),*/

          RotationTransition(
            turns: animationController,
            child: Container(
              alignment: Alignment.center,
              child: SvgPicture.asset(
                playTrack.imagePath,
                width: 100,
                height: 100,
                fit: BoxFit.contain,
                colorFilter:
                ColorFilter.mode(Colors.redAccent, BlendMode.srcATop),
              ),
            ),
          ),

          Positioned(
              left: 40,
              right: 40,
              bottom: 30,
              child: Slider(
                min: 0,
                max: 1,
                onChanged: (double value) {
                  // _setVolumeValue = value;
                  // VolumeController().setVolume(_setVolumeValue);
                  // setState(() {});
                  volume(value);
                  print('>>>>>>>>>>>>>>>>>>>> volumeValue :${value}');
                },
                value: volumeValue,
              ),
          )

        ],
      )
    );
  }
}
