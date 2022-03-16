import 'package:flutter/material.dart';
import 'package:user_manager/models/user.dart';

import 'package:user_manager/features/user/user_info_screen.dart';

class UserTiles extends StatelessWidget {
  final List<User> users;
  final ValueChanged<User> onPressed;

  const UserTiles({
    Key? key,
    required this.users,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        return ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (context) => UserInfoScreen(
                  user: user,
                ),
              ),
            );
          },
          leading: const Icon(Icons.account_box),
          title: Text(
            user.fullName,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: IconButton(
            onPressed: () => onPressed(user),
            icon: const Icon(Icons.delete),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(
          color: Colors.black54,
        );
      },
    );
  }
}
