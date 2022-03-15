import 'package:flutter/material.dart';
import 'package:user_manager/models/car.dart';

class UserInfoAddDialog extends StatelessWidget {
  final ValueChanged<Car> onAdd;
  UserInfoAddDialog({
    Key? key,
    required this.onAdd,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String name = '';
    String color = '';
    final _formKey = GlobalKey<FormState>();
    return AlertDialog(
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter name car';
                  }
                  return null;
                },
                onChanged: (text) {
                  name = text;
                },
                decoration: const InputDecoration(
                  label: Text('Name car'),
                ),
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter color car';
                  }
                  return null;
                },
                onChanged: (text) {
                  color = text;
                },
                decoration: const InputDecoration(
                  label: Text('Color car'),
                ),
              ),
            ],
          ),
        ),
      ),
      title: const Center(
        child: Text('Add cars'),
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
              onAdd(Car(name: name, color: color, owner: ''));
              Navigator.pop(context);
            }
          },
        ),
      ],
    );
  }
}
