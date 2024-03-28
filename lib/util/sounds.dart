import 'package:just_audio/just_audio.dart';

/// Plays the `boom-baby` sound when long pressing the [Novinarko] icon
Future<void> playBoomBaby() async {
  final player = AudioPlayer();
  await player.setAsset(
    'assets/audio/boom.wav',
  );
  await player.play();
  await player.dispose();
}
