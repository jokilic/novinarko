import 'package:get/get.dart';

import 'bindings/home_binding.dart';
import 'screens/home/home_screen.dart';

final pages = <GetPage>[
  GetPage(
    name: HomeScreen.routeName,
    page: () => HomeScreen(),
    binding: HomeBinding(),
  ),
];
