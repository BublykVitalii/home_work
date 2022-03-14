import 'package:flutter/material.dart';
import 'package:user_manager/class/car.dart';
import 'package:user_manager/class/user.dart';

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
