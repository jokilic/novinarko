import 'dart:io';

import 'package:path_provider/path_provider.dart';

Future<Directory?> getHiveDirectory() async {
  if (Platform.isAndroid || Platform.isIOS) {
    final directory = await getApplicationDocumentsDirectory();
    return directory;
  }

  if (Platform.isMacOS) {
    final directory = await getLibraryDirectory();
    return directory;
  }

  return null;
}
