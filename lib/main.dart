import 'package:flutter/material.dart';

import 'package:user_manager/user_info.dart';
import 'package:user_manager/user_service.dart';

import 'user.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'User'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

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
        title: Text(widget.title),
      ),
      body: users.isNotEmpty
          ? UserTiles(
              users: users,
              onPressed: (user) {
                setState(() => userService.deleteUser(user));
              },
            )
          : NoUsersTiles(title: 'No Users'),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog<String>(
          context: context,
          builder: (BuildContext context) => AddUser(
            onAdd: (value) {
              setState(() => userService.addUser(value));
            },
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
                builder: (context) => UserInfo(
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

class AddUser extends StatelessWidget {
  final ValueChanged<User> onAdd;

  const AddUser({Key? key, required this.onAdd}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String firstName = '';
    String lastName = '';
    return AlertDialog(
      title: const Center(
        child: Text('Add user'),
      ),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              onChanged: (text) {
                firstName = text;
              },
              decoration: const InputDecoration(
                label: Text('First name'),
              ),
            ),
            TextField(
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
      actions: <Widget>[
        TextButton(
          child: const Text('Cancel'),
          onPressed: () => Navigator.pop(context),
        ),
        TextButton(
          child: const Text('Add'),
          onPressed: () {
            onAdd(
              User(
                firstName: firstName,
                lastName: lastName,
                age: 25,
                cars: [Car(name: '', color: '')],
                height: 173,
                phone: 380661231236,
                sex: Sex.male,
                weight: 63,
              ),
            );
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}

// что бы создать обьект нам достаточно написать название класса и открыть круглые скобки)



//  возрост/пол/вес/телефон/ФИ/машины