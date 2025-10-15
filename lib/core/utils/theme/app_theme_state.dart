import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_theme_state.g.dart';

@riverpod
class AppThemeState extends _$AppThemeState {

  @override
  ThemeMode build() {
    return ThemeMode.light;
  }

  void changeTheme(bool isOn) {
    state = isOn ? ThemeMode.dark : ThemeMode.light;
  }
}
