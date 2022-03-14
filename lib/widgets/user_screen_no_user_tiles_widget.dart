import 'package:flutter/material.dart';

class NoUsersTiles extends StatelessWidget {
  final String title;
  NoUsersTiles({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        title,
        style: const TextStyle(fontSize: 25),
      ),
    );
  }
}
