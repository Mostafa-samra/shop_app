import 'package:flutter/material.dart';
import 'package:shop_app/modules/onboring/onborging_screen.dart';
import 'package:shop_app/sheard/styles/themes/dark_themes.dart';
import 'package:shop_app/sheard/styles/themes/light_themes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shop App',
      theme: lightThemes,
      darkTheme: darkThemes,
      themeMode: ThemeMode.light,
      home: const OnBordingScreen(),
    );
  }
}
