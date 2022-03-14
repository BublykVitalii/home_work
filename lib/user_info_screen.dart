import 'package:flutter/material.dart';

import 'package:user_manager/user.dart';
import 'package:user_manager/user_service.dart';

class UserInfoScreen extends StatefulWidget {
  final User user;
  final ValueChanged<User> onUpdate;
  final UserService service;

  const UserInfoScreen({
    Key? key,
    required this.user,
    required this.onUpdate,
    required this.service,
  }) : super(key: key);

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  String firstName = '';
  String lastName = '';
  String? phone;
  int? age;
  double? height;
  double? weight;
  Sex? sex;
  List<Car>? cars;

  @override
  void initState() {
    firstName = widget.user.firstName;
    lastName = widget.user.lastName;
    age = widget.user.age;
    phone = widget.user.phone;
    height = widget.user.height;
    weight = widget.user.weight;
    cars = widget.user.cars;
    sex = widget.user.sex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User info'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              // widget.service.updatedUser
              widget.onUpdate(
                User(
                  firstName: firstName,
                  lastName: lastName,
                  age: age,
                  phone: phone,
                  height: height,
                  weight: weight,
                  cars: cars,
                  sex: sex,
                  id: widget.user.id,
                ),
              );
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 150,
              width: 150,
              child: Image.asset('assets/images/image.png'),
            ),
            TextFieldWidget(
              onChangedText: (value) {
                firstName = value;
              },
              initialText: firstName,
              textHint: 'name',
            ),
            TextFieldWidget(
              onChangedText: (value) {
                lastName = value;
              },
              initialText: lastName,
              textHint: 'name',
            ),
            TextFieldWidget(
              onChangedText: (value) => phone = value,
              initialText: widget.user.phone,
              textHint: 'number phone',
            ),
            TextFieldWidget(
              onChangedText: (value) => age = int.tryParse(value),
              initialText: widget.user.age,
              textHint: 'age',
            ),
            TextFieldWidget(
              onChangedText: (value) => height = double.tryParse(value),
              initialText: widget.user.height,
              textHint: 'height',
            ),
            TextFieldWidget(
              onChangedText: (value) => weight = double.tryParse(value),
              initialText: widget.user.weight,
              textHint: 'weight',
            ),
            DropDown(
              initValue: sex,
              onChangedSex: (Sex value) => sex = value,
            ), // save update enum
            Flexible(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  final car = widget.user.cars?[index];
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextWidget(
                            title: 'Name car:',
                            text: ' ${car?.name}',
                          ),
                          TextWidget(
                            title: 'Color car:',
                            text: ' ${car?.color}',
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() => widget.user.deleteCar(car!));
                        },
                        icon: const Icon(Icons.delete),
                      ),
                    ],
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(
                    color: Colors.black54,
                  );
                },
                itemCount: widget.user.cars?.length ?? 0,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog<String>(
          context: context,
          builder: (BuildContext context) => AddCarDialog(
            onAdd: (car) {
              setState(
                () => widget.user.addCar(car),
              );
            },
          ),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class TextWidget extends StatelessWidget {
  const TextWidget({
    Key? key,
    required this.title,
    this.text,
  }) : super(key: key);

  final String title;
  final String? text;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text(
            '$title',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        if (text != null) ...{
          Text(
            text!,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
        },
      ],
    );
  }
}

class TextFieldWidget<T> extends StatelessWidget {
  TextFieldWidget({
    Key? key,
    this.initialText,
    required this.textHint,
    required this.onChangedText,
  }) : super(key: key);
  final T? initialText;
  final String textHint;

  final ValueChanged<String> onChangedText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: TextFormField(
        initialValue: initialText?.toString() ?? '',
        onChanged: ((value) => onChangedText(value)),
        style: const TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        decoration: InputDecoration(
          isDense: true,
          hintText: '${textHint}',
          hintStyle: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.normal,
          ),
          border: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.blue,
              width: 1.0,
            ),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.blue,
              width: 2.0,
              style: BorderStyle.solid,
            ),
          ),
        ),
        enabled: true,
      ),
    );
  }
}

class AddCarDialog extends StatelessWidget {
  final ValueChanged<Car> onAdd;
  AddCarDialog({
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

class DropDown extends StatefulWidget {
  const DropDown({
    Key? key,
    required this.initValue,
    required this.onChangedSex,
  }) : super(key: key);
  final Sex? initValue;
  final ValueChanged<Sex> onChangedSex;
  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  Sex? dropDownValue;
  @override
  void initState() {
    super.initState();
    if (widget.initValue != null) {
      dropDownValue = widget.initValue;
    }
  }

  var items = [
    Sex.female,
    Sex.male,
    Sex.other,
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0),
      child: DropdownButton<Sex>(
        isExpanded: true,
        value: dropDownValue ?? Sex.other,
        icon: const Icon(Icons.keyboard_arrow_down),
        items: items.map((Sex item) {
          return DropdownMenuItem(
            value: item,
            child: Text(
              User.parseEnumToString(item),
              style: const TextStyle(fontSize: 16),
            ),
          );
        }).toList(),
        onChanged: (newValue) {
          setState(() {
            dropDownValue = newValue;
          });
          widget.onChangedSex(newValue!);
        },
      ),
    );
  }
}
