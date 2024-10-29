

enum PlayTrack {
  water('물', 'assets/audios/underwater-95592.mp3', 'assets/icons/ic_wish_line_s.svg'),
  hairDryer('헤어 드라이기', 'assets/audios/wall-air-conditioner-43901.mp3', 'assets/icons/ic_insta_line_r.svg'),
  washingMachine('세탁기', 'assets/audios/waterfall-68094.mp3', ''),
  vacuumCleaner('청소기', '', ''),
  rain('비', '', ''),
  bird('새', '', ''),
  fire('불', '', '');

  final String name;
  final String assetsPath;
  final String imagePath;

  const PlayTrack(this.name, this.assetsPath, this.imagePath);
}

enum AudioState {
  play,
  stop,
  pause
}