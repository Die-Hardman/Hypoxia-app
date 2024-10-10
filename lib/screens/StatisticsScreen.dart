import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StatisticsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Statistics'),
      ),
      body: Center(
        child: Text(
          'Statistics Screen',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}