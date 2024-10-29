
import 'package:audio_service/audio_service.dart';
import 'package:audio_session/audio_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:volume_controller/volume_controller.dart';
import 'package:whitedream/home/enum/audio_state.dart';
import 'package:whitedream/home/w_list.dart';
import 'package:whitedream/home/w_play.dart';

class HomeScreen extends StatefulWidget {

  //final AudioHandler audioHandler;

  const HomeScreen({
    super.key,
    //required this.audioHandler
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin{

  late AudioPlayer _audioPlayer;
  late AnimationController _animationController;
  late PlayTrack _playTrack;

  double _setVolumeValue = 0;

  @override
  void initState() {
    super.initState();
    _playTrack = PlayTrack.water;
    _audioPlayer = AudioPlayer();
    _initVolume();
    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 10));
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _animationController.dispose();
    VolumeController().removeListener();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('WiteDream'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

            PlayWidget(
              width: width,
              height: height,
              animationController: _animationController,
              playTrack: _playTrack,
              volumeValue: _setVolumeValue,
              volume: (volume) {
                setState(() {
                  _setVolumeValue = volume;
                });

                VolumeController().setVolume(_setVolumeValue);
              },
            ),

            Expanded(
                child: ListWidget(
                  onPress: (track) {
                    setState(() {
                      _playTrack = track;
                    });

                    // widget.audioHandler.customAction('playFromAsset', {'assetPath': _playTrack.assetsPath});
                    _playAudio(_playTrack.assetsPath);
                  },
                )
            )
          ],
        ),
      ),
    );
  }


  Future<void> _initAudioService() async {
    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration.music());

    _audioPlayer = AudioPlayer();

   // await AudioService.s
  }

  // 볼륨
  Future<void> _initVolume() async {
    VolumeController().showSystemUI = true;
    VolumeController().listener((volume) {

    });
    await VolumeController().getVolume().then((volume) => _setVolumeValue = volume);

  }

  Future<void> _playAudio(String assetsPath) async {
    try{

      if(_audioPlayer.playing){
        _stopAudio();
      }

      await _audioPlayer.setAudioSource(AudioSource.asset(assetsPath));
      _audioPlayer.play();
      _animationController.repeat();

    }catch (e) {
      print('Error~~ playAudio ');
    }
  }

  void _pauseAudio(){
    _audioPlayer.pause();
    _animationController.stop();
  }

  void _stopAudio(){
    _audioPlayer.stop();
    _audioPlayer.dispose();
    _animationController.stop();
  }

}
