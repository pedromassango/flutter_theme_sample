import 'package:build_context/build_context.dart';
import 'package:flutter/material.dart';
import 'package:ftest/settings_page.dart';
import 'package:ftest/user_preferences.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final sharedPreferences = await SharedPreferences.getInstance();

  runApp(MyApp(preferences: sharedPreferences));
}

class MyApp extends StatefulWidget {
  final SharedPreferences preferences;

  const MyApp({
    Key key,
    this.preferences,
  })  : assert(preferences != null),
        super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  UserPreferences _userPreferences;

  @override
  void initState() {
    _userPreferences = UserPreferences(widget.preferences);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Provider<UserPreferences>.value(
      value: _userPreferences,
      child: StreamBuilder<UserPreferences>(
        initialData: _userPreferences,
        stream: _userPreferences.stream,
        builder: (context, shot) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(primarySwatch: Colors.blue),
            darkTheme: ThemeData.dark(),
            themeMode:
                shot.data.usesDarkTheme() ? ThemeMode.dark : ThemeMode.light,
            home: MyHomePage(),
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Página Inicial'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              context.push(SettingsPage.route());
            },
          )
        ],
      ),
      body: ListView.builder(
        itemCount: Colors.primaries.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Container(
              height: 30,
              width: 30,
              color: Colors.primaries.elementAt(index),
            ),
            title: Text('Item $index'),
            subtitle: Text(Colors.primaries.elementAt(index).toString()),
          );
        },
      ),
    );
  }
}
