import 'package:flutter/material.dart';
import 'package:flutter_assessment/core/router/app_route.dart';

void main() {
  runApp(const MainApp());
}

final _route = router;

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _route,
    );
  }
}
