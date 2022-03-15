import 'package:flutter/material.dart';
import 'package:user_manager/features/user/user_screen.dart';
import 'package:user_manager/models/user_service.dart';
import 'package:user_manager/features/user_cars_screen.dart';

class DrawerMenu extends StatefulWidget {
  final UserService userService;
  DrawerMenu({
    Key? key,
    required this.userService,
  }) : super(key: key);

  @override
  State<DrawerMenu> createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Drawer Header'),
          ),
          ListTile(
            title: const Text('User'),
            onTap: () => _onTapDrawer(
              UserScreen.getRoute(widget.userService),
            ),
          ),
          Container(
            height: 2,
            color: Colors.grey.shade200,
          ),
          ListTile(
            title: const Text('Cars'),
            onTap: () => _onTapDrawer(
              UserCars.getRoute(widget.userService),
            ),
          ),
        ],
      ),
    );
  }

  void _onTapDrawer(PageRoute route) {
    final currentRoute = ModalRoute.of(context);

    if (currentRoute?.settings.name != route.settings.name) {
      Navigator.of(context)
        ..pop()
        ..pushAndRemoveUntil<void>(route, (route) => false);
    } else {
      Navigator.of(context).pop();
    }
  }
}
