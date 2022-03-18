import 'package:flutter/material.dart';

class Charts extends StatelessWidget {
  const Charts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: const Card(
        color: Colors.blue,
        child: Text('Charts', style: TextStyle(fontSize: 28)),
        elevation: 8,
      ),
    );
  }
}
