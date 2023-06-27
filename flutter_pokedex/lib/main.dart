import 'package:flutter/material.dart';
import 'package:flutter_pokedex/pages/details.dart';
import 'package:flutter_pokedex/pages/search.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SearchPage(),
        '/details': (context) => const Details(),
      },
    );
  }
}
