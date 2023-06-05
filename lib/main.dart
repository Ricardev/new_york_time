import 'package:flutter/material.dart';
import 'package:new_york_time_api/core/config/injector.dart' as setup;
import 'package:new_york_time_api/core/routes.dart';
import 'package:new_york_time_api/features/splash/presentation/pages/slash_page.dart';

void main() {
  setup.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: AppRoutes.routes,
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashPage(),
    );
  }
}
