import 'package:easy_localization/easy_localization.dart';

import '../models/feed_model.dart';

String getFolderFeedsDescription(List<FeedModel>? feeds) {
  if (feeds == null || feeds.isEmpty) {
    return 'folderDialogNoFeedsInFolder'.tr();
  }

  return feeds
      .map(
        (feed) {
          final title = feed.siteName ?? feed.title;
          if (title?.isNotEmpty ?? false) {
            return title;
          }
          return null;
        },
      )
      .join(', ');
}
