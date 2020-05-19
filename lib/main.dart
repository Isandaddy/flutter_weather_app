import 'package:flutter/material.dart';
import 'package:flutter_weather_app/screens/loading_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Weather App',
      theme: ThemeData.dark(),
      home: LoadingScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
