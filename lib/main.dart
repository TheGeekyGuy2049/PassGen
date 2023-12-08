import 'package:flutter/material.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:passgen/pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final _defaultLightColorScheme =
  ColorScheme.fromSwatch(primarySwatch: Colors.blue);

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(builder: (lightColorScheme, darkColorScheme) {
      return MaterialApp(
          theme: ThemeData(
            colorScheme: darkColorScheme ?? _defaultLightColorScheme,
            useMaterial3: true,
          ),
          home: const Navigation()
      );
    }
    );
  }
}
