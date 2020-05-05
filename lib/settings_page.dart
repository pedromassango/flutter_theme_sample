import 'package:flutter/material.dart';
import 'package:ftest/user_preferences.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  static MaterialPageRoute route() {
    return MaterialPageRoute(builder: (_) => SettingsPage());
  }

  @override
  Widget build(BuildContext context) {
    final userPrefs = Provider.of<UserPreferences>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.only(top: 8),
        children: <Widget>[
          SwitchListTile(
            title: Text('Dart Theme'),
            subtitle: Text(
                'Quando activado o tema da app sera definido para team escuro!'),
            onChanged: (value) {
              userPrefs.useDartTheme(value);
            },
            value: userPrefs.usesDarkTheme(),
          ),
        ],
      ),
    );
  }
}
