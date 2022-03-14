import 'package:flutter/material.dart';

import 'package:user_manager/class/user.dart';
import 'package:user_manager/class/user_service.dart';

import 'package:user_manager/widgets/drawer_menu_widget.dart';
import 'package:user_manager/widgets/user_screen_add_user_dialog_widget.dart';
import 'package:user_manager/widgets/user_screen_no_user_tiles_widget.dart';
import 'package:user_manager/widgets/user_screen_user_tiles_widget.dart';

class UserScreen extends StatefulWidget {
  final UserService userService;
  const UserScreen({
    Key? key,
    required this.userService,
  }) : super(key: key);
  static const _routeName = '/';

  static MaterialPageRoute getRoute(UserService userService) {
    return MaterialPageRoute<Object>(
      settings: const RouteSettings(name: _routeName),
      builder: (_) => UserScreen(
        userService: userService,
      ),
    );
  }

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  late final List<User> users;
  late final UserService userService;
  @override
  void initState() {
    userService = widget.userService;
    users = userService.users;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerMenu(
        userService: userService,
      ),
      appBar: AppBar(
        title: const Text('User'),
      ),
      body: users.isNotEmpty
          ? UserTiles(
              users: users,
              onPressed: (user) {
                setState(() => userService.deleteUser(user));
              },
              service: userService,
              onChangedUser: (User value, i) {
                setState(() => userService.updatedUser(value));
              },
            )
          : NoUsersTiles(title: 'No Users'),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog<String>(
          context: context,
          builder: (BuildContext context) => AddUserDialog(
            onAdd: (value) {
              setState(() => userService.addUser(value));
            },
            usersLength: userService.users.length,
          ),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
