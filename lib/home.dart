import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final String userId;

  HomeScreen({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Center(child: Text('Welcome, User ID: $userId')),
    );
  }
}
