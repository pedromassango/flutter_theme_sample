import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static StreamController<UserPreferences> _controller =
      StreamController.broadcast();

  final Stream<UserPreferences> stream = _controller.stream;
  final SharedPreferences _preferences;

  UserPreferences(this._preferences);

  final _usesDarkTheme = '_usesDarkTheme';
  Future useDartTheme(bool value) async {
    await _preferences.setBool(_usesDarkTheme, value);
    _controller.add(this);
  }

  bool usesDarkTheme() {
    return _preferences.getBool(_usesDarkTheme) ?? false;
  }
}
