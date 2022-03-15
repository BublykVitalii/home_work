import 'package:flutter/material.dart';
import 'package:user_manager/features/user/cubit/user_cubit.dart';
import 'package:user_manager/models/user_service.dart';
import 'package:user_manager/features/user/user_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return BlocProvider(
      create: (context) => UserCubit(),
      child: MaterialApp(
        home: UserScreen(
          userService: userService,
        ),
      ),
    );
  }
}
