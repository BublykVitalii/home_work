import 'package:flutter/material.dart';

import 'package:user_manager/user.dart';
import 'package:user_manager/user_cars_screen.dart';
import 'package:user_manager/user_info_screen.dart';
import 'package:user_manager/user_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final List<User> users;
  final userService = UserService();
  @override
  void initState() {
    users = userService.users;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User'),
      ),
      drawer: Drawer(
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
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Container(
              height: 2,
              color: Colors.grey.shade200,
            ),
            ListTile(
              title: const Text('Cars'),
              onTap: () {
                final cars = userService.getListCars();
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (context) => UserCars(
                      userCars: cars,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
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

class UserTiles extends StatelessWidget {
  final List<User> users;
  final ValueChanged<User> onPressed;
  final UserService service;
  final Function(User user, int index) onChangedUser;

  const UserTiles({
    Key? key,
    required this.users,
    required this.onPressed,
    required this.service,
    required this.onChangedUser,
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
                    service: service,
                    onUpdate: (user) {
                      onChangedUser(user, index);
                    }),
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

class AddUserDialog extends StatelessWidget {
  final ValueChanged<User> onAdd;
  final int usersLength;

  const AddUserDialog({
    Key? key,
    required this.onAdd,
    required this.usersLength,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String firstName = '';
    String lastName = '';

    final _formKey = GlobalKey<FormState>();
    return AlertDialog(
      title: const Center(
        child: Text('Add user'),
      ),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter first name';
                  }
                  return null;
                },
                onChanged: (text) {
                  firstName = text;
                },
                decoration: const InputDecoration(
                  label: Text('First name'),
                ),
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter last name';
                  }
                  return null;
                },
                onChanged: (text) {
                  lastName = text;
                },
                decoration: const InputDecoration(
                  label: Text('Last name'),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Cancel'),
          onPressed: () => Navigator.pop(context),
        ),
        TextButton(
          child: const Text('Add'),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              onAdd(
                User(
                  firstName: firstName,
                  lastName: lastName,
                  cars: [],
                  id: usersLength + 1,
                ),
              );
              Navigator.pop(context);
            }
          },
        ),
      ],
    );
  }
}
