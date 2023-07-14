import 'package:flutter/material.dart';

import 'screens/view_report_screen.dart';
import 'screens/create_report_screen.dart';
import 'screens/map_screen.dart';

class App extends StatelessWidget {
  static final routes = {
    MapScreen.routeName: (context) => const MapScreen(),
    CreateReportScreen.routeName: (context) => const CreateReportScreen(),
    ViewReportScreen.routeName: (context) => const ViewReportScreen(),
  };

  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ocean Change',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: App.routes,
    );
  }
}
