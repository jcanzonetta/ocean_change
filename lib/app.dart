import 'package:flutter/material.dart';

import 'screens/map_screen.dart';

class App extends StatelessWidget {
  static final routes = {
    MapScreen.routeName: (context) => const MapScreen(),
  };

  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wasteagram',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: App.routes,
    );
  }
}
