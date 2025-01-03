import 'package:just_audio/just_audio.dart';

/// Plays the `Welcome to Novinarko` sound when long pressing the [Novinarko] icon
Future<void> playWelcomeToNovinarko() async {
  final player = AudioPlayer();
  await player.setAsset(
    'assets/audio/welcome_to_novinarko.mp3',
  );
  await player.play();
  await player.dispose();
}
