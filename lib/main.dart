import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'bindings/global_binding.dart';
import 'controllers/alice_controller.dart';
import 'controllers/logger_controller.dart';
import 'pages.dart';
import 'screens/home/home_screen.dart';
import 'strings.dart';
import 'theme.dart';

void main() {
  Get
    ..put(AliceController())
    ..put(LoggerController());
  runApp(NovinarkoApp());
}

class NovinarkoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ScreenUtilInit(
        builder: () => GetMaterialApp(
          title: 'Novinarko',
          navigatorKey: Get.find<AliceController>().alice.getNavigatorKey(),
          theme: theme,
          initialBinding: GlobalBinding(),
          initialRoute: HomeScreen.routeName,
          translations: Strings(),
          locale: Get.deviceLocale,
          fallbackLocale: const Locale('en_US'),
          getPages: pages,
        ),
      );
}
