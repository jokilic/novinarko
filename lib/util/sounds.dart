import 'package:just_audio/just_audio.dart';

import 'sentry.dart';

/// Plays the `Welcome to Novinarko` sound when long pressing the [Novinarko] icon
Future<void> playWelcomeToNovinarko() async {
  triggerSentryBreadcrumb(
    message: 'Settings -> Sound triggered',
  );

  final player = AudioPlayer();
  await player.setAsset(
    'assets/audio/welcome_to_novinarko.mp3',
  );
  await player.play();
  await player.dispose();
}
