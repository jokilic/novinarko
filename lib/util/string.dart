import 'package:easy_localization/easy_localization.dart';

import '../models/feed_model.dart';

String getFolderFeedsDescription(List<FeedModel>? feeds) {
  if (feeds == null || feeds.isEmpty) {
    return 'folderDialogNoFeedsInFolder'.tr();
  }

  final buffer = StringBuffer();
  var shown = 0;

  for (final feed in feeds) {
    final name = feed.siteName ?? feed.title ?? feed.url ?? '';

    if (name.isEmpty) {
      continue;
    }

    if (shown > 0) {
      buffer.write(', ');
    }

    buffer.write(name);
    shown++;

    if (shown == 3) {
      break;
    }
  }

  if (shown == 0) {
    return 'folderDialogNoFeedsInFolder'.tr();
  }

  if (feeds.length > 3) {
    buffer.write(', ...');
  }

  return buffer.toString();
}
