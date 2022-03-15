import 'package:flutter/material.dart';
import 'package:user_manager/models/user.dart';

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
