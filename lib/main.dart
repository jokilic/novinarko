import 'package:flutter/material.dart';

void main() => runApp(NovinarkoApp());

class NovinarkoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Novinarko',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: HomeScreen(),
      );
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => const Center(
        child: Text('Hello there'),
      );
}
