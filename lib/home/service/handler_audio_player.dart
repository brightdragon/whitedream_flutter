
import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

class AudioPlayerHandler extends BaseAudioHandler with QueueHandler, SeekHandler {

  final _audioPlayer = AudioPlayer();

  AudioPlayerHandler(){
    _init();
  }

  Future<void> _init() async {
    // audio player 초기화
    // await _audioPlayer.s
    _audioPlayer.playbackEventStream.listen((event){
      final playing = _audioPlayer.playing;
      playbackState.add(playbackState.value.copyWith(
        controls: [
          MediaControl.play,
          MediaControl.pause,
          MediaControl.stop
        ],
        playing: playing,
        processingState: AudioProcessingState.ready
      ));
    });
  }

  Future<void> playFromAsset(String assetPath) async {
    await _audioPlayer.setAsset(assetPath);
    play();
  }

  @override
  Future<void> play() {
    return _audioPlayer.play();
  }

  @override
  Future<void> stop() async {
    await _audioPlayer.stop();
    await super.stop();
  }

  @override
  Future<void> pause() {
    return _audioPlayer.pause();
  }

  @override
  Future customAction(String name, [Map<String, dynamic>? extras]) async {
    if(name == 'playFromAsset') {
      final assetPath = extras?['assetPath'] as String;
      return playFromAsset(assetPath);
    }

    return super.customAction(name, extras);
  }
}