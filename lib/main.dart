import 'package:flutter/material.dart';
import 'package:user_manager/class/user_service.dart';
import 'package:user_manager/screens/user_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final userService = UserService();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: UserScreen(
        userService: userService,
      ),
    );
  }
}
