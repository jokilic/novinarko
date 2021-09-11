import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StorageController extends GetxController {
  /// ------------------------
  /// VARIABLES
  /// ------------------------

  late final GetStorage _storageBox;

  /// ------------------------
  /// GETTERS
  /// ------------------------

  GetStorage get storageBox => _storageBox;

  /// ------------------------
  /// SETTERS
  /// ------------------------

  set storageBox(GetStorage value) => _storageBox = value;

  /// ------------------------
  /// INIT
  /// ------------------------

  @override
  Future<void> onInit() async {
    super.onInit();
    storageBox = GetStorage();
  }

  /// ------------------------
  /// METHODS
  /// ------------------------

  /// Delete everything from Storage
  Future<void> deleteAll() async => storageBox.erase();
}
