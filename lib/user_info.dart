import 'package:flutter/material.dart';

import 'package:user_manager/main.dart';
import 'package:user_manager/user_service.dart';

import 'user.dart';

class UserInfo extends StatefulWidget {
  final User user;
  final ValueChanged<User> onAdd;
  const UserInfo({
    Key? key,
    required this.user,
    required this.onAdd,
  }) : super(key: key);

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  String firstNameChanged = '';
  String lastNameChanged = '';
  String phoneChanged = '';
  String ageChanged = '';
  String heightChanged = '';
  String weightChanged = '';
  String sexChanged = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User info'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              widget.onAdd(
                User(
                  firstName: firstNameChanged.isNotEmpty
                      ? firstNameChanged
                      : widget.user.firstName,
                  lastName: lastNameChanged.isNotEmpty
                      ? lastNameChanged
                      : widget.user.lastName,
                  age: ageChanged.isNotEmpty
                      ? int.tryParse(ageChanged)
                      : widget.user.age,
                  phone: phoneChanged.isNotEmpty
                      ? int.tryParse(phoneChanged)
                      : widget.user.phone,
                  height: heightChanged.isNotEmpty
                      ? int.tryParse(heightChanged)
                      : widget.user.height,
                  weight: weightChanged.isNotEmpty
                      ? int.tryParse(weightChanged)
                      : widget.user.weight,
                  cars: [Car(name: '', color: '')],
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
              onChangedText: (String value) {
                firstNameChanged = value;
              },
              initialText: widget.user.firstName,
              textHint: 'name',
            ),
            TextFieldWidget(
              onChangedText: (String value) {
                lastNameChanged = value;
              },
              initialText: widget.user.lastName,
              textHint: 'name',
            ),
            TextFieldWidget(
              onChangedText: (String value) {
                phoneChanged = value;
              },
              initialText: widget.user.phone?.toString(),
              textHint: 'number phone',
            ),
            TextFieldWidget(
              onChangedText: (String value) {
                ageChanged = value;
              },
              initialText: widget.user.age?.toString(),
              textHint: 'age',
            ),
            TextFieldWidget(
              onChangedText: (String value) {
                heightChanged = value;
              },
              initialText: widget.user.height?.toString(),
              textHint: 'height',
            ),
            TextFieldWidget(
              onChangedText: (String value) {
                weightChanged = value;
              },
              initialText: widget.user.weight?.toString(),
              textHint: 'weight',
            ),
            Flexible(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  final car = widget.user.cars[index];
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextWidget(
                            title: 'Name car:',
                            text: ' ${car.name}',
                          ),
                          TextWidget(
                            title: 'Color car:',
                            text: ' ${car.color}',
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() => widget.user.deleteCar(car));
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
                itemCount: widget.user.cars.length,
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
          builder: (BuildContext context) => AddCars(
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

class TextFieldWidget extends StatefulWidget {
  TextFieldWidget({
    Key? key,
    this.initialText,
    required this.textHint,
    required this.onChangedText,
  }) : super(key: key);
  final String? initialText;
  final String textHint;

  final ValueChanged<String> onChangedText;

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  late TextEditingController _controller;

  void _onListen() {
    _controller.addListener(() {});
  }

  void _onButtomTap() {
    _controller.addListener(() {
      _onListen();
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = new TextEditingController(text: widget.initialText);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: TextFormField(
        controller: _controller,
        onChanged: ((value) => widget.onChangedText(value)),
        style: const TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        decoration: InputDecoration(
          isDense: true,
          hintText: '${widget.textHint}',
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

class AddCars extends StatelessWidget {
  String nameCar = '';
  String colorCar = '';
  final ValueChanged<Car> onAdd;
  AddCars({
    Key? key,
    required this.onAdd,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              onChanged: (text) {
                nameCar = text;
              },
              decoration: const InputDecoration(
                label: Text('Name car'),
              ),
            ),
            TextField(
              onChanged: (text) {
                colorCar = text;
              },
              decoration: const InputDecoration(
                label: Text('Color car'),
              ),
            ),
          ],
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
            onAdd(Car(name: nameCar, color: colorCar));
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
