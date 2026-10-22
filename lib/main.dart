import 'package:flutter/material.dart';

void main() {
  runApp(const DeenApp());
}

/// Root widget of the application
class DeenApp extends StatelessWidget {
  const DeenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Deen',
      home: Scaffold(body: Center(child: Text('Deen App Skeleton Ready'))),
    );
  }
}
