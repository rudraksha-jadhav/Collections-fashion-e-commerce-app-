import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Collections App',
      theme: ThemeData.light(),
      home: const Scaffold(
        body: Center(
          child: Text('Welcome to Collections'),
        ),
      ),
    );
  }
}
