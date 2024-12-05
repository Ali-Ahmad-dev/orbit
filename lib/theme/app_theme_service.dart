import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AppThemeService {
  final _box = GetStorage();
  final _key = 'isLightTheme';

  ThemeMode get theme => _loadThemeFromBox() ? ThemeMode.light : ThemeMode.dark;

  bool _loadThemeFromBox() => _box.read(_key) ?? true;

  _saveThemeToBox(bool isLightTheme) => _box.write(_key, isLightTheme);

  void switchTheme() {
    Get.changeThemeMode(_loadThemeFromBox() ? ThemeMode.dark : ThemeMode.light);
    _saveThemeToBox(!_loadThemeFromBox());
  }
}
