import 'package:alice_lightweight/alice.dart';
import 'package:get/get.dart';

class AliceController extends GetxController {
  /// ------------------------
  /// VARIABLES
  /// ------------------------

  late final Alice _alice;

  /// ------------------------
  /// GETTERS
  /// ------------------------

  Alice get alice => _alice;

  /// ------------------------
  /// SETTERS
  /// ------------------------

  set alice(Alice value) => _alice = value;

  /// ------------------------
  /// INIT
  /// ------------------------

  @override
  void onInit() {
    super.onInit();
    alice = Alice(darkTheme: true);
  }

  /// ------------------------
  /// METHODS
  /// ------------------------

  void showAliceInspector() => alice.showInspector();
}
