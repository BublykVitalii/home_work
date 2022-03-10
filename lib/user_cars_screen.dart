import 'package:flutter/material.dart';
import 'package:user_manager/main.dart';

class UserCars extends StatelessWidget {
  const UserCars({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute<void>(builder: (context) => const MyApp()),
            );
          },
        ),
        title: const Text('User Cars'),
      ),
      body: SafeArea(
        child: UserCarsList(),
      ),
    );
  }
}

class UserCarsList extends StatelessWidget {
  const UserCarsList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListTile(
        leading: Container(
          height: 50,
          width: 50,
          decoration: const BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.all(
              Radius.circular(100),
            ),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('BMW'),
            Row(
              children: [
                Icon(Icons.account_box),
                Text('Vlad Kononenko'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
